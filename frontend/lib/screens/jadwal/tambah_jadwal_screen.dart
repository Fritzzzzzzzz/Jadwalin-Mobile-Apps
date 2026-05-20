import 'package:Jadwalin/screens/jadwal/jadwal_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../matkul/tambah_matkul_screen.dart';
import '../../models/jadwal_model.dart';

class TambahJadwalScreen extends StatefulWidget {
  const TambahJadwalScreen({super.key});

  @override
  State<TambahJadwalScreen> createState() => _TambahJadwalScreenState();
}

class _TambahJadwalScreenState extends State<TambahJadwalScreen> {
  String? selectedMatkul;
  String? selectedHari;

  final List<String> daftarMatkul = [
    'Pemrograman Mobile',
    'Basis Data',
    'Struktur Data',
  ];

  final List<String> daftarHari = [
    'Senin',
    'Selasa',
    'Rabu',
    'Kamis',
    'Jumat',
    'Sabtu',
  ];

  final TextEditingController dosenController = TextEditingController();

  final TextEditingController ruanganController = TextEditingController();

  final TextEditingController jamMulaiController = TextEditingController();

  final TextEditingController jamSelesaiController = TextEditingController();

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

          icon: const Icon(Icons.arrow_back, color: Colors.black87),
        ),

        title: Text(
          'Jadwalin',

          style: GoogleFonts.poppins(
            color: const Color(0xFF1A58B7),
            fontWeight: FontWeight.bold,
          ),
        ),

        centerTitle: true,

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
                'Tambah Jadwal Baru',

                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(height: 4),

              Text(
                'Masukkan detail mata kuliah untuk jadwal Anda.',

                style: GoogleFonts.poppins(fontSize: 13, color: Colors.grey),
              ),

              const SizedBox(height: 24),

              // CARD
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),

                decoration: BoxDecoration(
                  color: Colors.white,

                  borderRadius: BorderRadius.circular(16),

                  border: Border.all(color: const Color(0xFFE0E0E0)),
                ),

                child: Column(
                  children: [
                    // MATA KULIAH
                    _buildLabel('Mata Kuliah'),

                    const SizedBox(height: 8),

                    daftarMatkul.isEmpty
                        // EMPTY STATE MATKUL
                        ? Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(18),

                            decoration: BoxDecoration(
                              color: const Color(0xFFF5F5F5),

                              borderRadius: BorderRadius.circular(12),
                            ),

                            child: Column(
                              children: [
                                const Icon(
                                  Icons.menu_book,
                                  size: 38,
                                  color: Colors.grey,
                                ),

                                const SizedBox(height: 10),

                                Text(
                                  'Belum Ada Mata Kuliah',

                                  style: GoogleFonts.poppins(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),

                                const SizedBox(height: 4),

                                Text(
                                  'Tambahkan mata kuliah terlebih dahulu.',

                                  textAlign: TextAlign.center,

                                  style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    color: Colors.grey,
                                  ),
                                ),

                                const SizedBox(height: 14),

                                SizedBox(
                                  height: 42,

                                  child: OutlinedButton.icon(
                                    onPressed: () {
                                      Navigator.push(
                                        context,

                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const TambahMatkulScreen(),
                                        ),
                                      );
                                    },

                                    icon: const Icon(Icons.add, size: 18),

                                    label: Text(
                                      'Tambah Mata Kuliah',

                                      style: GoogleFonts.poppins(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),

                                    style: OutlinedButton.styleFrom(
                                      foregroundColor: const Color(0xFF5E35B1),

                                      side: const BorderSide(
                                        color: Color(0xFFB39DDB),
                                      ),

                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(24),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        // DROPDOWN MATKUL
                        : DropdownButtonFormField<String>(
                            value: selectedMatkul,

                            decoration: _inputDecoration(
                              hint: 'Pilih Mata Kuliah',
                              icon: Icons.book,
                            ),

                            items: daftarMatkul
                                .map(
                                  (matkul) => DropdownMenuItem(
                                    value: matkul,

                                    child: Text(matkul),
                                  ),
                                )
                                .toList(),

                            onChanged: (value) {
                              setState(() {
                                selectedMatkul = value;
                              });
                            },
                          ),

                    const SizedBox(height: 16),

                    // HARI
                    _buildLabel('Hari'),

                    const SizedBox(height: 8),

                    DropdownButtonFormField<String>(
                      value: selectedHari,

                      decoration: _inputDecoration(
                        hint: 'Pilih Hari',
                        icon: Icons.calendar_month,
                      ),

                      items: daftarHari
                          .map(
                            (hari) => DropdownMenuItem(
                              value: hari,

                              child: Text(hari),
                            ),
                          )
                          .toList(),

                      onChanged: (value) {
                        setState(() {
                          selectedHari = value;
                        });
                      },
                    ),

                    const SizedBox(height: 16),

                    // JAM
                    Row(
                      children: [
                        // JAM MULAI
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,

                            children: [
                              _buildLabel('Jam Mulai'),

                              const SizedBox(height: 8),

                              GestureDetector(
                                onTap: () async {
                                  final TimeOfDay? picked =
                                      await showTimePicker(
                                        context: context,
                                        initialTime: TimeOfDay.now(),
                                      );

                                  if (picked != null) {
                                    jamMulaiController.text = picked.format(
                                      context,
                                    );

                                    setState(() {});
                                  }
                                },

                                child: AbsorbPointer(
                                  child: TextField(
                                    controller: jamMulaiController,

                                    decoration: _inputDecoration(
                                      hint: '--:--',
                                      icon: Icons.schedule,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(width: 12),

                        // JAM SELESAI
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,

                            children: [
                              _buildLabel('Jam Selesai'),

                              const SizedBox(height: 8),

                              GestureDetector(
                                onTap: () async {
                                  final TimeOfDay? picked =
                                      await showTimePicker(
                                        context: context,
                                        initialTime: TimeOfDay.now(),
                                      );

                                  if (picked != null) {
                                    jamSelesaiController.text = picked.format(
                                      context,
                                    );

                                    setState(() {});
                                  }
                                },

                                child: AbsorbPointer(
                                  child: TextField(
                                    controller: jamSelesaiController,

                                    decoration: _inputDecoration(
                                      hint: '--:--',
                                      icon: Icons.history_toggle_off,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(width: 24),

                    // RUANGAN
                    _buildLabel('Ruangan'),

                    const SizedBox(height: 8),

                    TextField(
                      controller: ruanganController,

                      decoration: _inputDecoration(
                        hint: 'Contoh: Gedung A, R.204',

                        icon: Icons.room,
                      ),
                    ),

                    const SizedBox(height: 28),

                    // BUTTON
                    SizedBox(
                      width: double.infinity,
                      height: 52,

                      child: ElevatedButton.icon(
                        onPressed: () {
                          final jadwalBaru = JadwalModel(
                            namaMatkul: selectedMatkul!,

                            hari: selectedHari!,

                            jamMulai: jamMulaiController.text,

                            jamSelesai: jamSelesaiController.text,

                            ruangan: ruanganController.text,
                          );

                          Navigator.pop(context, jadwalBaru);
                        },

                        icon: const Icon(Icons.save),

                        label: Text(
                          'Simpan',

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
                  ],
                ),
              ),
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
