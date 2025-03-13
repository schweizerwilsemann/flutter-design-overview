import 'package:flutter/material.dart';
import '/screens/authentication/login_page.dart';

class OnboardingFirstPage extends StatefulWidget {
  const OnboardingFirstPage({super.key});

  @override
  _OnboardingFirstPageState createState() => _OnboardingFirstPageState();
}

class _OnboardingFirstPageState extends State<OnboardingFirstPage> {
  int _currentIndex = 0;
  final PageController _pageController = PageController();

  final List<Map<String, String>> contentList = [
    {
      'image': 'lib/assets/images/onboarding/onboarding_image_1.png',
      'title': 'Now reading books\nwill be easier',
      'subtitle':
          'Discover new worlds, join a vibrant\nreading community. Start your reading\nadventure effortlessly with us.',
    },
    {
      'image': 'lib/assets/images/onboarding/onboarding_image_2.png',
      'title': 'Your Bookish Soulmate\nAwaits',
      'subtitle':
          'Let us be your guide to the perfect read.\nDiscover books tailored to your taste\nfor a truly rewarding experience.',
    },
    {
      'image': 'lib/assets/images/onboarding/onboarding_image_3.png',
      'title': 'Start Your Adventure',
      'subtitle':
          'Ready to embark on a quest for\ninspiration and knowledge? Your\nadventure begins now. Let\'s go!',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 320.0,
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: contentList.length,
                    onPageChanged: (index) {
                      setState(() {
                        _currentIndex = index;
                      });
                    },
                    itemBuilder: (context, index) {
                      return Center(
                        child: Image.asset(
                          contentList[index]['image']!,
                          fit: BoxFit.cover,
                          width: 320.0,
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 27),
                Container(
                  width: 292,
                  height: 64,
                  alignment: Alignment.center,
                  child: Text(
                    contentList[_currentIndex]['title']!,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'OpenSans',
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  width: 292,
                  height: 72,
                  alignment: Alignment.center,
                  child: Text(
                    contentList[_currentIndex]['subtitle']!,
                    style:
                        const TextStyle(fontSize: 16, color: Color(0xFFA6A6A6)),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: contentList.asMap().entries.map((entry) {
                    int index = entry.key;
                    return Container(
                      width: 8.0,
                      height: 8.0,
                      margin: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 2.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _currentIndex == index
                            ? const Color(0xFF54408C)
                            : const Color(0xFFD8D8D8),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 32),
                ElevatedButton(
                  onPressed: () {
                    if (_currentIndex == contentList.length - 3) {
                      _pageController.animateToPage(
                        _currentIndex + 1,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    } else {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginPage(),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF54408C),
                    minimumSize: const Size(327, 56),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    _currentIndex == contentList.length - 3
                        ? 'Continue'
                        : 'Get Started',
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginPage(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFAF9FD),
                    foregroundColor: Colors.black,
                    minimumSize: const Size(327, 56),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Sign In',
                    style: TextStyle(
                        fontFamily: 'OpenSans',
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 60,
            left: 24,
            bottom: 13,
            child: GestureDetector(
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginPage(),
                  ),
                );
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: const Text(
                  'Skip',
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 14,
                    color: Color(0xFF54408C),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
