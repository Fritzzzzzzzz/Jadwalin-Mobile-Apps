import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../jadwal/jadwal_screen.dart';

class DashboardScreen extends StatelessWidget {
  final Function(int) onTabChange;

  const DashboardScreen({super.key, required this.onTabChange});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              // HEADER
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      Text(
                        'Selamat Datang,',

                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),

                      Text(
                        'Rizqi Firdaus',

                        style: GoogleFonts.poppins(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF1A58B7),
                        ),
                      ),
                    ],
                  ),

                  const CircleAvatar(
                    radius: 24,
                    backgroundColor: Color(0xFFE0E0E0),

                    child: Icon(Icons.person, color: Colors.grey),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // SUMMARY CARD
              Row(
                children: [
                  Expanded(
                    child: _buildSummaryCard(
                      icon: Icons.event,
                      title: '0',
                      subtitle: 'Jadwal Hari Ini',
                      color: Colors.blue,
                    ),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: _buildSummaryCard(
                      icon: Icons.assignment_late,
                      title: '0',
                      subtitle: 'Tugas Belum\nSelesai',
                      color: Colors.red,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 32),

              // JADWAL
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: [
                  Text(
                    'Jadwal Hari Ini',

                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  TextButton(
                    onPressed: () {
                      onTabChange(1);
                    },

                    child: const Text('Lihat Semua'),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),

                decoration: BoxDecoration(
                  color: const Color(0xFFF5F5F5),
                  borderRadius: BorderRadius.circular(16),
                ),

                child: Column(
                  children: [
                    const Icon(
                      Icons.calendar_today,
                      size: 48,
                      color: Colors.grey,
                    ),

                    const SizedBox(height: 12),

                    Text(
                      'Belum Ada Jadwal',

                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    const SizedBox(height: 6),

                    Text(
                      'Tambahkan jadwal baru untuk mulai mengatur aktivitas kuliah.',

                      textAlign: TextAlign.center,

                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              // TUGAS
              Text(
                'Deadline Terdekat',

                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(height: 12),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),

                decoration: BoxDecoration(
                  color: const Color(0xFFF5F5F5),
                  borderRadius: BorderRadius.circular(16),
                ),

                child: Column(
                  children: [
                    const Icon(Icons.task_alt, size: 48, color: Colors.grey),

                    const SizedBox(height: 12),

                    Text(
                      'Belum Ada Tugas',

                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    const SizedBox(height: 6),

                    Text(
                      'Tambahkan tugas untuk melihat deadline dan pengingat.',

                      textAlign: TextAlign.center,

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
      ),
    );
  }

  // SUMMARY CARD
  Widget _buildSummaryCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),

      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),

        borderRadius: BorderRadius.circular(16),
      ),

      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: color.withOpacity(0.15),

            child: Icon(icon, color: color),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Text(
                  title,

                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                Text(
                  subtitle,

                  style: GoogleFonts.poppins(fontSize: 13, color: Colors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // SCHEDULE CARD
  Widget _buildScheduleCard({
    required String jam,
    required String matkul,
    required String ruangan,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius: BorderRadius.circular(16),

        border: Border.all(color: const Color(0xFFE0E0E0)),
      ),

      child: Row(
        children: [
          Container(
            width: 70,

            child: Column(
              children: [
                Text(
                  jam,

                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF1A58B7),
                  ),
                ),

                Text(
                  'WIB',

                  style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ),

          Container(width: 1, height: 50, color: const Color(0xFFE0E0E0)),

          const SizedBox(width: 16),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Text(
                  matkul,

                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 4),

                Row(
                  children: [
                    const Icon(Icons.location_on, size: 16, color: Colors.grey),

                    const SizedBox(width: 4),

                    Text(
                      ruangan,

                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // TASK CARD
  Widget _buildTaskCard({
    required String title,
    required String desc,
    required String deadline,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius: BorderRadius.circular(16),

        border: Border.all(color: const Color(0xFFE0E0E0)),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,

            children: [
              Expanded(
                child: Text(
                  title,

                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),

                decoration: BoxDecoration(
                  color: Colors.red.shade100,

                  borderRadius: BorderRadius.circular(20),
                ),

                child: Text(
                  deadline,

                  style: GoogleFonts.poppins(
                    fontSize: 11,
                    color: Colors.red,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 8),

          Text(
            desc,

            style: GoogleFonts.poppins(fontSize: 13, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
