import 'package:flutter/material.dart';

import 'screens/splash_page.dart';

void main() {
  runApp(const CrochetApp());
}

class CrochetApp extends StatelessWidget {
  const CrochetApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Crochet App",
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 48, 120, 255),
        ),
      ),
      home: const SplashPage(),
    );
  }
}
