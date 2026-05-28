import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // Pastikan import ini ada
import 'intro_screen2.dart';

class IntroScreen1 extends StatelessWidget {
  const IntroScreen1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: 1.sw, // Menggunakan screen width
        height: 1.sh, // Menggunakan screen height
        clipBehavior: Clip.antiAlias,
        decoration: const BoxDecoration(color: Colors.black),
        child: Stack(
          children: [
            // 1. Background Gradient Merah
            Container(
              width: 1.sw,
              height: 1.sh,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment(1.00, 0.38),
                  end: Alignment(0.00, 0.00),
                  colors: [Color(0xFF810202), Color(0xFFD70000)],
                ),
              ),
            ),

            // 2. Icon Target 🎯
            Positioned(
              left: 0,
              right: 0,
              top: 250.h,
              child: Center(
                child: Text('🎯', style: TextStyle(fontSize: 120.sp)),
              ),
            ),

            // 3. Welcome Text
            Positioned(
              left: 0,
              right: 0,
              top: 436.h,
              child: Center(
                child: Text(
                  'Welcome to PyWara!',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22.sp,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),

            // 4. Description Text
            Positioned(
              left: 60.w,
              top: 480.h,
              child: SizedBox(
                width: 294.w,
                child: Text(
                  'Your AI companion will guide you through interactive Python lessons designed for beginners.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15.sp,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    height: 1.5,
                  ),
                ),
              ),
            ),

            // 5. Pagination Indicators
            Positioned(
              left: 0,
              right: 0,
              top: 780.h,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildIndicator(width: 38.w, isActive: true),
                  SizedBox(width: 5.w),
                  _buildIndicator(width: 15.w, isActive: false),
                  SizedBox(width: 5.w),
                  _buildIndicator(width: 15.w, isActive: false),
                  SizedBox(width: 5.w),
                  _buildIndicator(width: 15.w, isActive: false),
                ],
              ),
            ),

            // 6. Tombol Next
            Positioned(
              left: 27.w,
              top: 816.h,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const IntroScreen2(),
                    ),
                  );
                },
                child: Container(
                  width: 358.w,
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
                      'Next  >',
                      style: TextStyle(
                        color: const Color(0xFF960606),
                        fontSize: 16.sp,
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

  Widget _buildIndicator({required double width, required bool isActive}) {
    return Container(
      width: width,
      height: 10.h,
      decoration: ShapeDecoration(
        color: isActive ? Colors.white : const Color(0x77D9D9D9),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
      ),
    );
  }
}
