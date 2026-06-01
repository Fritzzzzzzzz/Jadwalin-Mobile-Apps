import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../models/tugas_model.dart';
import 'tambah_tugas_screen.dart';
import 'edit_tugas_screen.dart';
import '../../services/tugas_service.dart';

class TugasScreen extends StatefulWidget {
  const TugasScreen({super.key});

  @override
  State<TugasScreen> createState() => _TugasScreenState();
}

class _TugasScreenState extends State<TugasScreen> {
  List<TugasModel> daftarTugas = [];
  bool isLoading = true;

  String filterStatus = 'Semua';

  @override
  void initState() {
    super.initState();

    getTugas();
  }

  List<TugasModel> get tugasFiltered {
    if (filterStatus == 'Semua') {
      return daftarTugas;
    }

    return daftarTugas.where((tugas) => tugas.status == filterStatus).toList();
  }

  @override
  Widget build(BuildContext context) {
    final belumSelesai = daftarTugas
        .where((e) => e.status == 'Belum Selesai')
        .length;

    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        automaticallyImplyLeading: false,

        backgroundColor: Colors.white,

        elevation: 0,

        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(1),

          child: Divider(height: 1, thickness: 1, color: Color(0xFFE0E0E0)),
        ),

        title: Text(
          'Jadwalin',

          style: GoogleFonts.poppins(
            color: const Color(0xFF1A58B7),

            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF1A58B7),

        onPressed: () async {
          final tugasBaru = await Navigator.push(
            context,

            MaterialPageRoute(builder: (_) => const TambahTugasScreen()),
          );

          if (tugasBaru == true) {
            getTugas();
          }
        },

        child: const Icon(Icons.add, color: Colors.white),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,

              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    Text(
                      'Tugas Saya',

                      style: GoogleFonts.poppins(
                        fontSize: 24,

                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    const SizedBox(height: 4),

                    Text(
                      '$belumSelesai tugas untuk diselesaikan.',

                      style: GoogleFonts.poppins(color: Colors.grey),
                    ),
                  ],
                ),

                TextButton.icon(
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ListTile(
                              title: const Text('Semua'),
                              onTap: () {
                                setState(() {
                                  filterStatus = 'Semua';
                                });
                                Navigator.pop(context);
                              },
                            ),
                            ListTile(
                              title: const Text('Belum Selesai'),
                              onTap: () {
                                setState(() {
                                  filterStatus = 'Belum Selesai';
                                });
                                Navigator.pop(context);
                              },
                            ),
                            ListTile(
                              title: const Text('Selesai'),
                              onTap: () {
                                setState(() {
                                  filterStatus = 'Selesai';
                                });
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },

                  icon: const Icon(Icons.filter_list),

                  label: Text('Filter', style: GoogleFonts.poppins()),
                ),
              ],
            ),

            const SizedBox(height: 20),

            Expanded(
              child: isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : tugasFiltered.isEmpty
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
                              Icons.task_alt,

                              size: 64,

                              color: Colors.grey,
                            ),

                            const SizedBox(height: 16),

                            Text(
                              'Belum Ada Tugas',

                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w600,

                                fontSize: 18,
                              ),
                            ),

                            const SizedBox(height: 8),

                            Text(
                              'Tambahkan tugas untuk mulai mengatur aktivitas perkuliahan.',

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
                  : ListView(
                      children: tugasFiltered.map((tugas) {
                        return Container(
                          margin: const EdgeInsets.only(bottom: 12),

                          padding: const EdgeInsets.all(16),

                          decoration: BoxDecoration(
                            color: tugas.status == 'Selesai'
                                ? Colors.grey.shade100
                                : const Color(0xFFF5F5F5),

                            borderRadius: BorderRadius.circular(16),

                            border: Border.all(color: const Color(0xFFE0E0E0)),
                          ),

                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,

                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,

                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10,

                                      vertical: 4,
                                    ),

                                    decoration: BoxDecoration(
                                      color: const Color(0xFFE5DEFF),

                                      borderRadius: BorderRadius.circular(30),
                                    ),

                                    child: Text(
                                      tugas.namaMatkul,

                                      style: GoogleFonts.poppins(fontSize: 12),
                                    ),
                                  ),

                                  Chip(
                                    label: Text(
                                      tugas.status == 'Selesai'
                                          ? 'Selesai'
                                          : 'Belum Selesai',
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 12),

                              Text(
                                tugas.judul,

                                style: GoogleFonts.poppins(
                                  fontSize: 18,

                                  fontWeight: FontWeight.w600,

                                  decoration: tugas.status == 'Selesai'
                                      ? TextDecoration.lineThrough
                                      : null,
                                ),
                              ),

                              const SizedBox(height: 8),

                              if (tugas.deskripsi != null &&
                                  tugas.deskripsi!.trim().isNotEmpty) ...[
                                const SizedBox(height: 8),

                                Text(
                                  tugas.deskripsi!,

                                  maxLines: 2,

                                  overflow: TextOverflow.ellipsis,

                                  style: GoogleFonts.poppins(
                                    fontSize: 13,

                                    color: Colors.grey,
                                  ),
                                ),
                              ],

                              Row(
                                children: [
                                  const Icon(
                                    Icons.calendar_today,

                                    size: 16,

                                    color: Colors.grey,
                                  ),

                                  const SizedBox(width: 8),

                                  Text(
                                    tugas.deadline,

                                    style: GoogleFonts.poppins(
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 8),

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
                                          builder: (_) =>
                                              EditTugasScreen(tugas: tugas),
                                        ),
                                      );

                                      if (result == true) {
                                        getTugas();
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
                                              'Hapus Tugas?',

                                              style: GoogleFonts.poppins(
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),

                                            content: Text(
                                              'Tugas yang dihapus tidak dapat dikembalikan.',

                                              style: GoogleFonts.poppins(),
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
                                                onPressed: () {
                                                  setState(() {
                                                    daftarTugas.remove(tugas);
                                                  });

                                                  Navigator.pop(context);
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
                      }).toList(),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> getTugas() async {
    try {
      setState(() {
        isLoading = true;
      });

      final tugas = await TugasService().getTugas();

      setState(() {
        daftarTugas = tugas;
      });
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }
}
