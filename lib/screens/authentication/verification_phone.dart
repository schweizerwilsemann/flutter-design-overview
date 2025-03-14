import 'package:flutter/material.dart';
import 'package:my_practice/screens/authentication/congrats_page.dart';

class PhoneVerificationCodeScreen extends StatefulWidget {
  final String fullPhoneNumber;

  const PhoneVerificationCodeScreen({Key? key, required this.fullPhoneNumber})
      : super(key: key);

  @override
  State<PhoneVerificationCodeScreen> createState() =>
      Phone_VerificatioCodenScreenState();
}

class Phone_VerificatioCodenScreenState
    extends State<PhoneVerificationCodeScreen> {
  // List to store the verification code digits
  List<String> codeDigits = ['', '', '', ''];
  int currentDigitIndex = 0; // Index of the current digit being entered
  final purpleColor = const Color(0xFF54408C);

  // Controller for blinking cursor
  bool showCursor = true;

  @override
  void initState() {
    super.initState();
    // Set up blinking cursor
    _setupBlinkingCursor();
  }

  void _setupBlinkingCursor() {
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) {
        setState(() {
          showCursor = !showCursor;
        });
        _setupBlinkingCursor(); // Continue blinking
      }
    });
  }

  void _updateDigit(String digit) {
    if (currentDigitIndex < 4) {
      setState(() {
        codeDigits[currentDigitIndex] = digit;
        if (currentDigitIndex < 3) {
          currentDigitIndex++;
        } else {
          // We've completed the code, navigate to next screen
          _navigateToNextScreen();
        }
      });
    }
  }

  void _deleteDigit() {
    if (currentDigitIndex >= 0) {
      setState(() {
        if (codeDigits[currentDigitIndex].isNotEmpty) {
          codeDigits[currentDigitIndex] = '';
        } else if (currentDigitIndex > 0) {
          currentDigitIndex--;
          codeDigits[currentDigitIndex] = '';
        }
      });
    }
  }

  void _navigateToNextScreen() {
    // Delay navigation slightly to allow the user to see the filled code
    Future.delayed(const Duration(milliseconds: 200), () {
      // Implement navigation logic here
      // For example:
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const CongratulationsScreen()),
      );

      // For now, just show a snackbar to indicate success
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Verification code completed!')),
      );
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
              Navigator.pop(context);
            },
          ),
        ),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      children: [
                        const SizedBox(height: 24),
                        const Text(
                          'Verification Phone',
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            text:
                                'Please enter the code we just sent to phone\nnumber ',
                            style: const TextStyle(
                                color: Colors.grey, fontSize: 14),
                            children: <TextSpan>[
                              TextSpan(
                                text: widget.fullPhoneNumber.isNotEmpty
                                    ? widget.fullPhoneNumber
                                    : '',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(155, 19, 4, 90),
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 42),
                        // Nhập mã code
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                            4,
                            (index) => GestureDetector(
                              onTap: () {
                                setState(() {
                                  currentDigitIndex = index;
                                });
                              },
                              child: Container(
                                width: 45,
                                height: 45,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: currentDigitIndex == index
                                        ? purpleColor
                                        : purpleColor.withOpacity(0.3),
                                    width: 1.5,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        codeDigits[index],
                                        style: const TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      // Show blinking cursor in the current digit field if empty
                                      if (currentDigitIndex == index &&
                                          codeDigits[index].isEmpty &&
                                          showCursor)
                                        Container(
                                          width: 2,
                                          height: 24,
                                          color: purpleColor,
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 18),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "If you didn't receive a code? ",
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 14),
                            ),
                            GestureDetector(
                              onTap: () {
                                // Implement resend functionality
                              },
                              child: Text(
                                'Resend',
                                style: TextStyle(
                                    color: purpleColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 36),
                        ElevatedButton(
                          onPressed: () {
                            bool isCodeComplete = !codeDigits.contains('');
                            if (isCodeComplete) {
                              _navigateToNextScreen();
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: purpleColor,
                            foregroundColor: Colors.white,
                            minimumSize: const Size(double.infinity, 52),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(26),
                            ),
                          ),
                          child: const Text(
                            'Continue',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              // Bàn phím số
              Flexible(
                child: Container(
                  width: double.infinity,
                  color: purpleColor,
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildNumberKey('1'),
                          _buildNumberKey('2'),
                          _buildNumberKey('3'),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildNumberKey('4'),
                          _buildNumberKey('5'),
                          _buildNumberKey('6'),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildNumberKey('7'),
                          _buildNumberKey('8'),
                          _buildNumberKey('9'),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildEmptyKey(),
                          _buildNumberKey('0'),
                          InkWell(
                            onTap: _deleteDigit,
                            child: const SizedBox(
                              width: 60,
                              height: 60,
                              child: Center(
                                child: Icon(
                                  Icons.backspace_outlined,
                                  color: Colors.white,
                                  size: 24,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  Widget _buildNumberKey(String digit) {
    return InkWell(
      onTap: () => _updateDigit(digit),
      child: SizedBox(
        width: 60,
        height: 60,
        child: Center(
          child: Text(
            digit,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyKey() {
    return const SizedBox(
      width: 60,
      height: 60,
    );
  }
}
