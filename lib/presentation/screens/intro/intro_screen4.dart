import 'package:flutter/material.dart';

class IntroScreen4 extends StatelessWidget {
  const IntroScreen4({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        clipBehavior: Clip.antiAlias,
        decoration: const BoxDecoration(color: Colors.black),
        child: Stack(
          children: [
            // 1. Background Gradient Merah
            Positioned(
              left: 0,
              top: 0,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment(1.00, 0.38),
                    end: Alignment(0.00, 0.00),
                    colors: [Color(0xFF810202), Color(0xFFD70000)],
                  ),
                ),
              ),
            ),

            // 2. Icon Robot Assistant 🤖
            const Positioned(
              left: 0,
              right: 0,
              top: 250, // Tetap konsisten posisinya dengan slide 1, 2, dan 3
              child: Center(child: Text('🤖', style: TextStyle(fontSize: 120))),
            ),

            // 3. Title Text
            const Positioned(
              left: 0,
              right: 0,
              top: 436,
              child: Center(
                child: Text(
                  'Ask for Help Anytime',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),

            // 4. Description Text
            const Positioned(
              left: 60,
              right: 60,
              top: 480,
              child: SizedBox(
                width: 294,
                child: Text(
                  'Stuck? Your AI assistant is always ready to provide hints and explanations!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    height: 1.5,
                  ),
                ),
              ),
            ),

            // 5. Pagination Indicators (Slide 4 Aktif di Paling Ujung)
            Positioned(
              left: 0,
              right: 0,
              top: 780,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildIndicator(width: 15, isActive: false),
                  const SizedBox(width: 5),
                  _buildIndicator(width: 15, isActive: false),
                  const SizedBox(width: 5),
                  _buildIndicator(width: 15, isActive: false),
                  const SizedBox(width: 5),
                  _buildIndicator(
                    width: 38,
                    isActive: true,
                  ), // Slide 4 yang aktif memanjang
                ],
              ),
            ),

            // 6. Tombol Aksi Akhir - Get Started (Menuju Login)
            Positioned(
              left: 27,
              right: 27,
              top: 816,
              child: GestureDetector(
                onTap: () {
                  debugPrint('Tombol login ditekan');
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
                      'Get Started  ✓',
                      style: TextStyle(
                        color: Color(0xFF960606),
                        fontSize: 16,
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
      height: 10,
      decoration: ShapeDecoration(
        color: isActive ? Colors.white : const Color(0x77D9D9D9),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
    );
  }
}