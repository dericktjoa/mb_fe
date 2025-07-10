import 'package:flutter/material.dart';
import 'package:mb_fe/appbar/custom_appbar.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  void showCustomSnackBar(String message, {Color? color}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: color ?? const Color(0xFF60B28C),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      ),
    );
  }

  void handleChangePassword() {
    final oldPassword = oldPasswordController.text;
    final newPassword = newPasswordController.text;
    final confirmPassword = confirmPasswordController.text;

    if (oldPassword.isEmpty || newPassword.isEmpty || confirmPassword.isEmpty) {
      showCustomSnackBar("All fields are required", color: Colors.red);
      return;
    }

    if (newPassword != confirmPassword) {
      showCustomSnackBar("New passwords do not match", color: Colors.red);
      return;
    }

    showCustomSnackBar("Password changed successfully!", color: Colors.green);
    Navigator.pop(context);
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
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primaryColor = isDark ? const Color(0xFF333739) : const Color(0xFF60B28C);
    final cardColor = isDark ? const Color(0xFF424242) : Colors.white;
    final inputFillColor = isDark ? const Color(0xFF303030) : Colors.grey[100];

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF212121) : const Color(0xFFF3F6FA),
      appBar: CustomAppBar(title: 'Change Password', showMenu: false),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 500),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 30),
            decoration: BoxDecoration(
              color: cardColor,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                if (!isDark)
                  const BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    offset: Offset(0, 5),
                  ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildLabel("Old Password"),
                _buildTextField(oldPasswordController, 'Enter your old password', inputFillColor),

                const SizedBox(height: 20),
                _buildLabel("New Password"),
                _buildTextField(newPasswordController, 'Enter your new password', inputFillColor),

                const SizedBox(height: 20),
                _buildLabel("Confirm New Password"),
                _buildTextField(confirmPasswordController, 'Confirm your new password', inputFillColor),

                const SizedBox(height: 30),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: handleChangePassword,
                    icon: const Icon(Icons.check, color: Colors.white),
                    label: Text(
                      "Change Password",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: const TextStyle(fontWeight: FontWeight.bold),
    );
  }

  Widget _buildTextField(
      TextEditingController controller, String hint, Color? fillColor) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final focusColor = isDark ? Colors.white : Color(0xFF60B28C);
    final enabledBorderColor = isDark ? Colors.grey.shade600 : Colors.grey.shade300;

    return TextField(
      controller: controller,
      obscureText: true,
      decoration: InputDecoration(
        hintText: hint,
        prefixIcon: const Icon(Icons.lock_outline),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: enabledBorderColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: enabledBorderColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: focusColor, width: 2),
        ),
        filled: true,
        fillColor: fillColor,
      ),
    );
  }
}
