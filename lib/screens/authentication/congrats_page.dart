import 'package:flutter/material.dart';

class CongratulationsScreen extends StatelessWidget {
  const CongratulationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Image with size constraint
              SizedBox(
                width: 160,
                height: 91,
                child: Image.asset(
                  'lib/assets/images/success/congrats.png',
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 20),
              // Congratulation text
              const Text(
                'Congratulation!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              // Description text
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 40),
                child: Text(
                  'your account is complete, please enjoy the\nbest menu from us.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                ),
              ),
              const SizedBox(height: 40),
              // Get Started button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      // Add your navigation logic here
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF54408C), // Purple color
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(26),
                      ),
                    ),
                    child: const Text(
                      'Get Started',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
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
