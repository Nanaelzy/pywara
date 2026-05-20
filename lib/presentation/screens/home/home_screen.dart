import 'package:flutter/material.dart';
import '../profile/profile_screen.dart';
import '../profile/statistics_screen.dart'; 

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Kita pakai background putih bawaan dulu supaya kelihatan kalau ada error layout
      backgroundColor: Colors.white, 
      body: SafeArea(
        child: SizedBox.expand(
          child: Stack(
            children: [
              
              // 1. KONTEN TENGAH YANG BISA DI-SCROLL
              Positioned.fill(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Container(
                    // Paksa tinggi container minimal 1850 sesuai desain Figma kamu agar bisa di-scroll
                    width: double.infinity,
                    height: 1850, 
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment(0.5, 0.0),
                        end: Alignment(0.5, 1.0),
                        colors: [Colors.white, Color(0xFFFFEEEB)],
                      ),
                    ),
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        // =========================================================
                        // UNIT 1 SECTION
                        // =========================================================
                        _buildUnitHeader(
                          top: 117,
                          title: 'Unit 1',
                          subtitle: 'Get started with Python basics',
                        ),
                        
                        // Level Node - Unit 1 (Posisi presisi dari Figma kamu)
                        _buildLevelNode(left: 165, top: 279, label: 'START', isRedText: true),
                        _buildLevelNode(left: 249, top: 376),
                        _buildLevelNode(left: 140, top: 455),
                        _buildLevelNode(left: 72, top: 593),
                        _buildLevelNode(left: 205, top: 715),

                        // =========================================================
                        // UNIT 2 SECTION
                        // =========================================================
                        _buildUnitHeader(
                          top: 840, 
                          title: 'Unit 2',
                          subtitle: 'Learn control flow',
                        ),
                        
                        // Level Node - Unit 2
                        _buildLevelNode(left: 249, top: 964),
                        _buildLevelNode(left: 113, top: 1071),
                        _buildLevelNode(left: 216, top: 1198),
                        _buildLevelNode(left: 89, top: 1330),
                        _buildLevelNode(left: 229, top: 1499),

                        // Teks Kunci / Status di Paling Bawah
                        Positioned(
                          left: 0,
                          right: 0,
                          top: 1621,
                          child: Column(
                            children: [
                              const Text(
                                'Finish the previous lesson first',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Color(0xFFB7B7B7),
                                  fontSize: 12,
                                  fontFamily: 'Ubuntu Condensed',
                                ),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: List.generate(3, (index) => Container(
                                  margin: const EdgeInsets.symmetric(horizontal: 3),
                                  width: 10.57,
                                  height: 10,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFB7B7B7),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                )),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // 2. TOP STATUS BAR (Tetap di atas, tidak ikut ter-scroll)
              Positioned(
                top: 0,
                left: 0,
                right: 25,
                child: Container(
                  height: 90,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  color: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 45,
                        height: 45,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: NetworkImage("https://placehold.co/52x52"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          _buildTopStatItem(Icons.local_fire_department, '40', const Color(0xFFFF9600)),
                          const SizedBox(width: 16),
                          _buildTopStatItem(Icons.stars, '103', const Color(0xFF1CB0F6)),
                          const SizedBox(width: 16),
                          _buildTopStatItem(Icons.favorite, '5', const Color(0xFFFF4B4B)),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              // 3. BOTTOM NAVIGATION BAR (Tetap di bawah, tidak ikut ter-scroll)
              Positioned(
                left: 0,
                right: 0,
                bottom: 0, //  MENGGUNAKAN BOTTOM: Mengunci menu agar selalu menempel di bagian bawah layar
                child: Container(
                  height: 75, // Menyesuaikan tinggi bar menu
                  decoration: const BoxDecoration(
                    color: Color(0xFF8A1212), // Warna merah gelap sesuai desainmu
                    borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Membagi jarak antar icon secara otomatis
                    children: [
                      IconButton(
                        icon: const Icon(Icons.home, color: Colors.white, size: 28),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: const Icon(Icons.military_tech_outlined, color: Colors.white70, size: 28),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: const Icon(Icons.bar_chart_rounded, color: Colors.white70, size: 28),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: const Icon(Icons.bookmark_border_rounded, color: Colors.white70, size: 28),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: const Icon(Icons.person, color: Colors.white70, size: 28),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ProfileScreen(), // <--- Memanggil class dari profile.dart
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }

  // Helper Widget: Banner Unit
  Widget _buildUnitHeader({required double top, required String title, required String subtitle}) {
    return Positioned(
      left: 16,
      right: 16,
      top: top,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: ShapeDecoration(
          gradient: const LinearGradient(
            begin: Alignment(0.00, 0.50),
            end: Alignment(1.00, 0.50),
            colors: [Color(0xFF960606), Color(0xFFD60000)],
          ),
          shape: RoundedRectangleBorder(
            side: const BorderSide(width: 4, color: Colors.white),
            borderRadius: BorderRadius.circular(16),
          ),
          shadows: const [
            BoxShadow(
              color: Color(0x19000000),
              blurRadius: 15,
              offset: Offset(0, 10),
            )
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(title, style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w900)),
                  const SizedBox(height: 4),
                  Text(subtitle, style: const TextStyle(color: Colors.white70, fontSize: 14, fontWeight: FontWeight.w600)),
                ],
              ),
            ),
            const Icon(Icons.menu_book, color: Colors.white, size: 24),
          ],
        ),
      ),
    );
  }

  // Helper Widget: Lingkaran Node Level
  Widget _buildLevelNode({required double left, required double top, String? label, bool isRedText = false}) {
    return Positioned(
      left: left,
      top: top,
      child: SizedBox(
        width: 71,
        height: 65,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFFFFEEEC), // Background lingkaran biar kelihatan pas kosong
                image: DecorationImage(
                  image: NetworkImage("https://placehold.co/71x65"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            if (label != null)
              Text(
                label,
                style: TextStyle(
                  color: isRedText ? const Color(0xFFED0C0C) : Colors.black,
                  fontSize: 13,
                  fontWeight: FontWeight.w800,
                ),
              ),
          ],
        ),
      ),
    );
  }

  // Helper Widget: Item Statistik Atas
  Widget _buildTopStatItem(IconData icon, String value, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: color, size: 24),
        const SizedBox(width: 4),
        Text(
          value,
          style: TextStyle(color: color, fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}