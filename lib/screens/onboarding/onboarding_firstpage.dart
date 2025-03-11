import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class OnboardingFirstPage extends StatefulWidget {
  const OnboardingFirstPage({super.key});

  @override
  _OnboardingFirstPageState createState() => _OnboardingFirstPageState();
}

class _OnboardingFirstPageState extends State<OnboardingFirstPage> {
  int _currentIndex = 0;
  final List<String> imgList = [
    'assets/image1.png',
    'assets/image2.png',
    'assets/image3.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CarouselSlider(
            options: CarouselOptions(
              height: 320.0,
              onPageChanged: (index, reason) {
                setState(() {
                  _currentIndex = index;
                });
              },
            ),
            items: imgList
                .map((item) => Center(
                      child: Image.asset(item, fit: BoxFit.cover, width: 320.0),
                    ))
                .toList(),
          ),
          const SizedBox(height: 20),
          const Text(
            'Title',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          const Text(
            'Subtitle',
            style: TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: imgList.map((url) {
              int index = imgList.indexOf(url);
              return Container(
                width: 8.0,
                height: 8.0,
                margin:
                    const EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _currentIndex == index
                      ? const Color(0xFF54408C)
                      : const Color(0xFFD8D8D8),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // Navigate to another screen
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF54408C),
              minimumSize: const Size(327, 56),
            ),
            child: const Text('Continue'),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              // Sign in action
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFAF9FD),
              foregroundColor: Colors.black,
              minimumSize: const Size(327, 56),
            ),
            child: const Text('Sign In'),
          ),
        ],
      ),
    );
  }
}
