import 'package:flutter/material.dart';

import '../../services/auth_service.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() {
    return _ChangePasswordScreenState();
  }
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final oldPasswordController = TextEditingController();

  final newPasswordController = TextEditingController();

  final confirmPasswordController = TextEditingController();

  bool obscureOldPassword = true;

  bool obscureNewPassword = true;

  bool obscureConfirmPassword = true;

  bool isLoading = false;

  Future<void> changePassword() async {
    final oldPassword = oldPasswordController.text;

    final newPassword = newPasswordController.text;

    final confirmPassword = confirmPasswordController.text;

    if (oldPassword.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Password lama wajib diisi")),
      );

      return;
    }

    if (newPassword.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Password baru wajib diisi")),
      );

      return;
    }

    if (newPassword.length < 8) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Password baru minimal 8 karakter")),
      );

      return;
    }

    if (confirmPassword.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Konfirmasi password wajib diisi")),
      );

      return;
    }

    if (newPassword != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Konfirmasi password tidak cocok")),
      );

      return;
    }

    try {
      setState(() {
        isLoading = true;
      });

      final response = await AuthService.changePassword(
        oldPassword,

        newPassword,
      );

      if (response["success"]) {
        if (!mounted) return;

        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(response["message"])));

        Navigator.pop(context);
      } else {
        throw Exception(response["message"]);
      }
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString().replaceFirst("Exception: ", ""))),
      );
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  void dispose() {
    oldPasswordController.dispose();

    newPasswordController.dispose();

    confirmPasswordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Ganti Password")),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          children: [
            // PASSWORD LAMA
            TextField(
              controller: oldPasswordController,

              obscureText: obscureOldPassword,

              decoration: InputDecoration(
                labelText: "Password Lama",

                prefixIcon: const Icon(Icons.lock),

                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      obscureOldPassword = !obscureOldPassword;
                    });
                  },

                  icon: Icon(
                    obscureOldPassword
                        ? Icons.visibility_off
                        : Icons.visibility,
                  ),
                ),

                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            const SizedBox(height: 16),

            // PASSWORD BARU
            TextField(
              controller: newPasswordController,

              obscureText: obscureNewPassword,

              decoration: InputDecoration(
                labelText: "Password Baru",

                prefixIcon: const Icon(Icons.lock),

                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      obscureNewPassword = !obscureNewPassword;
                    });
                  },

                  icon: Icon(
                    obscureNewPassword
                        ? Icons.visibility_off
                        : Icons.visibility,
                  ),
                ),

                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            const SizedBox(height: 16),

            // KONFIRMASI PASSWORD
            TextField(
              controller: confirmPasswordController,

              obscureText: obscureConfirmPassword,

              decoration: InputDecoration(
                labelText: "Konfirmasi Password",

                prefixIcon: const Icon(Icons.lock),

                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      obscureConfirmPassword = !obscureConfirmPassword;
                    });
                  },

                  icon: Icon(
                    obscureConfirmPassword
                        ? Icons.visibility_off
                        : Icons.visibility,
                  ),
                ),

                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            const SizedBox(height: 24),

            SizedBox(
              width: double.infinity,

              height: 50,

              child: ElevatedButton(
                onPressed: isLoading
                    ? null
                    : () {
                        changePassword();
                      },

                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1A58B7),

                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),

                child: isLoading
                    ? const SizedBox(
                        width: 20,

                        height: 20,

                        child: CircularProgressIndicator(
                          strokeWidth: 2,

                          color: Colors.white,
                        ),
                      )
                    : const Text(
                        "Simpan Password",

                        style: TextStyle(
                          color: Colors.white,

                          fontSize: 16,

                          fontWeight: FontWeight.w600,
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
