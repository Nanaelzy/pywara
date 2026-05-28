import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'intro_screen4.dart';

class IntroScreen3 extends StatelessWidget {
  const IntroScreen3({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: 1.sw,
        height: 1.sh,
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

            // 2. Icon Puzzle 🧩
            Positioned(
              left: 0,
              right: 0,
              top: 250.h,
              child: Center(
                child: Text('🧩', style: TextStyle(fontSize: 120.sp)),
              ),
            ),

            // 3. Title Text
            Positioned(
              left: 0,
              right: 0,
              top: 436.h,
              child: Center(
                child: Text(
                  'Interactive Challenges',
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
              right: 60.w,
              top: 480.h,
              child: SizedBox(
                width: 294.w,
                child: Text(
                  'Learn through multiple choice, code arrangement, and fill-in-the-blank exercises.',
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

            // 5. Pagination Indicators (Slide 3 Aktif)
            Positioned(
              left: 0,
              right: 0,
              top: 780.h,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildIndicator(width: 15.w, isActive: false),
                  SizedBox(width: 5.w),
                  _buildIndicator(width: 15.w, isActive: false),
                  SizedBox(width: 5.w),
                  _buildIndicator(width: 38.w, isActive: true),
                  SizedBox(width: 5.w),
                  _buildIndicator(width: 15.w, isActive: false),
                ],
              ),
            ),

            // 6. Tombol Next
            Positioned(
              left: 27.w,
              right: 27.w,
              top: 816.h,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const IntroScreen4(),
                    ),
                  );
                },
                child: Container(
                  height: 62.h,
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 2.50.w,
                        color: const Color(0xFFFEE4E1),
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
