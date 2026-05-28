import 'dart:async';
import 'package:flutter/material.dart';
import '../profile/profile_screen.dart';
import '../profile/statistics_screen.dart';
import '../task/pages/multiple_choice_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HoverFloatingWidget extends StatefulWidget {
  final Widget child;
  final Future<void> Function()? onTap;

  const HoverFloatingWidget({super.key, required this.child, this.onTap});

  @override
  State<HoverFloatingWidget> createState() => _HoverFloatingWidgetState();
}

class _HoverFloatingWidgetState extends State<HoverFloatingWidget>
    with SingleTickerProviderStateMixin {
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

    _animation = Tween<double>(
      begin: -6.h, // Ditambahkan .h agar jarak naik-turun juga proporsional
      end: 6.h,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
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
      backgroundColor: Colors.white,
      body: SizedBox.expand(
        child: SizedBox.expand(
          child: Stack(
            children: [
              Positioned(
                left: -35.w,
                top: -20.h,
                child: Container(
                  width: 141.w,
                  height: 141
                      .w, // Dipertahankan .w agar bentuknya tetap bulat sempurna
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
                    width: double.infinity,
                    height: 1850.h,
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
                          top: 117.h,
                          title: 'Unit 1',
                          subtitle: 'Get started with Python basics',
                        ),

                        // Level Node - Unit 1
                        _buildLevelNode(
                          context: context,
                          left: 165.w,
                          top: 279.h,
                          label: 'START',
                          isRedText: true,
                        ),
                        _buildLevelNode(
                          context: context,
                          left: 249.w,
                          top: 376.h,
                        ),
                        _buildLevelNode(
                          context: context,
                          left: 140.w,
                          top: 455.h,
                        ),
                        _buildLevelNode(
                          context: context,
                          left: 72.w,
                          top: 593.h,
                        ),
                        _buildLevelNode(
                          context: context,
                          left: 205.w,
                          top: 715.h,
                        ),

                        // =========================================================
                        // UNIT 2 SECTION
                        // =========================================================
                        _buildUnitHeader(
                          top: 840.h,
                          title: 'Unit 2',
                          subtitle: 'Learn control flow',
                        ),

                        // Level Node - Unit 2
                        _buildLevelNode(
                          context: context,
                          left: 249.w,
                          top: 999.h,
                        ),
                        _buildLevelNode(
                          context: context,
                          left: 100.w,
                          top: 1071.h,
                        ),
                        _buildLevelNode(
                          context: context,
                          left: 216.w,
                          top: 1198.h,
                        ),
                        _buildLevelNode(
                          context: context,
                          left: 120.w,
                          top: 1330.h,
                        ),
                        _buildLevelNode(
                          context: context,
                          left: 229.w,
                          top: 1470.h,
                        ),

                        // Teks Kunci / Status di Paling Bawah
                        Positioned(
                          left: 0,
                          right: 0,
                          top: 1621.h,
                          child: Column(
                            children: [
                              Text(
                                // Dihapus const-nya
                                'Finish the previous lesson first',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: const Color(0xFFB7B7B7),
                                  fontSize: 12.sp,
                                  fontFamily: 'Ubuntu Condensed',
                                ),
                              ),
                              SizedBox(height: 8.h),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: List.generate(
                                  3,
                                  (index) => Container(
                                    margin: EdgeInsets.symmetric(
                                      horizontal: 3.w,
                                    ),
                                    width: 10.57.w,
                                    height: 10.h,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFB7B7B7),
                                      borderRadius: BorderRadius.circular(20.r),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // 2. TOP STATUS BAR
              Positioned(
                top: 0,
                left: 0,
                right: 5.w,
                child: Container(
                  height: 80.h,
                  color: Colors.white,
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      // LINGKARAN MERAH DI POJOK KIRI ATAS
                      Positioned(
                        left: -35.w,
                        top: -35.h,
                        child: Container(
                          width: 141.w,
                          height: 141.h,
                          decoration: const ShapeDecoration(
                            color: Color(0xFF960606),
                            shape: OvalBorder(),
                          ),
                        ),
                      ),

                      // KONTEN PROFILE & ANGKA STATISTIK
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 10.h,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 59.w,
                              height: 100.h,
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
                                _buildTopStatItem(
                                  Icons.local_fire_department,
                                  '40',
                                  const Color(0xFFFF9600),
                                ),
                                SizedBox(width: 16.w),
                                _buildTopStatItem(
                                  Icons.diamond,
                                  '103',
                                  const Color(0xFF1CB0F6),
                                ),
                                SizedBox(width: 16.w),
                                _buildTopStatItem(
                                  Icons.favorite,
                                  '5',
                                  const Color(0xFFFF4B4B),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // 3. BOTTOM NAVIGATION BAR
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  height: 75.h,
                  decoration: BoxDecoration(
                    color: const Color(0xFF8A1212),
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(16.r),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.home,
                          color: Colors.white,
                          size: 28.sp,
                        ),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.military_tech_outlined,
                          color: Colors.white70,
                          size: 28.sp,
                        ),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.bar_chart_rounded,
                          color: Colors.white70,
                          size: 28.sp,
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const StatisticsScreen(),
                            ),
                          );
                        },
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.bookmark_border_rounded,
                          color: Colors.white70,
                          size: 28.sp,
                        ),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.person,
                          color: Colors.white70,
                          size: 28.sp,
                        ),
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
  Widget _buildUnitHeader({
    required double top,
    required String title,
    required String subtitle,
  }) {
    return Positioned(
      left: 16.w,
      right: 16.w,
      top: top, // Nilai top sudah diisi format .h pada saat dipanggil
      child: Container(
        padding: EdgeInsets.all(20.w),
        decoration: ShapeDecoration(
          gradient: const LinearGradient(
            begin: Alignment(0.00, 0.50),
            end: Alignment(1.00, 0.50),
            colors: [Color(0xFF960606), Color(0xFFD60000)],
          ),
          shape: RoundedRectangleBorder(
            side: BorderSide(width: 4.w, color: Colors.white),
            borderRadius: BorderRadius.circular(16.r),
          ),
          shadows: const [
            BoxShadow(
              color: Color(0x19000000),
              blurRadius: 15,
              offset: Offset(0, 10),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22.sp,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    subtitle,
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.menu_book, color: Colors.white, size: 24.sp),
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
    Widget nodeContent = Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        Image.asset(
          isDone ? "assets/images/Taskdone.png" : "assets/images/Task.png",
          width: 71.w,
          height: 71.h,
          fit: BoxFit.contain,
        ),
        if (label != null)
          Positioned(
            top: -42.h,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 6.h),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: Colors.grey.shade300, width: 2),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Text(
                label,
                style: TextStyle(
                  color: isRedText ? const Color(0xFFED0C0C) : Colors.black,
                  fontSize: 14.sp,
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
        width: 71.w,
        child: HoverFloatingWidget(
          onTap: () async {
            await showModalBottomSheet(
              context: context,
              backgroundColor: Colors.transparent,
              builder: (BuildContext context) {
                return SizedBox(
                  width: 1.sw, // Memastikan selebar ukuran perangkat
                  height: 227.h,
                  child: Stack(
                    children: [
                      // Background Merah Gelap (belakang)
                      Positioned(
                        left: 0,
                        top: 0,
                        right: 0,
                        child: Container(
                          height: 219.h,
                          decoration: ShapeDecoration(
                            color: const Color(0xFF8A1212),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(40.r),
                                topRight: Radius.circular(40.r),
                              ),
                            ),
                          ),
                        ),
                      ),
                      // Background Merah Terang (depan)
                      Positioned(
                        left: 0,
                        top: 8.h,
                        right: 0,
                        child: Container(
                          height: 219.h,
                          decoration: ShapeDecoration(
                            color: const Color(0xFFD85959),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(40.r),
                                topRight: Radius.circular(40.r),
                              ),
                            ),
                          ),
                        ),
                      ),
                      // Judul Unit / Task
                      Positioned(
                        left: 0,
                        right: 0,
                        top: 46.h,
                        child: Text(
                          'python syntax',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: const Color(0xFFFDFFFC),
                            fontSize: 32.sp,
                            fontFamily: 'Ubuntu',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      // Tombol Start
                      Positioned(
                        left: 37.w,
                        right: 37.w,
                        top: 122.h,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const TaskScreen(),
                              ),
                            );
                          },
                          child: Container(
                            height: 74.h,
                            decoration: ShapeDecoration(
                              color: const Color(0xFFFFFCFB),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(40.r),
                              ),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              'Start  +20 xp',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: const Color(0xFF956B0B),
                                fontSize: 20.sp,
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
        Icon(icon, color: color, size: 24.sp),
        SizedBox(width: 4.w),
        Text(
          value,
          style: TextStyle(
            color: color,
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
