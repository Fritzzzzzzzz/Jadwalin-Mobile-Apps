import 'dart:async';
import '../auth/login_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,

        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,

            children: [
              Container(
                width: 96,
                height: 96,

                decoration: BoxDecoration(
                  color: const Color(0xFFD8E2FF).withOpacity(0.3),
                  shape: BoxShape.circle,

                  border: Border.all(color: const Color(0xFFC3C6D4), width: 1),
                ),

                child: const Center(
                  child: Icon(
                    Icons.calendar_today,
                    size: 48,
                    color: Color(0xFF1A58B7),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              const Text(
                'Jadwalin',

                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF1A58B7),
                ),
              ),

              const SizedBox(height: 8),

              const Text(
                'Atur Jadwal dan Tugas Kuliah dengan Mudah',

                textAlign: TextAlign.center,

                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFF666666),
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
