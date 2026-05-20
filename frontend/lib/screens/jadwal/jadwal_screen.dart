import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'tambah_jadwal_screen.dart';
import 'edit_jadwal_screen.dart';
import '../matkul/matkul_screen.dart';
import '../../models/jadwal_model.dart';

class JadwalScreen extends StatefulWidget {
  const JadwalScreen({super.key});

  @override
  State<JadwalScreen> createState() => _JadwalScreenState();
}

class _JadwalScreenState extends State<JadwalScreen> {
  List<JadwalModel> daftarJadwal = [
    JadwalModel(
      namaMatkul: 'Pemrograman Mobile',
      hari: 'Senin',
      jamMulai: '08:00',
      jamSelesai: '10:00',
      ruangan: 'Lab Komputer 1',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,

        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),

          child: Container(height: 1, color: const Color(0XFFE0E0E0)),
        ),

        title: Text(
          'Jadwalin',

          style: GoogleFonts.poppins(
            color: const Color(0xFF1A58B7),
            fontWeight: FontWeight.bold,
          ),
        ),

        actions: [
          IconButton(
            onPressed: () {},

            icon: const Icon(Icons.search, color: Colors.black87),
          ),

          IconButton(
            onPressed: () {},

            icon: const Icon(Icons.notifications_none, color: Colors.black87),
          ),

          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert, color: Colors.black87),

            onSelected: (value) {
              if (value == 'matkul') {
                Navigator.push(
                  context,

                  MaterialPageRoute(builder: (context) => const MatkulScreen()),
                );
              }
            },

            itemBuilder: (context) => [
              PopupMenuItem(
                value: 'matkul',

                child: Row(
                  children: [
                    const Icon(
                      Icons.menu_book,
                      size: 20,
                      color: Colors.black87,
                    ),

                    const SizedBox(width: 10),

                    Text(
                      'Kelola Mata Kuliah',

                      style: GoogleFonts.poppins(fontSize: 13),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF5B8DEF),

        onPressed: () async {
          final result = await Navigator.push(
            context,

            MaterialPageRoute(builder: (context) => const TambahJadwalScreen()),
          );

          if (result != null && result is JadwalModel) {
            setState(() {
              daftarJadwal.add(result);
            });
          }
        },

        child: const Icon(Icons.add, color: Colors.white),
      ),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              // HEADER
              Text(
                'Jadwal Kuliah',

                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(height: 4),

              Text(
                'Semester Ganjil 2023/2024',

                style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey),
              ),

              const SizedBox(height: 24),

              // FILTER
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,

                child: Row(
                  children: [
                    _buildFilterChip(label: 'Semua', isActive: true),

                    _buildFilterChip(label: 'Senin'),
                    _buildFilterChip(label: 'Selasa'),
                    _buildFilterChip(label: 'Rabu'),
                    _buildFilterChip(label: 'Kamis'),
                    _buildFilterChip(label: 'Jumat'),
                    _buildFilterChip(label: 'Sabtu'),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              // EMPTY STATE
              // EMPTY STATE / LIST JADWAL
              Expanded(
                child: daftarJadwal.isEmpty
                    // EMPTY STATE
                    ? Center(
                        child: Container(
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
                                Icons.calendar_month,
                                size: 64,
                                color: Colors.grey,
                              ),

                              const SizedBox(height: 16),

                              Text(
                                'Belum Ada Jadwal',

                                style: GoogleFonts.poppins(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),

                              const SizedBox(height: 8),

                              Text(
                                'Tambahkan jadwal kuliah untuk mulai mengatur aktivitas perkuliahan.',

                                textAlign: TextAlign.center,

                                style: GoogleFonts.poppins(
                                  fontSize: 13,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    // LIST JADWAL
                    : ListView(
                        children: [
                          ...daftarJadwal.map((jadwal) {
                            return Container(
                              width: double.infinity,

                              margin: const EdgeInsets.only(bottom: 12),

                              padding: const EdgeInsets.all(16),

                              decoration: BoxDecoration(
                                color: const Color(0xFFF5F5F5),

                                borderRadius: BorderRadius.circular(16),

                                border: Border.all(
                                  color: const Color(0xFFE0E0E0),
                                ),
                              ),

                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,

                                children: [
                                  // TITLE
                                  Text(
                                    jadwal.namaMatkul,

                                    style: GoogleFonts.poppins(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,

                                      color: Colors.black87,
                                    ),
                                  ),

                                  const SizedBox(height: 14),

                                  // HARI + JAM
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.schedule,
                                        size: 18,
                                        color: Colors.grey,
                                      ),

                                      const SizedBox(width: 8),

                                      Expanded(
                                        child: Text(
                                          '${jadwal.hari}, ${jadwal.jamMulai} - ${jadwal.jamSelesai}',

                                          style: GoogleFonts.poppins(
                                            fontSize: 13,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),

                                  const SizedBox(height: 8),

                                  // RUANGAN
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.room,
                                        size: 18,
                                        color: Colors.grey,
                                      ),

                                      const SizedBox(width: 8),

                                      Expanded(
                                        child: Text(
                                          jadwal.ruangan,

                                          style: GoogleFonts.poppins(
                                            fontSize: 13,
                                            color: Colors.grey,
                                          ),
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
                                                  EditJadwalScreen(
                                                    jadwal: jadwal,
                                                  ),
                                            ),
                                          );

                                          if (result != null &&
                                              result is JadwalModel) {
                                            setState(() {
                                              final index = daftarJadwal
                                                  .indexOf(jadwal);

                                              daftarJadwal[index] = result;
                                            });
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
                                                  'Hapus Jadwal?',

                                                  style: GoogleFonts.poppins(
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),

                                                content: Text(
                                                  'Jadwal yang dihapus tidak dapat dikembalikan.',

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

                                                      style:
                                                          GoogleFonts.poppins(
                                                            color: Colors.grey,
                                                          ),
                                                    ),
                                                  ),

                                                  ElevatedButton(
                                                    onPressed: () {
                                                      setState(() {
                                                        daftarJadwal.remove(
                                                          jadwal,
                                                        );
                                                      });

                                                      Navigator.pop(context);
                                                    },

                                                    style:
                                                        ElevatedButton.styleFrom(
                                                          backgroundColor:
                                                              Colors.red,

                                                          foregroundColor:
                                                              Colors.white,
                                                        ),

                                                    child: Text(
                                                      'Hapus',

                                                      style:
                                                          GoogleFonts.poppins(),
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
                        ],
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // FILTER CHIP
  Widget _buildFilterChip({required String label, bool isActive = false}) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),

      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),

        decoration: BoxDecoration(
          color: isActive ? const Color(0xFF1A58B7) : const Color(0xFFF5F5F5),

          borderRadius: BorderRadius.circular(30),

          border: Border.all(
            color: isActive ? const Color(0xFF1A58B7) : const Color(0xFFE0E0E0),
          ),
        ),

        child: Text(
          label,

          style: GoogleFonts.poppins(
            fontSize: 12,

            color: isActive ? Colors.white : Colors.black87,

            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
