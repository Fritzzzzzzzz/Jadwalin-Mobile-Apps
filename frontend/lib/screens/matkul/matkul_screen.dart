import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'tambah_matkul_screen.dart';
import 'edit_matkul_screen.dart';
import '../../models/matkul_model.dart';
import '../../services/matkul_service.dart';

class MatkulScreen extends StatefulWidget {
  const MatkulScreen({super.key});

  @override
  State<MatkulScreen> createState() => _MatkulScreenState();
}

class _MatkulScreenState extends State<MatkulScreen> {
  List<MatkulModel> daftarMatkul = [];

  bool isLoading = true;

  Future<void> getMatkul() async {
    try {
      final result = await MatkulService().getMatkul();

      setState(() {
        daftarMatkul = result;

        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString().replaceFirst("Exception: ", ""))),
      );
    }
  }

  @override
  void initState() {
    super.initState();

    getMatkul();
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
          'Mata Kuliah',

          style: GoogleFonts.poppins(
            color: const Color(0xFF1A58B7),

            fontWeight: FontWeight.bold,
          ),
        ),

        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert, color: Colors.black87),

            itemBuilder: (context) => [
              const PopupMenuItem(value: 'sort', child: Text('Urutkan')),
            ],
          ),
        ],

        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),

          child: Container(height: 1, color: const Color(0xFFE0E0E0)),
        ),
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF1A58B7),

        onPressed: () async {
          final result = await Navigator.push(
            context,

            MaterialPageRoute(builder: (context) => const TambahMatkulScreen()),
          );

          if (result == true) {
            getMatkul();
          }
        },

        child: const Icon(Icons.add, color: Colors.white),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),

          child: isLoading
              ? const Center(child: CircularProgressIndicator())
              : Column(
                  children: [
                    const SizedBox(height: 12),

                    // EMPTY STATE
                    if (daftarMatkul.isEmpty)
                      Container(
                        width: double.infinity,

                        padding: const EdgeInsets.all(24),

                        decoration: BoxDecoration(
                          color: const Color(0xFFF5F5F5),

                          borderRadius: BorderRadius.circular(16),
                        ),

                        child: Column(
                          mainAxisSize: MainAxisSize.min,

                          children: [
                            const Icon(
                              Icons.menu_book,
                              size: 64,
                              color: Colors.grey,
                            ),

                            const SizedBox(height: 16),

                            Text(
                              'Belum Ada Mata Kuliah',

                              style: GoogleFonts.poppins(
                                fontSize: 18,

                                fontWeight: FontWeight.w600,
                              ),
                            ),

                            const SizedBox(height: 8),

                            Text(
                              'Tambahkan mata kuliah untuk mulai mengelola jadwal kuliah.',

                              textAlign: TextAlign.center,

                              style: GoogleFonts.poppins(
                                fontSize: 13,

                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      )
                    // LIST MATKUL
                    else
                      ...daftarMatkul.asMap().entries.map((entry) {
                        final _ = entry.key;

                        final matkul = entry.value;

                        return Container(
                          margin: const EdgeInsets.only(bottom: 12),

                          width: double.infinity,

                          padding: const EdgeInsets.all(16),

                          decoration: BoxDecoration(
                            color: const Color(0xFFF5F5F5),

                            borderRadius: BorderRadius.circular(16),

                            border: Border.all(color: const Color(0xFFE0E0E0)),
                          ),

                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,

                            children: [
                              // TITLE
                              Text(
                                matkul.nama,

                                style: GoogleFonts.poppins(
                                  fontSize: 18,

                                  fontWeight: FontWeight.w600,

                                  color: Colors.black87,
                                ),
                              ),

                              const SizedBox(height: 14),

                              // DOSEN
                              Row(
                                children: [
                                  const Icon(
                                    Icons.person,

                                    size: 18,

                                    color: Colors.grey,
                                  ),

                                  const SizedBox(width: 8),

                                  Expanded(
                                    child: Text(
                                      matkul.dosen,

                                      style: GoogleFonts.poppins(
                                        fontSize: 13,

                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 8),

                              // SEMESTER
                              Row(
                                children: [
                                  const Icon(
                                    Icons.school,

                                    size: 18,

                                    color: Colors.grey,
                                  ),

                                  const SizedBox(width: 8),

                                  Text(
                                    matkul.semester,

                                    style: GoogleFonts.poppins(
                                      fontSize: 13,

                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 16),

                              // ACTION BUTTON
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,

                                children: [
                                  // EDIT
                                  IconButton(
                                    onPressed: () async {
                                      final result = await Navigator.push(
                                        context,

                                        MaterialPageRoute(
                                          builder: (context) =>
                                              EditMatkulScreen(matkul: matkul),
                                        ),
                                      );

                                      if (result == true) {
                                        getMatkul();
                                      }
                                    },

                                    icon: const Icon(
                                      Icons.edit,

                                      color: Color(0xFF1A58B7),
                                    ),
                                  ),

                                  // DELETE
                                  IconButton(
                                    onPressed: () {
                                      showDialog(
                                        context: context,

                                        builder: (context) {
                                          return AlertDialog(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                            ),

                                            title: Text(
                                              'Hapus Mata Kuliah?',

                                              style: GoogleFonts.poppins(
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),

                                            content: Text(
                                              'Data mata kuliah yang dihapus tidak dapat dikembalikan.',

                                              style: GoogleFonts.poppins(
                                                fontSize: 13,
                                              ),
                                            ),

                                            actions: [
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },

                                                child: Text(
                                                  'Batal',

                                                  style: GoogleFonts.poppins(
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                              ),

                                              ElevatedButton(
                                                onPressed: () async {
                                                  try {
                                                    await MatkulService()
                                                        .hapusMatkul(
                                                          matkul.id!,
                                                        );

                                                    if (!mounted) return;

                                                    Navigator.pop(context);

                                                    getMatkul();

                                                    ScaffoldMessenger.of(
                                                      context,
                                                    ).showSnackBar(
                                                      const SnackBar(
                                                        content: Text(
                                                          "Mata kuliah berhasil dihapus",
                                                        ),
                                                      ),
                                                    );
                                                  } catch (e) {
                                                    Navigator.pop(context);

                                                    ScaffoldMessenger.of(
                                                      context,
                                                    ).showSnackBar(
                                                      SnackBar(
                                                        content: Text(
                                                          e
                                                              .toString()
                                                              .replaceFirst(
                                                                "Exception: ",
                                                                "",
                                                              ),
                                                        ),
                                                      ),
                                                    );
                                                  }
                                                },

                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: Colors.red,

                                                  foregroundColor: Colors.white,
                                                ),

                                                child: Text(
                                                  'Hapus',

                                                  style: GoogleFonts.poppins(),
                                                ),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },

                                    icon: const Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      }),

                    const SizedBox(height: 90),
                  ],
                ),
        ),
      ),
    );
  }
}
