import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
            // 1. Background Gradient (Positioned.fill agar otomatis memenuhi seluruh layar)
            Positioned.fill(
              child: Container(
                decoration: const ShapeDecoration(
                  gradient: LinearGradient(
                    begin: Alignment(0.50, -0.00),
                    end: Alignment(0.50, 1.00),
                    colors: [Colors.white, Color(0xFFFFEEEB)],
                  ),
                  shape: RoundedRectangleBorder(
                    side: BorderSide(width: 1, color: Color(0xFFFFEEEC)),
                  ),
                ),
              ),
            ),

            // 2. Bagian Logo Utama (Tengah Horizontal)
            Positioned(
              top: 210.h,
              left: 0,
              right: 0,
              child: Center(
                child: Image.asset(
                  'assets/images/logoutama.png',
                  width: 169.w,
                  height: 226.h,
                  fit: BoxFit.contain,
                ),
              ),
            ),

            // 3. Teks: PyWara (Tengah Horizontal)
            Positioned(
              top: 418.h,
              left: 0,
              right: 0,
              child: Text(
                'PyWara',
                textAlign: TextAlign.center, // Otomatis ke tengah
                style: TextStyle(
                  color: const Color(0xFF960606),
                  fontSize: 40.sp,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),

            // 4. Teks: Your AI-Powered Python Learning Companion (Tengah Horizontal)
            Positioned(
              top: 473.h,
              left: 0,
              right: 0,
              child: Text(
                'Your AI-Powered Python Learning\nCompanion',
                textAlign: TextAlign.center, // Otomatis ke tengah
                style: TextStyle(
                  color: const Color(0xFF960606),
                  fontSize: 17.sp,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),

            // 5. Tombol: Start Your Journey (DIJANGKAR KE BAWAH)
            Positioned(
              bottom: 109
                  .h, // Menggunakan bottom agar tidak nabrak teks di atasnya pada HP kecil
              left: 27.w,
              right: 27.w,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SignUpScreen(),
                    ),
                  );
                },
                child: Container(
                  height: 62.h,
                  decoration: ShapeDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment(0.00, 0.50),
                      end: Alignment(1.00, 0.50),
                      colors: [Color(0xFFD60000), Color(0xFF960505)],
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'Start Your Journey',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15.50.sp,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // 6. Tombol: I Already Have an Account (DIJANGKAR KE BAWAH)
            Positioned(
              bottom: 33
                  .h, // Menggunakan bottom agar selalu ada jarak pas di tepi bawah layar
              left: 27.w,
              right: 27.w,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginScreen(),
                    ),
                  );
                },
                child: Container(
                  height: 62.h,
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(
                        width: 2.50,
                        color: Color(0xFFFEE4E1),
                      ),
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'I Already Have an Account',
                      style: TextStyle(
                        color: const Color(0xFF960606),
                        fontSize: 15.50.sp,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
