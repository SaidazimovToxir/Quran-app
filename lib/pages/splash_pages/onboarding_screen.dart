import 'package:al_quran/models/onboarding_model.dart';
import 'package:al_quran/pages/home_page.dart';
import 'package:al_quran/utils/my_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int _currentIndex = 0;
  PageController _controller = PageController();

  @override
  void initState() {
    _controller = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenW = MediaQuery.of(context).size.width;
    double screenH = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: MyColor.mainColor,
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _controller,
              itemCount: contents.length,
              onPageChanged: (int index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              itemBuilder: (_, i) {
                return Column(
                  children: [
                    const Gap(50.0),
                    Expanded(
                      child: Image.asset(
                        contents[i].topLogo,
                        width: 150,
                        height: 150,
                        // color: MyColor.mainColor,
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40.0),
                        child: Text(
                          contents[i].description,
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    Container(
                      width: screenW * 0.9,
                      // height: screenH * 0.8,
                      child: Image.asset(contents[i].image),
                    )
                  ],
                );
              },
            ),
          ),

          /// [Dots -> Scrool dots]
          SizedBox(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                3,
                (index) => buildDot(index, context),
              ),
            ),
          ),

          /// [Buttons -> Next and Continue]
          Container(
            height: 50,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color.fromARGB(255, 104, 162, 167),
                  Color.fromARGB(255, 36, 76, 80),
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color:
                      const Color.fromARGB(255, 71, 141, 149).withOpacity(0.6),
                  offset: const Offset(3.0, 4.0),
                  blurRadius: 12.0,
                  spreadRadius: 1,
                ),
              ],
              borderRadius: BorderRadius.circular(50),
            ),
            margin: const EdgeInsets.only(
              left: 40.0,
              right: 40.0,
              top: 40.0,
              bottom: 80.0,
            ),
            child: TextButton(
              onPressed: () {
                if (_currentIndex == contents.length - 1) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HomePage(),
                    ),
                  );
                }

                _controller.nextPage(
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.decelerate, //! o'zgarishi kerak
                );
              },
              child: Text(
                _currentIndex == contents.length - 1 ? "Continue" : "Next",
                style: const TextStyle(
                  letterSpacing: 2,
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  AnimatedContainer buildDot(int index, BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: 5,
      width: _currentIndex == index ? 20 : 5,
      margin: const EdgeInsets.only(right: 4),
      decoration: BoxDecoration(
        color: _currentIndex == index
            ? const Color.fromARGB(255, 6, 181, 197)
            : const Color.fromARGB(255, 228, 234, 234),
        borderRadius: _currentIndex == index
            ? BorderRadius.circular(50)
            : BorderRadius.circular(100),
      ),
      child: AnimatedOpacity(
        opacity: _currentIndex == index ? 1.0 : 0.5,
        duration: const Duration(
          milliseconds: 300,
        ),
      ),
    );
  }
}
