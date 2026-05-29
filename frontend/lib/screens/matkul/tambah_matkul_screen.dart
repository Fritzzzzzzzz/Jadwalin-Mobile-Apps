import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../models/matkul_model.dart';
import '../../services/matkul_service.dart';

class TambahMatkulScreen extends StatefulWidget {
  const TambahMatkulScreen({super.key});

  @override
  State<TambahMatkulScreen> createState() => _TambahMatkulScreenState();
}

class _TambahMatkulScreenState extends State<TambahMatkulScreen> {
  final TextEditingController namaMatkulController = TextEditingController();

  final TextEditingController dosenController = TextEditingController();

  String? selectedSemester;

  bool isLoading = false;

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

  Future<void> tambahMatkul() async {
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
        nama: namaMatkulController.text,

        dosen: dosenController.text,

        semester: selectedSemester!,
      );

      await MatkulService().tambahMatkul(matkul);

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Mata kuliah berhasil ditambahkan")),
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
      backgroundColor: const Color(0xFFFAF9FF),

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,

        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },

          icon: const Icon(Icons.arrow_back, color: Color(0xFF1A58B7)),
        ),

        title: Text(
          'Tambah Mata Kuliah',

          style: GoogleFonts.poppins(
            color: const Color(0xFF1A58B7),
            fontWeight: FontWeight.bold,
            fontSize: 20,
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
              // HEADER
              Text(
                'Informasi Akademik',

                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),

              const SizedBox(height: 4),

              Text(
                'Lengkapi detail mata kuliah baru Anda di bawah ini.',

                style: GoogleFonts.poppins(fontSize: 13, color: Colors.grey),
              ),

              const SizedBox(height: 24),

              // FORM
              Column(
                children: [
                  // NAMA MATKUL
                  _buildLabel('Nama Mata Kuliah'),

                  const SizedBox(height: 8),

                  TextField(
                    controller: namaMatkulController,

                    decoration: _inputDecoration(
                      hint: 'Contoh: Algoritma & Struktur Data',

                      icon: Icons.book,
                    ),
                  ),

                  const SizedBox(height: 16),

                  // DOSEN
                  _buildLabel('Nama Dosen'),

                  const SizedBox(height: 8),

                  TextField(
                    controller: dosenController,

                    decoration: _inputDecoration(
                      hint: 'Contoh: Dr. Jane Doe',

                      icon: Icons.person,
                    ),
                  ),

                  const SizedBox(height: 16),

                  // SEMESTER
                  _buildLabel('Semester'),

                  const SizedBox(height: 8),

                  DropdownButtonFormField<String>(
                    value: selectedSemester,

                    decoration: _inputDecoration(
                      hint: 'Pilih Semester',
                      icon: Icons.calendar_month,
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
                        selectedSemester = value;
                      });
                    },
                  ),
                ],
              ),

              const SizedBox(height: 40),

              // ILUSTRASI
              Center(
                child: Stack(
                  clipBehavior: Clip.none,

                  children: [
                    Container(
                      width: 180,
                      height: 180,

                      decoration: BoxDecoration(
                        shape: BoxShape.circle,

                        color: const Color(0xFF1A58B7).withOpacity(0.05),
                      ),
                    ),

                    Positioned(
                      top: -10,
                      right: -10,

                      child: Container(
                        width: 48,
                        height: 48,

                        decoration: BoxDecoration(
                          color: const Color(0xFFE5DEFF),

                          borderRadius: BorderRadius.circular(14),
                        ),

                        child: const Icon(
                          Icons.grade,
                          color: Color(0xFF5C4BC3),
                        ),
                      ),
                    ),

                    Positioned.fill(
                      child: Center(
                        child: Container(
                          width: 120,
                          height: 120,

                          decoration: BoxDecoration(
                            color: Colors.white,

                            borderRadius: BorderRadius.circular(24),

                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),

                                blurRadius: 10,
                              ),
                            ],
                          ),

                          child: const Icon(
                            Icons.laptop_mac,
                            size: 60,
                            color: Color(0xFF1A58B7),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 40),

              // BUTTON
              SizedBox(
                width: double.infinity,
                height: 52,

                child: ElevatedButton.icon(
                  onPressed: isLoading
                      ? null
                      : () {
                          tambahMatkul();
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
                          'Simpan Mata Kuliah',

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

              const SizedBox(height: 16),

              // FOOTNOTE
              Center(
                child: Text(
                  'Data akan disinkronkan dengan jadwal mingguan Anda.',

                  textAlign: TextAlign.center,

                  style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey),
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
    return Align(
      alignment: Alignment.centerLeft,

      child: Text(
        text,

        style: GoogleFonts.poppins(
          fontSize: 13,
          fontWeight: FontWeight.w500,
          color: Colors.black87,
        ),
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
