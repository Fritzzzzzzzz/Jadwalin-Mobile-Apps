import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../auth/login_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() {
    return _ProfileScreenState();
  }
}

class _ProfileScreenState extends State<ProfileScreen> {
  String nama = 'Rizqi Firdaus';

  String email = 'rizqi@student.univ.ac.id';

  String role = 'Mahasiswa';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        automaticallyImplyLeading: false,

        backgroundColor: Colors.white,

        elevation: 0,

        title: Text(
          'Jadwalin',

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

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          children: [
            Container(
              width: double.infinity,

              padding: const EdgeInsets.all(20),

              decoration: BoxDecoration(
                color: const Color(0xFFF5F5F5),

                borderRadius: BorderRadius.circular(16),

                border: Border.all(color: const Color(0xFFE0E0E0)),
              ),

              child: Column(
                children: [
                  CircleAvatar(
                    radius: 48,

                    backgroundColor: Colors.grey.shade300,

                    child: const Icon(
                      Icons.person,

                      size: 52,

                      color: Colors.grey,
                    ),
                  ),

                  const SizedBox(height: 16),

                  Text(
                    nama,

                    style: GoogleFonts.poppins(
                      fontSize: 20,

                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  const SizedBox(height: 4),

                  Text(email, style: GoogleFonts.poppins(color: Colors.grey)),

                  const SizedBox(height: 16),

                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,

                      vertical: 8,
                    ),

                    decoration: BoxDecoration(
                      color: const Color(0xFF1A58B7).withOpacity(0.1),

                      borderRadius: BorderRadius.circular(30),
                    ),

                    child: Row(
                      mainAxisSize: MainAxisSize.min,

                      children: [
                        const Icon(
                          Icons.school,

                          size: 18,

                          color: Color(0xFF1A58B7),
                        ),

                        const SizedBox(width: 8),

                        Text(
                          role,

                          style: GoogleFonts.poppins(
                            color: const Color(0xFF1A58B7),

                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const Spacer(),

            SizedBox(
              width: double.infinity,

              height: 52,

              child: OutlinedButton.icon(
                onPressed: () {
                  showDialog(
                    context: context,

                    builder: (context) {
                      return AlertDialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),

                        title: Text(
                          'Logout?',

                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600,
                          ),
                        ),

                        content: Text(
                          'Apakah yakin ingin keluar akun?',

                          style: GoogleFonts.poppins(),
                        ),

                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },

                            child: const Text('Batal'),
                          ),

                          ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);

                              Navigator.pushAndRemoveUntil(
                                context,

                                MaterialPageRoute(
                                  builder: (_) => const LoginScreen(),
                                ),

                                (route) => false,
                              );
                            },

                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,

                              foregroundColor: Colors.white,
                            ),

                            child: const Text('Logout'),
                          ),
                        ],
                      );
                    },
                  );
                },

                icon: const Icon(Icons.logout),

                label: Text(
                  'Logout',

                  style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
                ),

                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.red,

                  side: const BorderSide(color: Color(0xFFE0E0E0)),

                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
