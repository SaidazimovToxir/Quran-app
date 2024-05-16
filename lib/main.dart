import 'package:al_quran/pages/home_page.dart';
import 'package:al_quran/pages/splash_pages/onboarding_screen.dart';
import 'package:al_quran/pages/splash_pages/welcome_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
