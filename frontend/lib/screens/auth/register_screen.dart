import 'package:flutter/material.dart';
import 'package:Jadwalin/screens/auth/login_screen.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),

          child: Container(
            padding: const EdgeInsets.all(20),

            decoration: BoxDecoration(
              color: Colors.white,

              borderRadius: BorderRadius.circular(16),

              border: Border.all(color: const Color(0xFFE0E0E0)),

              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.03),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,

              children: [
                // TITLE
                const Text(
                  'Jadwalin',

                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1A58B7),
                  ),
                ),

                const SizedBox(height: 8),

                const Text(
                  'Buat akun untuk mulai mengatur jadwal akademikmu.',

                  textAlign: TextAlign.center,

                  style: TextStyle(fontSize: 14, color: Color(0xFF666666)),
                ),

                const SizedBox(height: 30),

                // NAMA
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Nama Lengkap',
                    hintText: 'Masukkan nama lengkap',

                    prefixIcon: const Icon(Icons.person),

                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // EMAIL
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Email',
                    hintText: 'contoh@mahasiswa.edu',

                    prefixIcon: const Icon(Icons.mail),

                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // PASSWORD
                TextField(
                  obscureText: true,

                  decoration: InputDecoration(
                    labelText: 'Password',
                    hintText: 'Minimal 8 karakter',

                    prefixIcon: const Icon(Icons.lock),

                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                // REGISTER BUTTON
                SizedBox(
                  width: double.infinity,
                  height: 50,

                  child: ElevatedButton.icon(
                    onPressed: () async {
                      // validasi input untuk kirim data register ke backend

                      // kalau sukses
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Akun berhasil dibuat")),
                      );

                      Navigator.pop(context);
                    },

                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1A58B7),

                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),

                    icon: const Icon(Icons.arrow_forward, color: Colors.white),

                    label: const Text(
                      'Register',

                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                // LOGIN TEXT
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,

                  children: [
                    const Text(
                      'Sudah punya akun?',
                      style: TextStyle(color: Color(0xFF666666)),
                    ),

                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },

                      child: const Text(
                        'Login',
                        style: TextStyle(
                          color: Color(0xFF1A58B7),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
