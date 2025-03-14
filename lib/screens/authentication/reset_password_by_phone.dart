import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:my_practice/screens/authentication/reset_psw_verification_phone.dart';

class PhoneResetPasswordPage extends StatefulWidget {
  const PhoneResetPasswordPage({super.key});

  @override
  _PhoneResetPasswordPageState createState() => _PhoneResetPasswordPageState();
}

class _PhoneResetPasswordPageState extends State<PhoneResetPasswordPage> {
  String phoneNumber = '';
  PhoneNumber number = PhoneNumber(isoCode: 'US');
  // Define purpleColor as static to avoid the exception
  static const Color purpleColor = Color(0xFF54408C);
  final TextEditingController _phoneController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  bool _isInitialized = false;
  void _continueToNextScreen() {
    String fullPhoneNumber =
        number.phoneNumber ?? '${number.dialCode}$phoneNumber';

    if (fullPhoneNumber.isNotEmpty && phoneNumber.length >= 6) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => ResetPasswordVerificationPhoneScreen(
              fullPhoneNumber: fullPhoneNumber),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid phone number')),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    // Focus the field when the screen loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_isInitialized) {
        FocusScope.of(context).requestFocus(_focusNode);
        _isInitialized = true;
      }
    });

    // Your existing listener code
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        // Keep the focus but prevent system keyboard
        FocusScope.of(context).requestFocus(_focusNode);
      }
    });
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _addDigit(String digit) {
    setState(() {
      if (phoneNumber.length < 15) {
        // Limiting to typical max phone length
        phoneNumber += digit;
        _phoneController.text = phoneNumber;
        _phoneController.selection = TextSelection.fromPosition(
          TextPosition(offset: _phoneController.text.length),
        );

        // Update the full phone number with country code
        number = PhoneNumber(
          isoCode: number.isoCode,
          dialCode: number.dialCode,
          phoneNumber: "${number.dialCode}$phoneNumber",
        );
      }
    });
  }

  void _deleteDigit() {
    setState(() {
      if (phoneNumber.isNotEmpty) {
        phoneNumber = phoneNumber.substring(0, phoneNumber.length - 1);
        _phoneController.text = phoneNumber;
        _phoneController.selection = TextSelection.fromPosition(
          TextPosition(offset: _phoneController.text.length),
        );
      }
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 16),
                      const Text(
                        'Reset Password',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Please enter your phone number, we will send a verification code to your phone number.',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Phone Number',
                              style: TextStyle(
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                color: Color(0xFF121212),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.grey.shade100,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
                                children: [
                                  // Phone icon container
                                  Container(
                                    padding: const EdgeInsets.only(left: 16),
                                    child: Image.asset(
                                      'lib/assets/icons/phone_icon.png',
                                      width: 24,
                                      height: 24,
                                    ),
                                  ),
                                  // Phone input field
                                  Expanded(
                                    child: InternationalPhoneNumberInput(
                                      onInputChanged: (PhoneNumber newNumber) {
                                        setState(() {
                                          number = newNumber;
                                          phoneNumber =
                                              newNumber.phoneNumber ?? '';
                                        });
                                      },
                                      selectorConfig: const SelectorConfig(
                                        selectorType:
                                            PhoneInputSelectorType.BOTTOM_SHEET,
                                        showFlags: false,
                                        setSelectorButtonAsPrefixIcon: true,
                                        leadingPadding: 16,
                                      ),
                                      ignoreBlank: false,
                                      autoValidateMode:
                                          AutovalidateMode.disabled,
                                      selectorTextStyle:
                                          const TextStyle(color: Colors.black),
                                      textFieldController: _phoneController,
                                      focusNode: _focusNode,
                                      formatInput: true,
                                      keyboardType: TextInputType
                                          .none, // Prevent system keyboard
                                      inputDecoration: InputDecoration(
                                        hintText: 'Phone Number',
                                        hintStyle: TextStyle(
                                            color: Colors.grey.shade400),
                                        filled: true,
                                        fillColor: Colors.grey.shade100,
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          borderSide: BorderSide.none,
                                        ),
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                horizontal: 16, vertical: 14),
                                        prefixIcon: Padding(
                                          padding: const EdgeInsets.all(12),
                                          child: StatefulBuilder(
                                            builder: (context, setState) {
                                              // Format the dial code with parentheses
                                              String formattedDialCode =
                                                  "( ${number.dialCode ?? "+1"} )";
                                              // Ensure the dial code has parentheses
                                              if (!formattedDialCode
                                                  .startsWith('(')) {
                                                formattedDialCode =
                                                    '($formattedDialCode)';
                                              }
                                              return Text(
                                                formattedDialCode,
                                                style: const TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                      selectorButtonOnErrorPadding: 0,
                                      spaceBetweenSelectorAndTextField: 0,
                                      onSaved: (PhoneNumber number) {
                                        // Save the phone number
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                      ElevatedButton(
                        onPressed: _continueToNextScreen,
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
            // Custom numeric keyboard
            Flexible(
              child: Container(
                width: double.infinity,
                color: const Color.fromARGB(255, 255, 255, 255),
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
                        _buildSpecialKey('+'),
                        _buildNumberKey('0'),
                        InkWell(
                          onTap: _deleteDigit,
                          child: const SizedBox(
                            width: 60,
                            height: 60,
                            child: Center(
                              child: Icon(
                                Icons.backspace_outlined,
                                color: purpleColor,
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
      ),
    );
  }

  Widget _buildNumberKey(String digit) {
    return InkWell(
      onTap: () => _addDigit(digit),
      child: SizedBox(
        width: 60,
        height: 60,
        child: Center(
          child: Text(
            digit,
            style: const TextStyle(
              color: purpleColor,
              fontSize: 24,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSpecialKey(String symbol) {
    return InkWell(
      onTap: () => _addDigit(symbol),
      child: SizedBox(
        width: 60,
        height: 60,
        child: Center(
          child: Text(
            symbol,
            style: const TextStyle(
              color: purpleColor,
              fontSize: 24,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
