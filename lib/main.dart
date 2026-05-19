import 'package:flutter/material.dart';
import 'presentation/screens/splash/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PyWara',
      debugShowCheckedModeBanner: false,
      // Panggil class SplashScreen di sini
      home: const SplashScreen(),
    );
  }
}
