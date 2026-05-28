import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // Tambahkan import ini

class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // 1. APPBAR UTAMA
      appBar: AppBar(
        title: Text(
          // Hapus const
          'Statistic',
          style: TextStyle(
            // Hapus const
            color: const Color(0xFFA30D0D),
            fontWeight: FontWeight.w700,
            fontSize: 16.sp, // Tambah .sp
            fontFamily: 'Inter',
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 2,
        shadowColor: Colors.black.withOpacity(0.3),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFFA30D0D)),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.white, Color(0xFFFFEEEB)],
          ),
        ),
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: 21.w,
            vertical: 24.h,
          ), // Hapus const, tambah .w & .h
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ================= 2. KARTU CURRENT STREAK (GRADASI) =================
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(24.w), // Hapus const, tambah .w
                decoration: BoxDecoration(
                  // Hapus const
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFF960606), Color(0xFFD54E00)],
                  ),
                  borderRadius: BorderRadius.circular(20.r), // Tambah .r
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 15,
                      offset: Offset(0, 10.h), // Hapus const, tambah .h
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.local_fire_department,
                                color: Colors.white70,
                                size: 24.sp,
                              ), // Hapus const, tambah .sp
                              SizedBox(width: 8.w), // Hapus const, tambah .w
                              Text(
                                // Hapus const
                                'Current Streak',
                                style: TextStyle(
                                  // Hapus const
                                  color: Colors.white.withOpacity(0.9),
                                  fontSize: 16.sp, // Tambah .sp
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 12.h), // Hapus const, tambah .h
                          Text(
                            // Hapus const
                            '40 days',
                            style: TextStyle(
                              // Hapus const
                              color: Colors.white,
                              fontSize: 36.sp, // Tambah .sp
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(height: 8.h), // Hapus const, tambah .h
                          Text(
                            // Hapus const
                            'Your longest streak: 12 days',
                            style: TextStyle(
                              // Hapus const
                              color: const Color(0xFFDBEAFE),
                              fontSize: 14.sp, // Tambah .sp
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      // Hapus const
                      '🔥',
                      style: TextStyle(
                        // Hapus const
                        fontSize: 60.sp, // Tambah .sp
                        color: Colors.white.withOpacity(0.2),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 28.h), // Hapus const, tambah .h
              // ================= 3. SECTION: TODAY'S PROGRESS =================
              Text(
                // Hapus const
                "Today's Progress",
                style: TextStyle(
                  // Hapus const
                  color: const Color(0xFF960606),
                  fontSize: 20.sp, // Tambah .sp
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Inter',
                ),
              ),
              SizedBox(height: 12.h), // Hapus const, tambah .h
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(20.w), // Hapus const, tambah .w
                decoration: BoxDecoration(
                  // Hapus const
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.r), // Tambah .r
                  border: Border.all(color: const Color(0xFFFFEEEC)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 3,
                      offset: Offset(0, 1.h), // Hapus const, tambah .h
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          // Hapus const
                          'Daily Goal',
                          style: TextStyle(
                            // Hapus const
                            color: const Color(0xFF960606),
                            fontSize: 16.sp, // Tambah .sp
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          // Hapus const
                          '8/10 min',
                          style: TextStyle(
                            // Hapus const
                            color: const Color(0xFFD60000),
                            fontSize: 14.sp, // Tambah .sp
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.h), // Hapus const, tambah .h
                    // PROGRESS BAR ASLI FLUTTER
                    ClipRRect(
                      // Hapus const
                      borderRadius: BorderRadius.circular(12.r), // Tambah .r
                      child: LinearProgressIndicator(
                        // Hapus const
                        value: 0.8,
                        minHeight: 12.h, // Tambah .h
                        backgroundColor: const Color(0xFFFFEEEC),
                        valueColor: const AlwaysStoppedAnimation<Color>(
                          Color(0xFF960606),
                        ), // Pindah const
                      ),
                    ),
                    SizedBox(height: 16.h), // Hapus const, tambah .h
                    Text(
                      // Hapus const
                      '2 more minutes to reach your goal!',
                      style: TextStyle(
                        // Hapus const
                        color: const Color(0xFFD60000),
                        fontSize: 14.sp, // Tambah .sp
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 28.h), // Hapus const, tambah .h
              // ================= 4. SECTION: RECENT ACHIEVEMENTS =================
              Text(
                // Hapus const
                'Recent Achievements',
                style: TextStyle(
                  // Hapus const
                  color: const Color(0xFF960606),
                  fontSize: 20.sp, // Tambah .sp
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Inter',
                ),
              ),
              SizedBox(height: 12.h), // Hapus const, tambah .h
              // List Achievement Berjejer Vertikal
              _buildAchievementItem(
                emoji: '🎯',
                title: 'First Week',
                description: 'Completed 7 days in a row',
                isUnlocked: true,
              ),
              SizedBox(height: 12.h), // Hapus const, tambah .h
              _buildAchievementItem(
                emoji: '⭐',
                title: 'Quick Learner',
                description: 'Completed 10 lessons',
                isUnlocked: true,
              ),
              SizedBox(height: 12.h), // Hapus const, tambah .h
              _buildAchievementItem(
                emoji: '🏆',
                title: 'Python Master',
                description: 'Master all basic concepts',
                isUnlocked: false,
              ),

              SizedBox(height: 28.h), // Hapus const, tambah .h
              // ================= 5. SECTION: LEARNING INSIGHTS =================
              Text(
                // Hapus const
                'Learning Insights',
                style: TextStyle(
                  // Hapus const
                  color: const Color(0xFF1C398E),
                  fontSize: 20.sp, // Tambah .sp
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Inter',
                ),
              ),
              SizedBox(height: 12.h), // Hapus const, tambah .h
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(20.w), // Hapus const, tambah .w
                decoration: BoxDecoration(
                  // Hapus const
                  gradient: const LinearGradient(
                    // Pindah const
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFFEFF6FF), Colors.white],
                  ),
                  borderRadius: BorderRadius.circular(20.r), // Tambah .r
                  border: Border.all(
                    color: const Color(0xFFFfee4e1),
                  ), // Pindah const
                ),
                child: Column(
                  children: [
                    _buildInsightRow(
                      icon: Icons.access_time,
                      title: 'Best learning time',
                      subtitle: 'You practice most between 7-9 PM',
                    ),
                    Padding(
                      // Hapus const
                      padding: EdgeInsets.symmetric(
                        vertical: 14.h,
                      ), // Tambah .h
                      child: const Divider(
                        color: Color(0xFFFFEEEC),
                        thickness: 1,
                      ), // Pindah const
                    ),
                    _buildInsightRow(
                      icon: Icons.star_border,
                      title: 'Strongest area',
                      subtitle: 'Variables & Data Types (95% accuracy)',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper Item Pencapaian (Achievements)
  Widget _buildAchievementItem({
    required String emoji,
    required String title,
    required String description,
    required bool isUnlocked,
  }) {
    return Opacity(
      opacity: isUnlocked ? 1.0 : 0.4,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(16.w), // Hapus const, tambah .w
        decoration: BoxDecoration(
          // Hapus const
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r), // Tambah .r
          border: Border.all(color: const Color(0xFFFFEEEC)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.02),
              blurRadius: 3,
              offset: Offset(0, 1.h), // Hapus const, tambah .h
            ),
          ],
        ),
        child: Row(
          children: [
            Text(
              emoji,
              style: TextStyle(fontSize: 40.sp),
            ), // Hapus const, tambah .sp
            SizedBox(width: 16.w), // Hapus const, tambah .w
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    // Hapus const
                    title,
                    style: TextStyle(
                      // Hapus const
                      color: const Color(0xFF960606),
                      fontSize: 16.sp, // Tambah .sp
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 4.h), // Hapus const, tambah .h
                  Text(
                    // Hapus const
                    description,
                    style: TextStyle(
                      // Hapus const
                      color: const Color(0xFFD60000),
                      fontSize: 14.sp, // Tambah .sp
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            if (isUnlocked)
              Icon(
                Icons.check_circle,
                color: const Color(0xFFDBEAFE),
                size: 28.sp,
              ), // Hapus const, tambah .sp
          ],
        ),
      ),
    );
  }

  // Helper Row Baris Insights
  Widget _buildInsightRow({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Row(
      children: [
        Container(
          width: 44.w, // Tambah .w
          height: 44
              .w, // Gunakan .w agar kotak ikon tetap proporsional (persegi sempurna)
          decoration: BoxDecoration(
            // Hapus const
            color: const Color(0xFFFEE4E1),
            borderRadius: BorderRadius.circular(14.r), // Tambah .r
          ),
          child: Icon(
            icon,
            color: const Color(0xFF960606),
            size: 22.sp,
          ), // Hapus const, tambah .sp
        ),
        SizedBox(width: 16.w), // Hapus const, tambah .w
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                // Hapus const
                title,
                style: TextStyle(
                  // Hapus const
                  color: const Color(0xFF960606),
                  fontSize: 16.sp, // Tambah .sp
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 2.h), // Hapus const, tambah .h
              Text(
                // Hapus const
                subtitle,
                style: TextStyle(
                  // Hapus const
                  color: const Color(0xFFD60000),
                  fontSize: 14.sp, // Tambah .sp
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
