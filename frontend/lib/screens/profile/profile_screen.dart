import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';

import 'change_password_screen.dart';
import '../auth/login_screen.dart';
import '../../services/auth_service.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() {
    return _ProfileScreenState();
  }
}

class _ProfileScreenState extends State<ProfileScreen> {
  Map<String, dynamic>? user;

  bool isLoading = true;

  final namaController = TextEditingController();

  final emailController = TextEditingController();

  @override
  void initState() {
    super.initState();

    loadProfile();
  }

  Future<void> loadProfile() async {
    try {
      final data = await AuthService.getProfile();

      setState(() {
        user = data["user"];
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> logoutUser() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.remove("token");

    if (!mounted) return;

    Navigator.pushAndRemoveUntil(
      context,

      MaterialPageRoute(builder: (_) => const LoginScreen()),

      (route) => false,
    );
  }

  Future<void> showEditNamaDialog() async {
    namaController.text = user?["nama"] ?? "";

    showDialog(
      context: context,

      builder: (context) {
        return AlertDialog(
          title: const Text("Edit Nama"),

          content: TextField(
            controller: namaController,

            autofocus: true,

            decoration: const InputDecoration(hintText: "Masukkan nama"),
          ),

          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },

              child: const Text("Batal"),
            ),

            ElevatedButton(
              onPressed: () async {
                final nama = namaController.text.trim();

                if (nama.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Nama tidak boleh kosong")),
                  );

                  return;
                }

                try {
                  await AuthService.updateProfile(
                    namaController.text,

                    user?["email"] ?? "",
                  );

                  Navigator.pop(context);

                  loadProfile();
                } catch (e) {
                  debugPrint(e.toString());
                }
              },

              child: const Text("Simpan"),
            ),
          ],
        );
      },
    );
  }

  Future<void> showEditEmailDialog() async {
    emailController.text = user?["email"] ?? "";

    showDialog(
      context: context,

      builder: (context) {
        return AlertDialog(
          title: const Text("Edit Email"),

          content: TextField(
            controller: emailController,

            autofocus: true,

            keyboardType: TextInputType.emailAddress,

            decoration: const InputDecoration(hintText: "Masukkan email"),
          ),

          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },

              child: const Text("Batal"),
            ),

            ElevatedButton(
              onPressed: () async {
                final email = emailController.text.trim();

                if (email.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Email tidak boleh kosong")),
                  );

                  return;
                }

                final emailRegex = RegExp(
                  r'^[\w\-\.]+@([\w\-]+\.)+[\w\-]{2,4}$',
                );

                if (!emailRegex.hasMatch(email)) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Format email tidak valid")),
                  );

                  return;
                }

                try {
                  await AuthService.updateProfile(user?["nama"], email);

                  Navigator.pop(context);

                  loadProfile();
                } catch (e) {
                  debugPrint(e.toString());
                }
              },

              child: const Text("Simpan"),
            ),
          ],
        );
      },
    );
  }

  Future<void> pilihFoto() async {
    final picker = ImagePicker();

    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile == null) return;

    try {
      await AuthService.uploadFotoProfile(File(pickedFile.path));

      loadProfile();

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Foto profil berhasil diperbarui")),
      );
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      resizeToAvoidBottomInset: true,

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

      body: SafeArea(
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,

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
                    GestureDetector(
                      onTap: pilihFoto,

                      child: CircleAvatar(
                        radius: 50,

                        backgroundImage: user?["fotoProfil"] != null
                            ? NetworkImage(
                                "http://192.168.1.8:3000/uploads/${user!["fotoProfil"]}",
                              )
                            : null,

                        child: user?["fotoProfil"] == null
                            ? const Icon(Icons.person)
                            : null,
                      ),
                    ),

                    const SizedBox(height: 16),

                    Text(
                      user?["nama"] ?? "-",

                      style: GoogleFonts.poppins(
                        fontSize: 20,

                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    const SizedBox(height: 8),

                    TextButton.icon(
                      onPressed: showEditNamaDialog,

                      icon: const Icon(Icons.edit),

                      label: const Text("Edit Nama"),
                    ),

                    TextButton.icon(
                      onPressed: showEditEmailDialog,

                      icon: const Icon(Icons.email),

                      label: const Text("Edit Email"),
                    ),

                    Text(
                      user?["email"] ?? "-",

                      style: GoogleFonts.poppins(color: Colors.grey),
                    ),

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
                          const Icon(Icons.school, color: Color(0xFF1A58B7)),

                          const SizedBox(width: 8),

                          Text(
                            user?["role"] ?? "-",

                            style: GoogleFonts.poppins(
                              color: const Color(0xFF1A58B7),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              SizedBox(
                width: double.infinity,

                height: 55,

                child: OutlinedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,

                      MaterialPageRoute(
                        builder: (context) {
                          return const ChangePasswordScreen();
                        },
                      ),
                    );
                  },

                  icon: const Icon(Icons.lock_reset),

                  label: const Text("Ganti Password"),

                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFF1A58B7),

                    side: const BorderSide(color: Color(0xFF1A58B7)),

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              SizedBox(
                width: double.infinity,

                height: 52,

                child: ElevatedButton.icon(
                  onPressed: () {
                    showDialog(
                      context: context,

                      builder: (context) {
                        return AlertDialog(
                          title: const Text("Logout"),

                          content: const Text("Yakin ingin keluar akun?"),

                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },

                              child: const Text("Batal"),
                            ),

                            ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);

                                logoutUser();
                              },

                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                              ),

                              child: const Text("Logout"),
                            ),
                          ],
                        );
                      },
                    );
                  },

                  icon: const Icon(Icons.logout),

                  label: Text(
                    "Logout",

                    style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
                  ),

                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFE53935),

                    foregroundColor: Colors.white,

                    elevation: 2,

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
