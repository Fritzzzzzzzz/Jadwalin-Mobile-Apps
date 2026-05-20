import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../models/tugas_model.dart';

class TambahTugasScreen extends StatefulWidget {
  const TambahTugasScreen({super.key});

  @override
  State<TambahTugasScreen> createState() => _TambahTugasScreenState();
}

class _TambahTugasScreenState extends State<TambahTugasScreen> {
  final judulController = TextEditingController();

  final deskripsiController = TextEditingController();

  List<String> daftarMatkul = [
    'Pemrograman Mobile',
    'Basis Data',
    'Struktur Data',
  ];

  List<String> daftarStatus = ['Belum Selesai', 'Selesai'];

  String? selectedMatkul;

  String selectedStatus = 'Belum Selesai';

  DateTime? selectedDeadline;

  @override
  void dispose() {
    judulController.dispose();

    deskripsiController.dispose();

    super.dispose();
  }

  Future<void> pilihTanggal() async {
    final result = await showDatePicker(
      context: context,

      initialDate: DateTime.now(),

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

  void simpanTugas() {
    if (selectedMatkul == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Pilih mata kuliah')));

      return;
    }

    if (judulController.text.trim().isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Judul tugas wajib diisi')));

      return;
    }

    if (selectedDeadline == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Pilih deadline')));

      return;
    }

    final tugasBaru = TugasModel(
      matkul: selectedMatkul!,

      judul: judulController.text,

      deskripsi: deskripsiController.text.trim().isEmpty
          ? null
          : deskripsiController.text,

      deadline: deadlineText,

      status: selectedStatus,
    );

    Navigator.pop(context, tugasBaru);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: Colors.white,

        elevation: 0,

        centerTitle: true,

        title: Text(
          'Tambah Tugas',

          style: GoogleFonts.poppins(
            color: const Color(0xFF1A58B7),

            fontWeight: FontWeight.bold,
          ),
        ),

        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },

          icon: const Icon(Icons.arrow_back),
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
              DropdownButtonFormField(
                value: selectedMatkul,

                decoration: inputDecoration('Mata Kuliah', Icons.book),

                items: daftarMatkul.map((e) {
                  return DropdownMenuItem(value: e, child: Text(e));
                }).toList(),

                onChanged: (v) {
                  setState(() {
                    selectedMatkul = v;
                  });
                },
              ),

              const SizedBox(height: 16),

              TextField(
                controller: judulController,

                decoration: inputDecoration('Judul Tugas', Icons.title),
              ),

              const SizedBox(height: 16),

              TextField(
                controller: deskripsiController,

                maxLines: 3,

                decoration: inputDecoration(
                  'Deskripsi (Opsional)',

                  Icons.notes,
                ),
              ),

              const SizedBox(height: 16),

              TextField(
                readOnly: true,

                controller: TextEditingController(text: deadlineText),

                onTap: pilihTanggal,

                decoration: inputDecoration('Deadline', Icons.calendar_today),
              ),

              const SizedBox(height: 16),

              DropdownButtonFormField(
                value: selectedStatus,

                decoration: inputDecoration('Status', Icons.flag),

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

              SizedBox(
                width: double.infinity,

                height: 52,

                child: ElevatedButton.icon(
                  onPressed: simpanTugas,

                  icon: const Icon(Icons.save),

                  label: Text(
                    'Simpan Tugas',

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

  InputDecoration inputDecoration(String hint, IconData icon) {
    return InputDecoration(
      labelText: hint,

      prefixIcon: Icon(icon),

      filled: true,

      fillColor: Colors.white,

      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
    );
  }
}
