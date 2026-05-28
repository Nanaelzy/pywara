import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // Tambahkan import ini
import 'intro_screen3.dart';

class IntroScreen2 extends StatelessWidget {
  const IntroScreen2({super.key});

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

            // 2. Icon Trophy 🏆
            Positioned(
              left: 0,
              right: 0,
              top: 250.h, // Tambah .h
              child: Center(
                child: Text('🏆', style: TextStyle(fontSize: 120.sp)),
              ), // Tambah .sp
            ),

            // 3. Title Text
            Positioned(
              left: 0,
              right: 0,
              top: 436.h, // Tambah .h
              child: Center(
                child: Text(
                  'Earn XP & Streak',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22.sp, // Tambah .sp
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),

            // 4. Description Text
            Positioned(
              left: 60.w, // Tambah .w
              right: 60.w, // Tambah .w
              top: 480.h, // Tambah .h
              child: SizedBox(
                width: 294.w, // Tambah .w
                child: Text(
                  'Complete challenges daily to build your streak and earn experience points!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15.sp, // Tambah .sp
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
              top: 780.h, // Tambah .h
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildIndicator(width: 15.w, isActive: false), // Tambah .w
                  SizedBox(width: 5.w), // Tambah .w
                  _buildIndicator(width: 38.w, isActive: true), // Tambah .w
                  SizedBox(width: 5.w), // Tambah .w
                  _buildIndicator(width: 15.w, isActive: false), // Tambah .w
                  SizedBox(width: 5.w), // Tambah .w
                  _buildIndicator(width: 15.w, isActive: false), // Tambah .w
                ],
              ),
            ),

            // 6. Tombol Next
            Positioned(
              left: 27.w, // Tambah .w
              right: 27.w, // Tambah .w
              top: 816.h, // Tambah .h
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const IntroScreen3(),
                    ),
                  );
                },
                child: Container(
                  height: 62.h, // Tambah .h
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 2.50.w, // Tambah .w
                        color: const Color(0xFFFEE4E1),
                      ),
                      borderRadius: BorderRadius.circular(20.r), // Tambah .r
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'Next  >',
                      style: TextStyle(
                        color: const Color(0xFF960606),
                        fontSize: 16.sp, // Tambah .sp
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

  // Helper untuk membuat garis indikator slide
  Widget _buildIndicator({required double width, required bool isActive}) {
    return Container(
      width: width,
      height: 10.h, // Tambah .h
      decoration: ShapeDecoration(
        color: isActive ? Colors.white : const Color(0x77D9D9D9),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ), // Tambah .r
      ),
    );
  }
}
