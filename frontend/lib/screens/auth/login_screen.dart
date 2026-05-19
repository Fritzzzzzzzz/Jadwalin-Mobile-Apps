import 'package:flutter/material.dart';
import 'register_screen.dart';
import '../main/main_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

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
                  'Selamat datang, silakan masuk ke akun Anda.',

                  textAlign: TextAlign.center,

                  style: TextStyle(fontSize: 14, color: Color(0xFF666666)),
                ),

                const SizedBox(height: 30),

                // EMAIL
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Email',
                    hintText: 'Masukkan email',

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
                    hintText: 'Masukkan password',

                    prefixIcon: const Icon(Icons.lock),

                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                // LOGIN BUTTON
                SizedBox(
                  width: double.infinity,
                  height: 50,

                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,

                        MaterialPageRoute(
                          builder: (context) => const MainScreen(),
                        ),
                      );
                    },

                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1A58B7),

                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),

                    icon: const Icon(Icons.login, color: Colors.white),

                    label: const Text(
                      'Login',

                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                // REGISTER TEXT
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,

                  children: [
                    const Text(
                      'Belum punya akun?',
                      style: TextStyle(color: Color(0xFF666666)),
                    ),

                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,

                          MaterialPageRoute(
                            builder: (context) => const RegisterScreen(),
                          ),
                        );
                      },

                      child: const Text(
                        'Register',
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
