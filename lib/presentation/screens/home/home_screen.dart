import 'dart:async';
import 'package:flutter/material.dart';
import '../profile/profile_screen.dart';
import '../profile/statistics_screen.dart'; 
import '../task/pages/multiple_choice_screen.dart';
import 'package:flutter/gestures.dart';

class HoverFloatingWidget extends StatefulWidget {
  final Widget child;
  final Future<void> Function()? onTap;

  const HoverFloatingWidget({super.key, required this.child, this.onTap});

  @override
  State<HoverFloatingWidget> createState() => _HoverFloatingWidgetState();
}

class _HoverFloatingWidgetState extends State<HoverFloatingWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _isHovered = false;
  bool _isClicked = false;

  bool get _shouldFloat => _isHovered || _isClicked;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    _animation = Tween<double>(begin: -6.0, end: 6.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _updateAnimation() {
    if (_shouldFloat) {
      if (!_controller.isAnimating) {
        _controller.repeat(reverse: true);
      }
    } else {
      _controller.stop();
      _controller.reset();
    }
  }

  Future<void> _handleTap() async {
    setState(() {
      _isClicked = true;
    });
    _updateAnimation();

    final Future<void>? callbackResult = widget.onTap?.call();
    if (callbackResult != null) {
      await callbackResult;
    }

    if (!mounted) return;
    setState(() {
      _isClicked = false;
    });
    _updateAnimation();
  }

  void _handleEnter(PointerEnterEvent event) {
    setState(() {
      _isHovered = true;
    });
    _updateAnimation();
  }

  void _handleExit(PointerExitEvent event) {
    setState(() {
      _isHovered = false;
    });
    _updateAnimation();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: _handleEnter,
      onExit: _handleExit,
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: _handleTap,
        child: AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            final offsetY = _shouldFloat ? _animation.value : 0.0;
            return Transform.translate(
              offset: Offset(0, offsetY),
              child: child,
            );
          },
          child: widget.child,
        ),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Kita pakai background putih bawaan dulu supaya kelihatan kalau ada error layout
      backgroundColor: Colors.white, 
      body: SizedBox.expand(
        child: SizedBox.expand(
          child: Stack(
            children: [
              
              Positioned(
                left: -35, // Geser sedikit ke kiri agar terpotong tepi layar
                top: -20,  // Geser sedikit ke atas agar menembus status bar
                child: Container(
                  width: 141,
                  height: 141,
                  decoration: const ShapeDecoration(
                    color: Color(0xFF960606),
                    shape: OvalBorder(),
                  ),
                ),
              ),
              
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
                        _buildLevelNode(context: context, left: 165, top: 279, label: 'START', isRedText: true),
                        _buildLevelNode(context: context, left: 249, top: 376),
                        _buildLevelNode(context: context, left: 140, top: 455),
                        _buildLevelNode(context: context, left: 72, top: 593),
                        _buildLevelNode(context: context, left: 205, top: 715),

                        // =========================================================
                        // UNIT 2 SECTION
                        // =========================================================
                        _buildUnitHeader(
                          top: 840, 
                          title: 'Unit 2',
                          subtitle: 'Learn control flow',
                        ),
                        
                        // Level Node - Unit 2
                        _buildLevelNode(context: context, left: 249, top: 999),
                        _buildLevelNode(context: context, left: 100, top: 1071),
                        _buildLevelNode(context: context, left: 216, top: 1198),
                        _buildLevelNode(context: context, left: 120, top: 1330),
                        _buildLevelNode(context: context, left: 229, top: 1470),
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
                right: 5,
                child: Container(
                  height: 80,
                  color: Colors.white, // Background bar putih
                  child: Stack(
                    clipBehavior: Clip.none, // Agar lingkaran bisa keluar dari batas 80px
                    children: [
                      // =========================================================
                      // LINGKARAN MERAH (Sekarang ada di layer Top Bar)
                      // =========================================================
                      Positioned(
                        left: -35,
                        top: -35,
                        child: Container(
                          width: 141,
                          height: 141,
                          decoration: const ShapeDecoration(
                            color: Color(0xFF960606),
                            shape: OvalBorder(),
                          ),
                        ),
                      ),
                      
                      // =========================================================
                      // KONTEN PROFILE & ANGKA STATISTIK
                      // =========================================================
                      Padding(
                        // Padding dipindah ke sini agar lingkaran merah tidak ikut ter-padding
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 59,
                              height: 100,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: AssetImage("assets/images/pylogo.png"), 
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                _buildTopStatItem(Icons.local_fire_department, '40', const Color(0xFFFF9600)),
                                const SizedBox(width: 16),
                                _buildTopStatItem(Icons.diamond, '103', const Color(0xFF1CB0F6)),
                                const SizedBox(width: 16),
                                _buildTopStatItem(Icons.favorite, '5', const Color(0xFFFF4B4B)),
                              ],
                            ),
                          ],
                        ),
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
                        onPressed: () {
                          // TAMBAHKAN NAVIGASI DI SINI:
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const StatisticsScreen(),
                            ),
                          );
                        },
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
                              builder: (context) => const ProfileScreen(), 
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
  Widget _buildLevelNode({
    required BuildContext context,
    required double left, 
    required double top, 
    String? label, 
    bool isRedText = false,
    bool isDone = false,
  }) {
    // Konten utamanya (Balon teks + Gambar Node)
    Widget nodeContent = Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        // 1. Gambar Ikon Level
        Image.asset(
          isDone ? "assets/images/Taskdone.png" : "assets/images/Task.png",
          width: 71,
          height: 71,
          fit: BoxFit.contain,
        ),
        
        // 2. Balon Teks "START" (Hanya muncul jika label tidak null)
        if (label != null)
          Positioned(
            top: -42, // Geser balon ke atas ikon
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade300, width: 2),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  )
                ]
              ),
              child: Text(
                label,
                style: TextStyle(
                  color: isRedText ? const Color(0xFFED0C0C) : Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ),
      ],
    );

    return Positioned(
      left: left,
      top: top,
      child: SizedBox(
        width: 71,
        child: HoverFloatingWidget(
          onTap: () async {
          // Menampilkan Pop-Up dari bawah
          await showModalBottomSheet(
            context: context,
            backgroundColor: Colors.transparent, // Dibuat transparan agar radius lengkungmu terlihat
            builder: (BuildContext context) {
              return SizedBox(
                width: 412,
                height: 227,
                child: Stack(
                  children: [
                    // Background Merah Gelap (belakang)
                    Positioned(
                      left: 0,
                      top: 0,
                      right: 0, // Ditambahkan right: 0 agar menyesuaikan lebar layar
                      child: Container(
                        height: 219,
                        decoration: const ShapeDecoration(
                          color: Color(0xFF8A1212),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(40),
                              topRight: Radius.circular(40),
                            ),
                          ),
                        ),
                      ),
                    ),
                    // Background Merah Terang (depan)
                    Positioned(
                      left: 0,
                      top: 8,
                      right: 0, 
                      child: Container(
                        height: 219,
                        decoration: const ShapeDecoration(
                          color: Color(0xFFD85959),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(40),
                              topRight: Radius.circular(40),
                            ),
                          ),
                        ),
                      ),
                    ),
                    // Judul Unit / Task
                    const Positioned(
                      left: 0,
                      right: 0,
                      top: 46,
                      child: Text(
                        'python syntax',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFFFDFFFC),
                          fontSize: 32,
                          fontFamily: 'Ubuntu',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    // Tombol Start (Background Putih + Teks digabung)
                    Positioned(
                      left: 37,
                      right: 37, // Menggunakan left & right agar posisinya seimbang di tengah
                      top: 122,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context); // 1. Tutup pop-up dari bawah
                          Navigator.push(          // 2. Pindah ke halaman Multiple Choice
                            context,
                            MaterialPageRoute(
                              builder: (context) => const TaskScreen(), 
                            ),
                          );
                        },
                        child: Container(
                          height: 74,
                          decoration: ShapeDecoration(
                            color: const Color(0xFFFFFCFB),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40),
                            ),
                          ),
                          alignment: Alignment.center, // Memastikan teks ada tepat di tengah tombol
                          child: const Text(
                            'Start  +20 xp',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFF956B0B),
                              fontSize: 20,
                              fontFamily: 'B612 Mono',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
          child: nodeContent,
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