import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../models/jadwal_model.dart';
import '../../services/jadwal_service.dart';
import '../../services/matkul_service.dart';

class EditJadwalScreen extends StatefulWidget {
  final JadwalModel jadwal;

  const EditJadwalScreen({super.key, required this.jadwal});

  @override
  State<EditJadwalScreen> createState() => _EditJadwalScreenState();
}

class _EditJadwalScreenState extends State<EditJadwalScreen> {
  String? selectedMatkul;
  String? selectedHari;

  bool isLoading = false;

  final List<String> daftarMatkul = [];

  bool isLoadingMatkul = true;

  final List<String> daftarHari = [
    'Senin',
    'Selasa',
    'Rabu',
    'Kamis',
    'Jumat',
    'Sabtu',
  ];

  late TextEditingController jamMulaiController;

  late TextEditingController jamSelesaiController;

  late TextEditingController ruanganController;

  Future<void> getMatkul() async {
    try {
      final data = await MatkulService().getMatkul();

      setState(() {
        daftarMatkul.clear();

        daftarMatkul.addAll(data.map((e) => e.nama).toSet().toList());

        isLoadingMatkul = false;
      });
    } catch (e) {
      setState(() {
        isLoadingMatkul = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();

    selectedMatkul = widget.jadwal.namaMatkul;

    selectedHari = widget.jadwal.hari;

    jamMulaiController = TextEditingController(text: widget.jadwal.jamMulai);

    jamSelesaiController = TextEditingController(
      text: widget.jadwal.jamSelesai,
    );

    ruanganController = TextEditingController(text: widget.jadwal.ruangan);

    getMatkul();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,

        title: Text(
          'Edit Jadwal',

          style: GoogleFonts.poppins(
            color: const Color(0xFF1A58B7),

            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              // HEADER CARD
              Container(
                width: double.infinity,

                padding: const EdgeInsets.all(16),

                decoration: BoxDecoration(
                  color: const Color(0xFFF5F5F5),

                  borderRadius: BorderRadius.circular(16),
                ),

                child: Row(
                  children: [
                    Container(
                      width: 52,
                      height: 52,

                      decoration: BoxDecoration(
                        color: const Color(0xFF1A58B7).withOpacity(0.1),

                        borderRadius: BorderRadius.circular(12),
                      ),

                      child: const Icon(
                        Icons.calendar_today,
                        color: Color(0xFF1A58B7),
                      ),
                    ),

                    const SizedBox(width: 14),

                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [
                          Text(
                            widget.jadwal.namaMatkul,

                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),

                          const SizedBox(height: 4),

                          Text(
                            widget.jadwal.ruangan,

                            style: GoogleFonts.poppins(
                              fontSize: 13,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // MATA KULIAH
              _buildLabel('Mata Kuliah'),

              const SizedBox(height: 8),

              isLoadingMatkul
                  ? const Center(child: CircularProgressIndicator())
                  : DropdownButtonFormField<String>(
                      value: selectedMatkul,

                      items: daftarMatkul.map((matkul) {
                        return DropdownMenuItem(
                          value: matkul,
                          child: Text(matkul),
                        );
                      }).toList(),

                      onChanged: (value) {
                        setState(() {
                          selectedMatkul = value;
                        });
                      },

                      decoration: _inputDecoration(
                        hint: 'Pilih Matkul',
                        icon: Icons.menu_book,
                      ),
                    ),

              const SizedBox(height: 16),

              // HARI
              _buildLabel('Hari'),

              const SizedBox(height: 8),

              DropdownButtonFormField<String>(
                value: selectedHari,

                items: daftarHari.map((hari) {
                  return DropdownMenuItem(value: hari, child: Text(hari));
                }).toList(),

                onChanged: (value) {
                  setState(() {
                    selectedHari = value;
                  });
                },

                decoration: _inputDecoration(
                  hint: 'Pilih Hari',
                  icon: Icons.calendar_today,
                ),
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
                            final TimeOfDay? picked = await showTimePicker(
                              context: context,

                              initialTime: TimeOfDay.now(),
                            );

                            if (picked != null) {
                              jamMulaiController.text =
                                  "${picked.hour.toString().padLeft(2, '0')}:"
                                  "${picked.minute.toString().padLeft(2, '0')}";

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
                            final TimeOfDay? picked = await showTimePicker(
                              context: context,

                              initialTime: TimeOfDay.now(),
                            );

                            if (picked != null) {
                              jamSelesaiController.text =
                                  "${picked.hour.toString().padLeft(2, '0')}:"
                                  "${picked.minute.toString().padLeft(2, '0')}";

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

              const SizedBox(height: 16),

              // RUANGAN
              _buildLabel('Ruangan'),

              const SizedBox(height: 8),

              TextField(
                controller: ruanganController,

                decoration: _inputDecoration(
                  hint: 'Masukkan Ruangan',

                  icon: Icons.meeting_room,
                ),
              ),

              const SizedBox(height: 28),

              // BUTTON SAVE
              SizedBox(
                width: double.infinity,
                height: 52,

                child: ElevatedButton.icon(
                  onPressed: isLoading
                      ? null
                      : () async {
                          if (selectedMatkul == null ||
                              selectedHari == null ||
                              jamMulaiController.text.isEmpty ||
                              jamSelesaiController.text.isEmpty ||
                              ruanganController.text.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Lengkapi data terlebih dahulu'),
                              ),
                            );

                            return;
                          }

                          try {
                            setState(() {
                              isLoading = true;
                            });

                            await JadwalService().editJadwal(
                              JadwalModel(
                                id: widget.jadwal.id,

                                namaMatkul: selectedMatkul!,

                                hari: selectedHari!,

                                jamMulai: jamMulaiController.text,

                                jamSelesai: jamSelesaiController.text,

                                ruangan: ruanganController.text,
                              ),
                            );

                            if (!mounted) return;

                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Jadwal berhasil diperbarui"),
                              ),
                            );

                            Navigator.pop(context, true);
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  e.toString().replaceFirst("Exception: ", ""),
                                ),
                              ),
                            );
                          } finally {
                            setState(() {
                              isLoading = false;
                            });
                          }
                        },

                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1A58B7),

                    foregroundColor: Colors.white,

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),

                  icon: const Icon(Icons.save),

                  label: isLoading
                      ? const SizedBox(
                          width: 20,
                          height: 20,

                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                      : Text(
                          'Simpan Perubahan',

                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                ),
              ),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,

      style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w500),
    );
  }

  InputDecoration _inputDecoration({
    required String hint,
    required IconData icon,
  }) {
    return InputDecoration(
      hintText: hint,

      prefixIcon: Icon(icon),

      filled: true,
      fillColor: Colors.white,

      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),

      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),

        borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
      ),

      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),

        borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
      ),

      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),

        borderSide: const BorderSide(color: Color(0xFF1A58B7), width: 1.5),
      ),
    );
  }

  @override
  void dispose() {
    jamMulaiController.dispose();

    jamSelesaiController.dispose();

    ruanganController.dispose();

    super.dispose();
  }
}
