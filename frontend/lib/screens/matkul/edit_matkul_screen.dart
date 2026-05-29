import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../models/matkul_model.dart';
import '../../services/matkul_service.dart';

class EditMatkulScreen extends StatefulWidget {
  final MatkulModel matkul;

  const EditMatkulScreen({super.key, required this.matkul});

  @override
  State<EditMatkulScreen> createState() => _EditMatkulScreenState();
}

class _EditMatkulScreenState extends State<EditMatkulScreen> {
  late TextEditingController namaMatkulController;

  late TextEditingController dosenController;

  String? selectedSemester;

  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    namaMatkulController = TextEditingController(text: widget.matkul.nama);

    dosenController = TextEditingController(text: widget.matkul.dosen);

    selectedSemester = widget.matkul.semester;
  }

  final List<String> daftarSemester = [
    'Semester 1',
    'Semester 2',
    'Semester 3',
    'Semester 4',
    'Semester 5',
    'Semester 6',
    'Semester 7',
    'Semester 8',
  ];

  Future<void> editMatkul() async {
    if (namaMatkulController.text.isEmpty ||
        dosenController.text.isEmpty ||
        selectedSemester == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Semua field wajib diisi")));

      return;
    }

    try {
      setState(() {
        isLoading = true;
      });

      final matkul = MatkulModel(
        id: widget.matkul.id,

        nama: namaMatkulController.text,

        dosen: dosenController.text,

        semester: selectedSemester!,
      );

      await MatkulService().editMatkul(matkul);

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Mata kuliah berhasil diperbarui")),
      );

      Navigator.pop(context, true);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString().replaceFirst("Exception: ", ""))),
      );
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,

        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },

          icon: const Icon(Icons.arrow_back, color: Colors.black87),
        ),

        title: Text(
          'Edit Mata Kuliah',

          style: GoogleFonts.poppins(
            color: const Color(0xFF1A58B7),
            fontWeight: FontWeight.bold,
          ),
        ),

        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),

          child: Container(height: 1, color: const Color(0xFFE0E0E0)),
        ),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              // ICON
              Center(
                child: Container(
                  width: 96,
                  height: 96,

                  decoration: BoxDecoration(
                    color: const Color(0xFF1A58B7).withOpacity(0.1),

                    shape: BoxShape.circle,
                  ),

                  child: const Icon(
                    Icons.edit_note,
                    size: 48,
                    color: Color(0xFF1A58B7),
                  ),
                ),
              ),

              const SizedBox(height: 32),

              // NAMA MATKUL
              _buildLabel('Nama Mata Kuliah'),

              const SizedBox(height: 8),

              TextField(
                controller: namaMatkulController,

                decoration: _inputDecoration(
                  hint: 'Masukkan nama mata kuliah',

                  icon: Icons.book,
                ),
              ),

              const SizedBox(height: 20),

              // DOSEN
              _buildLabel('Nama Dosen'),

              const SizedBox(height: 8),

              TextField(
                controller: dosenController,

                decoration: _inputDecoration(
                  hint: 'Masukkan nama dosen',

                  icon: Icons.person,
                ),
              ),

              const SizedBox(height: 20),

              // SEMESTER
              _buildLabel('Semester'),

              const SizedBox(height: 8),

              DropdownButtonFormField<String>(
                value: selectedSemester,

                decoration: _inputDecoration(
                  hint: 'Pilih Semester',
                  icon: Icons.layers,
                ),

                items: daftarSemester
                    .map(
                      (semester) => DropdownMenuItem(
                        value: semester,

                        child: Text(semester),
                      ),
                    )
                    .toList(),

                onChanged: (value) {
                  setState(() {
                    selectedSemester = value!;
                  });
                },
              ),

              const SizedBox(height: 12),

              SizedBox(
                width: double.infinity,
                height: 52,

                child: ElevatedButton.icon(
                  onPressed: isLoading
                      ? null
                      : () {
                          editMatkul();
                        },

                  icon: const Icon(Icons.save),

                  label: isLoading
                      ? const SizedBox(
                          width: 20,

                          height: 20,

                          child: CircularProgressIndicator(
                            strokeWidth: 2,

                            color: Colors.white,
                          ),
                        )
                      : Text(
                          'Simpan Perubahan',

                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600,
                          ),
                        ),

                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1A58B7),

                    foregroundColor: Colors.white,

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 12),

              // INFO CARD
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),

                decoration: BoxDecoration(
                  color: const Color(0xFFF3F3FC),

                  borderRadius: BorderRadius.circular(12),

                  border: Border.all(color: const Color(0xFFE0E0E0)),
                ),

                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    const Icon(Icons.info, size: 20, color: Color(0xFF1A58B7)),

                    const SizedBox(width: 12),

                    Expanded(
                      child: Text(
                        'Perubahan ini akan memperbarui semua jadwal tugas dan perkuliahan yang terkait dengan mata kuliah ini.',

                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  // LABEL
  Widget _buildLabel(String text) {
    return Text(
      text,

      style: GoogleFonts.poppins(
        fontSize: 13,
        fontWeight: FontWeight.w500,
        color: Colors.black87,
      ),
    );
  }

  // INPUT DECORATION
  InputDecoration _inputDecoration({
    required String hint,
    required IconData icon,
  }) {
    return InputDecoration(
      hintText: hint,

      hintStyle: GoogleFonts.poppins(fontSize: 13, color: Colors.grey),

      filled: true,
      fillColor: const Color(0xFFF5F5F5),

      prefixIcon: Icon(icon, color: Colors.grey),

      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),

        borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
      ),

      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),

        borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
      ),

      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),

        borderSide: const BorderSide(color: Color(0xFF1A58B7)),
      ),
    );
  }
}
