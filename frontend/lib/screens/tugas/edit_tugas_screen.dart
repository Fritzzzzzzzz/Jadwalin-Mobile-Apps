import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../models/tugas_model.dart';
import '../../models/matkul_model.dart';
import '../../services/tugas_service.dart';
import '../../services/matkul_service.dart';

class EditTugasScreen extends StatefulWidget {
  final TugasModel tugas;

  const EditTugasScreen({super.key, required this.tugas});

  @override
  State<EditTugasScreen> createState() => _EditTugasScreenState();
}

class _EditTugasScreenState extends State<EditTugasScreen> {
  late TextEditingController judulController;

  late TextEditingController deskripsiController;

  MatkulModel? selectedMatkul;

  bool isLoadingMatkul = true;

  String selectedStatus = 'Belum Selesai';

  DateTime? selectedDeadline;

  List<MatkulModel> daftarMatkul = [];

  final List<String> daftarStatus = ['Belum Selesai', 'Selesai'];

  @override
  void initState() {
    super.initState();

    judulController = TextEditingController(text: widget.tugas.judul);

    deskripsiController = TextEditingController(text: widget.tugas.deskripsi);

    getMatkul();

    selectedStatus = widget.tugas.status;

    selectedDeadline = DateTime.now();
  }

  @override
  void dispose() {
    judulController.dispose();

    deskripsiController.dispose();

    super.dispose();
  }

  Future<void> getMatkul() async {
    try {
      final matkul = await MatkulService().getMatkul();

      setState(() {
        daftarMatkul = matkul;

        selectedMatkul = matkul.firstWhere(
          (e) => e.id == widget.tugas.matkulId,
        );
      });
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
    } finally {
      setState(() {
        isLoadingMatkul = false;
      });
    }
  }

  Future pilihTanggal() async {
    final result = await showDatePicker(
      context: context,

      initialDate: selectedDeadline ?? DateTime.now(),

      firstDate: DateTime(2025),

      lastDate: DateTime(2100),
    );

    if (result != null) {
      setState(() {
        selectedDeadline = result;
      });
    }
  }

  String get deadlineText {
    if (selectedDeadline == null) {
      return 'Pilih Deadline';
    }

    return '${selectedDeadline!.day}/'
        '${selectedDeadline!.month}/'
        '${selectedDeadline!.year}';
  }

  Future<void> simpan() async {
    if (selectedMatkul == null) return;

    try {
      final tugas = TugasModel(
        id: widget.tugas.id,

        matkulId: selectedMatkul!.id!,

        namaMatkul: selectedMatkul!.nama,

        judul: judulController.text,

        deskripsi: deskripsiController.text.trim().isEmpty
            ? null
            : deskripsiController.text,

        deadline: deadlineText,

        status: selectedStatus,
      );

      await TugasService().editTugas(tugas);

      if (!mounted) return;

      Navigator.pop(context, true);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString().replaceFirst("Exception: ", ""))),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: Colors.white,

        elevation: 0,

        title: Text(
          'Edit Tugas',

          style: GoogleFonts.poppins(
            color: const Color(0xFF1A58B7),

            fontWeight: FontWeight.bold,
          ),
        ),

        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(1),

          child: Divider(height: 1),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),

        child: Container(
          padding: const EdgeInsets.all(16),

          decoration: BoxDecoration(
            color: const Color(0xFFF5F5F5),

            borderRadius: BorderRadius.circular(16),
          ),

          child: Column(
            children: [
              TextField(
                controller: judulController,

                decoration: input('Nama Tugas', Icons.task),
              ),

              const SizedBox(height: 16),

              isLoadingMatkul
                  ? const Center(child: CircularProgressIndicator())
                  : DropdownButtonFormField<MatkulModel>(
                      value: selectedMatkul,

                      decoration: input('Mata Kuliah', Icons.book),

                      items: daftarMatkul.map((matkul) {
                        return DropdownMenuItem(
                          value: matkul,

                          child: Text(matkul.nama),
                        );
                      }).toList(),

                      onChanged: (value) {
                        setState(() {
                          selectedMatkul = value;
                        });
                      },
                    ),

              const SizedBox(height: 16),

              TextField(
                controller: deskripsiController,

                maxLines: 3,

                decoration: input('Deskripsi', Icons.notes),
              ),

              const SizedBox(height: 16),

              TextField(
                readOnly: true,

                controller: TextEditingController(text: deadlineText),

                onTap: pilihTanggal,

                decoration: input('Deadline', Icons.calendar_today),
              ),

              const SizedBox(height: 16),

              DropdownButtonFormField(
                value: selectedStatus,

                decoration: input('Status', Icons.assignment_turned_in),

                items: daftarStatus.map((e) {
                  return DropdownMenuItem(value: e, child: Text(e));
                }).toList(),

                onChanged: (v) {
                  setState(() {
                    selectedStatus = v!;
                  });
                },
              ),

              const SizedBox(height: 24),

              Container(
                padding: const EdgeInsets.all(16),

                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.05),

                  borderRadius: BorderRadius.circular(12),
                ),

                child: Row(
                  children: [
                    const Icon(Icons.info, color: Color(0xFF1A58B7)),

                    const SizedBox(width: 12),

                    Expanded(
                      child: Text(
                        'Perubahan deadline akan memperbarui pengingat maksimal 3 hari sebelum deadline.',

                        style: GoogleFonts.poppins(fontSize: 13),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              SizedBox(
                width: double.infinity,

                height: 52,

                child: ElevatedButton.icon(
                  onPressed: simpan,

                  icon: const Icon(Icons.save),

                  label: Text(
                    'Simpan Perubahan',

                    style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
                  ),

                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1A58B7),

                    foregroundColor: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  InputDecoration input(String label, IconData icon) {
    return InputDecoration(
      labelText: label,

      prefixIcon: Icon(icon),

      filled: true,

      fillColor: Colors.white,

      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
    );
  }
}
