import 'package:flutter/material.dart';
import 'package:my_practice/screens/authentication/login_page.dart';
import 'package:my_practice/screens/authentication/email_verification_code_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController emailController = TextEditingController();
  bool _obscurePassword = true;
  bool _passwordFieldTouched = false;

  // Password validation states
  bool _hasMinLength = false;
  bool _hasNumber = false;
  bool _hasLetter = false;

  void _validatePassword(String value) {
    setState(() {
      _passwordFieldTouched = true;
      _hasMinLength = value.length >= 8;
      _hasNumber = RegExp(r'[0-9]').hasMatch(value);
      _hasLetter = RegExp(r'[a-zA-Z]').hasMatch(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const LoginPage()),
            );
          },
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
              top: 16.0, bottom: 56.0, left: 24.0, right: 24.0),
          child: Column(
            children: [
              // Main content in a scrollable area
              Expanded(
                child: ListView(
                  children: [
                    const Text(
                      'Sign Up',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Create account and choose favorite menu',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 25),
                    const Text(
                      'Name',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: Color(0xFF121212),
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      decoration: InputDecoration(
                        hintText: 'Your name',
                        hintStyle: TextStyle(color: Colors.grey.shade400),
                        filled: true,
                        fillColor: Colors.grey.shade100,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 14),
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Email',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: Color(0xFF121212),
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                        hintText: 'Your email',
                        hintStyle: TextStyle(color: Colors.grey.shade400),
                        filled: true,
                        fillColor: Colors.grey.shade100,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 14),
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Password',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      obscureText: _obscurePassword,
                      onChanged: _validatePassword,
                      decoration: InputDecoration(
                        hintText: 'Your password',
                        hintStyle: TextStyle(color: Colors.grey.shade400),
                        filled: true,
                        fillColor: Colors.grey.shade100,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 14),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscurePassword
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: Colors.grey,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscurePassword = !_obscurePassword;
                            });
                          },
                        ),
                      ),
                    ),

                    // Password validation indicators - only show when password field is touched
                    if (_passwordFieldTouched) ...[
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Icon(
                            _hasMinLength ? Icons.check : Icons.close,
                            color: _hasMinLength
                                ? const Color.fromARGB(255, 113, 85, 187)
                                : Colors.red,
                            size: 16,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Minimum 8 characters',
                            style: TextStyle(
                              color: _hasMinLength ? Colors.grey : Colors.red,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(
                            _hasNumber ? Icons.check : Icons.close,
                            color: _hasNumber
                                ? const Color.fromARGB(255, 113, 85, 187)
                                : Colors.grey,
                            size: 16,
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            'At least 1 number (1-9)',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(
                            _hasLetter ? Icons.check : Icons.close,
                            color: _hasLetter
                                ? const Color.fromARGB(255, 113, 85, 187)
                                : Colors.grey,
                            size: 16,
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            'At least lowercase or uppercase letters',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ],

                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: () {
                        FocusScope.of(context).unfocus();
                        // Có thể thêm kiểm tra trước khi chuyển trang
                        if (emailController.text.isNotEmpty) {
                          Future.delayed(const Duration(milliseconds: 500), () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => VerificationEmailScreen(
                                  email: emailController.text,
                                ),
                              ),
                            );
                          });
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF54408C),
                        foregroundColor: Colors.white,
                        minimumSize: const Size(double.infinity, 52),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(26),
                        ),
                      ),
                      child: const Text(
                        'Register',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Have an account?",
                          style: TextStyle(
                              color: Colors.grey, fontSize: 14, height: 1.4),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LoginPage()),
                            );
                          },
                          child: const Text(
                            'Sign In',
                            style: TextStyle(
                              color: Color(0xFF54408C),
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              height: 1.4,
                            ),
                          ),
                        ),
                      ],
                    ),
                    // Thêm spacing để đảm bảo content không bị che khuất bởi phần Terms policy
                    const SizedBox(height: 40),
                  ],
                ),
              ),

              // Terms and policy fixed at bottom
              const Padding(
                padding: EdgeInsets.only(bottom: 20.0),
                child: Column(
                  children: [
                    Text(
                      'By clicking "Register", you agree to our',
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Terms and Data Policy',
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xFF54408C),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
