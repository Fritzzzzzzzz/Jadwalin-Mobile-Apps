import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../auth/login_screen.dart';
import '../main/main_screen.dart';
import '../main/admin_main_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    checkLogin();
  }

  Future<void> checkLogin() async {
    final prefs = await SharedPreferences.getInstance();

    final token = prefs.getString("token");

    final role = prefs.getString("role");

    await Future.delayed(const Duration(seconds: 2));

    if (token != null) {
      if (role == "admin") {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const AdminMainScreen()),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const MainScreen()),
        );
      }
    } else {
      Navigator.pushReplacement(
        context,

        MaterialPageRoute(builder: (_) => const LoginScreen()),
      );
    }
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
