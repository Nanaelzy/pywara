import 'package:flutter/material.dart';

class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // 1. APPBAR UTAMA
      appBar: AppBar(
        title: const Text(
          'Statistic',
          style: TextStyle(
            color: Color(0xFFA30D0D),
            fontWeight: FontWeight.w700,
            fontSize: 16,
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
          padding: const EdgeInsets.symmetric(horizontal: 21.0, vertical: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ================= 2. KARTU CURRENT STREAK (GRADASI) =================
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFF960606), Color(0xFFD54E00)],
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 15,
                      offset: const Offset(0, 10),
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
                              const Icon(Icons.local_fire_department, color: Colors.white70, size: 24),
                              const SizedBox(width: 8),
                              Text(
                                'Current Streak',
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.9),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          const Text(
                            '40 days',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 36,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Your longest streak: 12 days',
                            style: TextStyle(
                              color: Color(0xFFDBEAFE),
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      '🔥',
                      style: TextStyle(
                        fontSize: 60,
                        color: Colors.white.withOpacity(0.2),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 28),

              // ================= 3. SECTION: TODAY'S PROGRESS =================
              const Text(
                "Today's Progress",
                style: TextStyle(
                  color: Color(0xFF960606),
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Inter',
                ),
              ),
              const SizedBox(height: 12),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: const Color(0xFFFFEEEC)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 3,
                      offset: const Offset(0, 1),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Daily Goal',
                          style: TextStyle(
                            color: Color(0xFF960606),
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          '8/10 min',
                          style: TextStyle(
                            color: const Color(0xFFD60000),
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    // PROGRESS BAR ASLI FLUTTER (Lebih Presisi daripada Container kaku)
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: const LinearProgressIndicator(
                        value: 0.8, // 8 dari 10 menit berarti 80% (0.8)
                        minHeight: 12,
                        backgroundColor: Color(0xFFFFEEEC),
                        valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF960606)),
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      '2 more minutes to reach your goal!',
                      style: TextStyle(
                        color: Color(0xFFD60000),
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 28),

              // ================= 4. SECTION: RECENT ACHIEVEMENTS =================
              const Text(
                'Recent Achievements',
                style: TextStyle(
                  color: Color(0xFF960606),
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Inter',
                ),
              ),
              const SizedBox(height: 12),
              
              // List Achievement Berjejer Vertikal
              _buildAchievementItem(
                emoji: '🎯',
                title: 'First Week',
                description: 'Completed 7 days in a row',
                isUnlocked: true,
              ),
              const SizedBox(height: 12),
              _buildAchievementItem(
                emoji: '⭐',
                title: 'Quick Learner',
                description: 'Completed 10 lessons',
                isUnlocked: true,
              ),
              const SizedBox(height: 12),
              _buildAchievementItem(
                emoji: '🏆',
                title: 'Python Master',
                description: 'Master all basic concepts', // Ditambahkan deskripsi agar seimbang
                isUnlocked: false, // Menandakan prestasi belum terbuka (redup sesuai kode Figma kamu)
              ),

              const SizedBox(height: 28),

              // ================= 5. SECTION: LEARNING INSIGHTS =================
              const Text(
                'Learning Insights',
                style: TextStyle(
                  color: Color(0xFF1C398E),
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Inter',
                ),
              ),
              const SizedBox(height: 12),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFFEFF6FF), Colors.white],
                  ),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: const Color(0xFFFfee4e1)),
                ),
                child: Column(
                  children: [
                    _buildInsightRow(
                      icon: Icons.access_time,
                      title: 'Best learning time',
                      subtitle: 'You practice most between 7-9 PM',
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 14.0),
                      child: Divider(color: Color(0xFFFFEEEC), thickness: 1),
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
      opacity: isUnlocked ? 1.0 : 0.4, // Jika belum unlocked, otomatis meredup (seperti Python Master di Figma kamu)
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFFFEEEC)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.02),
              blurRadius: 3,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Row(
          children: [
            Text(emoji, style: const TextStyle(fontSize: 40)),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Color(0xFF960606),
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: const TextStyle(
                      color: Color(0xFFD60000),
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            if (isUnlocked)
              const Icon(Icons.check_circle, color: Color(0xFFDBEAFE), size: 28),
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
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: const Color(0xFFFEE4E1),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Icon(icon, color: const Color(0xFF960606), size: 22),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Color(0xFF960606),
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: const TextStyle(
                  color: Color(0xFFD60000),
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}