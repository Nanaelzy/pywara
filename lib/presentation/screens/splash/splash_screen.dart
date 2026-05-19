import 'package:flutter/material.dart';
import '../auth/signup_screen.dart'; 
import '../auth/login_screen.dart'; 

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity, 
        height: double.infinity, 
        clipBehavior: Clip.antiAlias,
        decoration: const BoxDecoration(color: Colors.black),
        child: Stack(
          children: [
            // Background Gradient
            Positioned(
              left: 0,
              top: 0,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: const ShapeDecoration(
                  gradient: LinearGradient(
                    begin: Alignment(0.50, -0.00),
                    end: Alignment(0.50, 1.00),
                    colors: [Colors.white, Color(0xFFFFEEEB)],
                  ),
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      width: 1,
                      color: Color(0xFFFFEEEC),
                    ),
                  ),
                ),
              ),
            ),
            
            // Teks: Your AI-Powered Python Learning Companion
            const Positioned(
              left: 59,
              top: 473,
              child: SizedBox(
                width: 294,
                child: Text(
                  'Your AI-Powered Python Learning\nCompanion',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF960606),
                    fontSize: 17,
                    fontFamily: 'Inter', 
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),

            // Teks: PyWara
            const Positioned(
              left: 130,
              top: 418,
              child: Text(
                'PyWara',
                style: TextStyle(
                  color: Color(0xFF960606),
                  fontSize: 40,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),

            // Tombol: Start Your Journey
            Positioned(
              left: 27,
              right: 27, 
              top: 721,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SignUpScreen()),
                  );
                },
                child: Container(
                  height: 62,
                  decoration: ShapeDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment(0.00, 0.50),
                      end: Alignment(1.00, 0.50),
                      colors: [Color(0xFFD60000), Color(0xFF960505)],
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Center(
                    child: Text(
                      'Start Your Journey',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15.50,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // Tombol: I Already Have an Account
            Positioned(
              left: 27,
              right: 27, 
              top: 797,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginScreen()),
                  );
                },
                child: Container(
                  height: 62,
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(
                        width: 2.50,
                        color: Color(0xFFFEE4E1),
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Center(
                    child: Text(
                      'I Already Have an Account',
                      style: TextStyle(
                        color: Color(0xFF960606),
                        fontSize: 15.50,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // Bagian Logo Utama (Sekarang sudah aman karena package telah di-import)
            Positioned(
              left: 121,
              top: 210,
              child: Image.asset(
                'assets/images/logoutama.png', // Jalur file PNG Anda
                width: 169,                    // Menentukan lebar langsung
                height: 226,                   // Menentukan tinggi langsung
                fit: BoxFit.contain,           // Menjaga proporsi gambar tetap aman
              ),
            ),       
          ],
        ),
      ),
    );
  }
}