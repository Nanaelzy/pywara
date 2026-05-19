import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../splash/splash_screen.dart';
import '../profile/settings_screen.dart'; 
import '../profile/statistics_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  // 1. Fungsi Log out Firebase
  Future<void> _logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    if (context.mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const SplashScreen()),
      );
    }
  }

  // 2. Fungsi Dialog Konfirmasi Hapus Akun (Posisi Aman di Atas)
  void _showDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          backgroundColor: Colors.white,
          child: Container(
            padding: const EdgeInsets.all(24),
            width: 365,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: const Color(0x22960606),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: const Icon(Icons.delete_forever, color: Color(0xFF960606), size: 28),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Delete Account Data?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF960606),
                    fontSize: 16,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'This will permanently delete all your progress, achievements, and account data. This action cannot be undone.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF960606),
                    fontSize: 14,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(dialogContext); // Tutup dialog
                    _deleteFirebaseAccount(context); // Jalankan fungsi hapus dengan konteks screen utama
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF960606),
                    minimumSize: const Size(double.infinity, 48),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    elevation: 0,
                  ),
                  child: const Text(
                    'Yes, Delete Everything',
                    style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w700),
                  ),
                ),
                const SizedBox(height: 12),
                TextButton(
                  onPressed: () => Navigator.pop(dialogContext),
                  style: TextButton.styleFrom(
                    minimumSize: const Size(double.infinity, 40),
                  ),
                  child: const Text(
                    'Cancel',
                    style: TextStyle(
                      color: Color(0xFF5D5D5D),
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // 3. Fungsi Proses Penghapusan Akun di Firebase (Fixed Navigation)
  Future<void> _deleteFirebaseAccount(BuildContext context) async {
  // Ditambahkan dua baris ini untuk mengunci context navigasi
  final navigator = Navigator.of(context);
  final scaffoldMessenger = ScaffoldMessenger.of(context);
  
  try {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await user.delete();

        // 2. Tampilkan notifikasi sukses
        scaffoldMessenger.showSnackBar(
          const SnackBar(
            content: Text('Akun Anda berhasil dihapus secara permanen.'),
            backgroundColor: Colors.green,
          ),
        );

        // 3. TENDANG KELUAR LANGSUNG KE SPLASH SCREEN
        navigator.pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const SplashScreen()), // <-- Mengarah ke SplashScreen
          (route) => false,
        );
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'requires-recent-login') {
        scaffoldMessenger.showSnackBar(
          const SnackBar(
            content: Text('Untuk keamanan, silakan Logout lalu Login kembali sebelum menghapus akun.'),
            backgroundColor: Colors.orange,
          ),
        );
      } else {
        scaffoldMessenger.showSnackBar(
          SnackBar(
            content: Text('Gagal menghapus akun: ${e.message}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final userName = user?.displayName ?? 'Helena';
    final userEmail = user?.email ?? 'your.email@gmail.com';

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Profile',
          style: TextStyle(color: Color(0xFF960606), fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 2,
        shadowColor: Colors.black.withOpacity(0.3),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF960606)),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.white, Color(0xFFFFEEEB)],
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // HEADER PROFILE
              Center(
                child: Column(
                  children: [
                    Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        CircleAvatar(
                          radius: 53,
                          backgroundColor: const Color(0xFF960606),
                          child: Text(
                            userName.isNotEmpty ? userName[0].toUpperCase() : 'H',
                            style: const TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold),
                          ),
                        ),
                        CircleAvatar(
                          radius: 16,
                          backgroundColor: Colors.white,
                          child: IconButton(
                            padding: EdgeInsets.zero,
                            icon: const Icon(Icons.edit, size: 16, color: Color(0xFF960606)),
                            onPressed: () {},
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      userName,
                      style: const TextStyle(color: Color(0xFF960606), fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      userEmail,
                      style: const TextStyle(color: Color(0xFF960606), fontSize: 14, fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              // LEARNING PROGRESS
              const Text(
                'Learning Progress',
                style: TextStyle(color: Color(0xFF960606), fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 1.3,
                children: [
                  _buildProgressCard(
                    icon: Icons.local_fire_department,
                    iconColor: const Color(0xFFD54E00),
                    bgColor: const Color(0x22D54E00),
                    title: 'Current Streak',
                    value: '40 days',
                  ),
                  _buildProgressCard(
                    icon: Icons.bolt,
                    iconColor: const Color(0xFF960679),
                    bgColor: const Color(0x22960679),
                    title: 'Total XP',
                    value: '1100 XP',
                  ),
                  _buildProgressCard(
                    icon: Icons.emoji_events,
                    iconColor: const Color(0xFF5D8BCD),
                    bgColor: const Color(0x225D8BCD),
                    title: 'Challenges',
                    value: '1 / ?',
                  ),
                  _buildProgressCard(
                    icon: Icons.extension,
                    iconColor: const Color(0xFF960606),
                    bgColor: const Color(0x22960606),
                    title: 'Units Done',
                    value: '3 / ?',
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // SECTION PROGRESS BAR
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: const Color(0xFFE7E6E6), width: 1.5),
                  boxShadow: [
                    BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 4, offset: const Offset(0, 2)),
                  ],
                ),
                child: Column(
                  children: [
                    _buildSectionProgress('Section 1', 1.0, '100%', Colors.green),
                    const SizedBox(height: 16),
                    _buildSectionProgress('Section 2', 0.6, '60%', const Color(0xFF960606)),
                    const SizedBox(height: 16),
                    _buildSectionProgress('Section 3', 0.0, '0%', Colors.grey.withOpacity(0.5)),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              // ACCOUNT SETTING LIST MENU
              const Text(
                'Account Setting',
                style: TextStyle(color: Color(0xFF960606), fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              
              _buildAccountTile(
                icon: Icons.settings,
                iconColor: const Color(0xFF960679),
                bgColor: const Color(0x22960679),
                title: 'Settings',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SettingsScreen()),
                  );
                },
              ),
              const SizedBox(height: 12),
              _buildAccountTile(
                icon: Icons.bar_chart,
                iconColor: const Color(0xFF5D8BCD),
                bgColor: const Color(0x225D8BCD),
                title: 'Statistics',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const StatisticsScreen()),
                  );
                },
              ),
              const SizedBox(height: 12),
              _buildAccountTile(
                icon: Icons.logout,
                iconColor: const Color(0xFFD54E00),
                bgColor: const Color(0x22D54E00),
                title: 'Logout',
                onTap: () => _logout(context),
              ),
              const SizedBox(height: 12),
              _buildAccountTile(
                icon: Icons.delete_forever,
                iconColor: const Color(0xFF960606),
                bgColor: const Color(0x22960606),
                title: 'Delete Account',
                onTap: () {
                  _showDeleteDialog(context); // Diaktifkan penuh & dijamin jalan!
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  // HELPER WIDGETS
  Widget _buildProgressCard({
    required IconData icon,
    required Color iconColor,
    required Color bgColor,
    required String title,
    required String value,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: const Color(0xFFE7E6E6), width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(color: bgColor, borderRadius: BorderRadius.circular(10)),
            child: Icon(icon, color: iconColor, size: 36),
          ),
          const SizedBox(height: 12),
          Text(title, style: const TextStyle(color: Color(0xFF960606), fontSize: 13, fontWeight: FontWeight.w500)),
          const SizedBox(height: 2),
          Text(value, style: const TextStyle(color: Color(0xFF960606), fontSize: 16, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildSectionProgress(String sectionName, double progressValue, String percentage, Color progressColor) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(sectionName, style: const TextStyle(color: Color(0xFF960606), fontWeight: FontWeight.w500)),
            Text(percentage, style: const TextStyle(color: Color(0xFF960606), fontWeight: FontWeight.w500)),
          ],
        ),
        const SizedBox(height: 6),
        ClipRRect(
          borderRadius: BorderRadius.circular(13),
          child: LinearProgressIndicator(
            value: progressValue,
            minHeight: 10,
            backgroundColor: const Color(0x1C909090),
            valueColor: AlwaysStoppedAnimation<Color>(progressColor),
          ),
        ),
      ],
    );
  }

  Widget _buildAccountTile({
    required IconData icon,
    required Color iconColor,
    required Color bgColor,
    required String title,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap, // Aksi klik diaktifkan langsung lewat InkWell bawaan Flutter
      borderRadius: BorderRadius.circular(15),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: const Color(0xFFE7E6E6), width: 1.5),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 4, offset: const Offset(0, 2)),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(color: bgColor, borderRadius: BorderRadius.circular(26)),
              child: Icon(icon, color: iconColor, size: 24),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: TextStyle(color: iconColor, fontSize: 14, fontWeight: FontWeight.bold),
              ),
            ),
            Icon(Icons.chevron_right, color: iconColor.withOpacity(0.5)),
          ],
        ),
      ),
    );
  }
}