import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../models/user_model.dart';
import '../../services/admin_service.dart';

class AdminDashboardScreen extends StatefulWidget {
  const AdminDashboardScreen({super.key});

  @override
  State<AdminDashboardScreen> createState() => _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends State<AdminDashboardScreen> {
  List<UserModel> daftarUser = [];

  int totalUser = 0;

  bool isLoading = true;

  Future<void> getAllUser() async {
    try {
      final result = await AdminService().getAllUser();

      setState(() {
        totalUser = result["totalUser"];

        daftarUser = result["users"];

        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();

    getAllUser();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        title: Text(
          "Dashboard Admin",

          style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
        ),

        backgroundColor: Colors.white,

        elevation: 0,

        foregroundColor: Colors.black,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Container(
              width: double.infinity,

              padding: const EdgeInsets.all(20),

              decoration: BoxDecoration(
                color: const Color(0xFFF5F5F5),

                borderRadius: BorderRadius.circular(20),
              ),

              child: Column(
                children: [
                  Text(
                    totalUser.toString(),

                    style: GoogleFonts.poppins(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text("Total User", style: GoogleFonts.poppins(fontSize: 16)),
                ],
              ),
            ),

            const SizedBox(height: 24),

            Text(
              "Daftar Pengguna",

              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 16),

            ListView.builder(
              shrinkWrap: true,

              physics: const NeverScrollableScrollPhysics(),

              itemCount: daftarUser.length,

              itemBuilder: (context, index) {
                final user = daftarUser[index];

                return Container(
                  margin: const EdgeInsets.only(bottom: 12),

                  decoration: BoxDecoration(
                    color: const Color(0xFFF5F5F5),

                    borderRadius: BorderRadius.circular(16),
                  ),

                  child: ListTile(
                    leading: const CircleAvatar(child: Icon(Icons.person)),

                    title: Text(user.nama),

                    subtitle: Text(user.email),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
