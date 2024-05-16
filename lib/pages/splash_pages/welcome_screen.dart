import 'package:al_quran/pages/home_page.dart';
import 'package:al_quran/pages/splash_pages/onboarding_screen.dart';
import 'package:al_quran/utils/my_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 3),
    vsync: this,
  )..repeat(reverse: true);
  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.fastOutSlowIn,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _loadNextScreen();
  }

  void _loadNextScreen() {
    Future.delayed(
      Duration(seconds: 3),
      () {
        Navigator.of(context).pushReplacement(
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                const OnboardingScreen(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              const begin = Offset(1.0, 0.0);
              const end = Offset.zero;
              const curve = Curves.ease;
              var tween =
                  Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
              var offsetAnimation = animation.drive(tween);
              return SlideTransition(
                position: offsetAnimation,
                child: child,
              );
            },
            transitionDuration: const Duration(milliseconds: 250),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              "assets/logo/splash_screen.png",
              fit: BoxFit.cover,
              // color: Colors.black26,
            ),
          ),
          Column(
            children: [
              const Spacer(flex: 2),
              Center(
                child: ScaleTransition(
                  scale: _animation,
                  child: Column(
                    children: [
                      Image.asset(
                        "assets/logo/logo.png",
                        height: 150,
                        width: 150,
                        color: MyColor.mainColor,
                      ),
                      const Text(
                        "Quran",
                        style: TextStyle(
                          color: Colors.white60,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Spacer(flex: 2),
            ],
          ),
        ],
      ),
    );
  }
}
