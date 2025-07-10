import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mb_fe/bottom_nav.dart';

const mockUsers = {'test@example.com': 'password123'};

class loginPage extends StatefulWidget {
  const loginPage({super.key});

  @override
  State<loginPage> createState() => _loginPageState();
}

class _loginPageState extends State<loginPage> {
  Duration get loginTime => const Duration(milliseconds: 2250);

  Future<String?> _authUser(LoginData data) async {
    await Future.delayed(loginTime);
    if (!mockUsers.containsKey(data.name)) return 'Email not found';
    if (mockUsers[data.name] != data.password) return 'Wrong password';
    return null;
  }

  Future<String?> _signupUser(SignupData data) async {
    await Future.delayed(loginTime);
    return null;
  }

  Future<String?> _recoverPassword(String name) async {
    await Future.delayed(loginTime);
    return null;
  }

  void _handleLoginComplete() {
    Future.delayed(const Duration(milliseconds: 500), () {
      Navigator.of(
        context,
      ).pushReplacement(MaterialPageRoute(builder: (_) => const bottomNav()));
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: FlutterLogin(
              logo: AssetImage('lib/assets/images/lock_dark.png'),
              onLogin: _authUser,
              onSignup: _signupUser,
              onRecoverPassword: _recoverPassword,
              onSubmitAnimationCompleted: _handleLoginComplete,
              theme: LoginTheme(
                primaryColor:
                    isDark ? Colors.grey[900]! : const Color(0xFF81C784),
                accentColor:
                    isDark ? Colors.grey[700]! : Colors.lightGreenAccent,
                errorColor: Colors.redAccent,
                cardTheme: CardTheme(
                  color: isDark ? Colors.grey[850] : Colors.white,
                  elevation: 5,
                  margin: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                inputTheme: InputDecorationTheme(
                  filled: true,
                  fillColor: isDark ? Colors.grey[800] : Colors.white70,
                  labelStyle: TextStyle(
                    color: isDark ? Colors.white70 : Colors.black87,
                  ),
                  hintStyle: TextStyle(
                    color: isDark ? Colors.white54 : Colors.black54,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                buttonTheme: LoginButtonTheme(
                  backgroundColor:
                      isDark ? Colors.greenAccent.shade700 : Colors.green,
                  highlightColor:
                      isDark ? Colors.greenAccent : Colors.lightGreen,
                  splashColor: Colors.white,
                  elevation: 4.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                textFieldStyle: TextStyle(
                  color: isDark ? Colors.white : Colors.black,
                ),
                titleStyle: TextStyle(
                  color: isDark ? Colors.greenAccent : Colors.green[800],
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              messages: LoginMessages(
                passwordHint: 'Password',
                confirmPasswordHint: 'Confirm Password',
                loginButton: 'LOGIN',
                signupButton: 'REGISTER',
                forgotPasswordButton: 'Forgot password?',
                recoverPasswordButton: 'RECOVER',
                goBackButton: 'BACK',
                confirmPasswordError: 'Passwords do not match!',
                recoverPasswordIntro:
                    'Enter your email to recover your password',
                recoverPasswordSuccess: 'Password recovery email sent',
              ),
              loginProviders: <LoginProvider>[
                LoginProvider(
                  icon: FontAwesomeIcons.google,
                  label: 'Google',
                  callback: () async => null,
                ),
                LoginProvider(
                  icon: FontAwesomeIcons.instagram,
                  label: 'Instagram',
                  callback: () async => null,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
