import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../splash/splash_screen.dart';
import '../profile/settings_screen.dart';
import '../profile/statistics_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // Tambahkan import ini

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  // 1. Fungsi Log out Firebase
  // Fungsi untuk menampilkan Pop-up Konfirmasi Logout dari Figma kamu
  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext dialogContext) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.r),
          ), // Tambah .r
          backgroundColor: Colors.white,
          child: Container(
            width: 330.w, // Tambah .w
            padding: EdgeInsets.symmetric(
              horizontal: 24.w,
              vertical: 24.h,
            ), // Hapus const, tambah .w & .h
            child: Column(
              mainAxisSize: MainAxisSize
                  .min, // Membuat tinggi dialog mengikuti isi kontennya
              children: [
                // 1. Icon Keluar (Wrapper Lingkaran)
                Container(
                  width: 50.w, // Tambah .w
                  height: 50.w, // Pakai .w juga agar bulat sempurna
                  decoration: const BoxDecoration(
                    color: Color(0x33D54E00),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    // Hapus const
                    Icons.logout_rounded,
                    color: const Color(0xFFD54E00),
                    size: 24.sp, // Tambah .sp
                  ),
                ),
                SizedBox(height: 16.h), // Hapus const, tambah .h
                // 2. Judul Dialog
                Text(
                  // Hapus const
                  'Leaving So Soon?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    // Hapus const
                    color: const Color(0xFFD54E00),
                    fontSize: 16.sp, // Tambah .sp
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 12.h), // Hapus const, tambah .h
                // 3. Deskripsi / Isi Teks
                Text(
                  // Hapus const
                  'Your progress and achievements are safely saved. You can pick up exactly where you left off as soon as you sign back in.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    // Hapus const
                    color: const Color(0xFF960606),
                    fontSize: 13.sp, // Tambah .sp
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    height: 1.4,
                  ),
                ),
                SizedBox(height: 24.h), // Hapus const, tambah .h
                // 4. Tombol: Yes, Log Out
                InkWell(
                  onTap: () async {
                    Navigator.pop(dialogContext);
                    await FirebaseAuth.instance.signOut();
                    if (context.mounted) {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SplashScreen(),
                        ),
                        (route) => false,
                      );
                    }
                  },
                  borderRadius: BorderRadius.circular(12.r), // Tambah .r
                  child: Container(
                    width: double.infinity,
                    height: 45.h, // Tambah .h
                    decoration: BoxDecoration(
                      // Hapus const
                      color: const Color(0xFFD54E00),
                      borderRadius: BorderRadius.circular(12.r), // Tambah .r
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      // Hapus const
                      'Yes, Log Out',
                      style: TextStyle(
                        // Hapus const
                        color: Colors.white,
                        fontSize: 14.sp, // Tambah .sp
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 8.h), // Hapus const, tambah .h
                // 5. Tombol: Cancel
                InkWell(
                  onTap: () => Navigator.pop(dialogContext),
                  borderRadius: BorderRadius.circular(12.r), // Tambah .r
                  child: Container(
                    width: double.infinity,
                    height: 40.h, // Tambah .h
                    alignment: Alignment.center,
                    child: Text(
                      // Hapus const
                      'Cancel',
                      style: TextStyle(
                        // Hapus const
                        color: const Color(0xFF5D5D5D),
                        fontSize: 14.sp, // Tambah .sp
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w700,
                      ),
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

  // 2. Fungsi Dialog Konfirmasi Hapus Akun (Posisi Aman di Atas)
  void _showDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.r),
          ), // Tambah .r
          backgroundColor: Colors.white,
          child: Container(
            padding: EdgeInsets.all(24.w), // Hapus const, tambah .w
            width: 365.w, // Tambah .w
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 50.w, // Tambah .w
                  height: 50.w, // Pakai .w agar bulat sempurna
                  decoration: BoxDecoration(
                    // Hapus const
                    color: const Color(0x22960606),
                    borderRadius: BorderRadius.circular(25.r), // Tambah .r
                  ),
                  child: Icon(
                    Icons.delete_forever,
                    color: const Color(0xFF960606),
                    size: 28.sp,
                  ), // Hapus const, tambah .sp
                ),
                SizedBox(height: 16.h), // Hapus const, tambah .h
                Text(
                  // Hapus const
                  'Delete Account Data?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    // Hapus const
                    color: const Color(0xFF960606),
                    fontSize: 16.sp, // Tambah .sp
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 12.h), // Hapus const, tambah .h
                Text(
                  // Hapus const
                  'This will permanently delete all your progress, achievements, and account data. This action cannot be undone.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    // Hapus const
                    color: const Color(0xFF960606),
                    fontSize: 14.sp, // Tambah .sp
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: 24.h), // Hapus const, tambah .h
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(dialogContext); // Tutup dialog
                    _deleteFirebaseAccount(context); // Jalankan fungsi hapus
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF960606),
                    minimumSize: Size(
                      double.infinity,
                      48.h,
                    ), // Hapus const, tambah .h
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ), // Tambah .r
                    elevation: 0,
                  ),
                  child: Text(
                    // Hapus const
                    'Yes, Delete Everything',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700,
                    ), // Tambah .sp
                  ),
                ),
                SizedBox(height: 12.h), // Hapus const, tambah .h
                TextButton(
                  onPressed: () => Navigator.pop(dialogContext),
                  style: TextButton.styleFrom(
                    minimumSize: Size(
                      double.infinity,
                      40.h,
                    ), // Hapus const, tambah .h
                  ),
                  child: Text(
                    // Hapus const
                    'Cancel',
                    style: TextStyle(
                      // Hapus const
                      color: const Color(0xFF5D5D5D),
                      fontSize: 14.sp, // Tambah .sp
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
          MaterialPageRoute(builder: (context) => const SplashScreen()),
          (route) => false,
        );
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'requires-recent-login') {
        scaffoldMessenger.showSnackBar(
          const SnackBar(
            content: Text(
              'Untuk keamanan, silakan Logout lalu Login kembali sebelum menghapus akun.',
            ),
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
          style: TextStyle(
            color: Color(0xFF960606),
            fontWeight: FontWeight.bold,
          ),
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
          padding: EdgeInsets.symmetric(
            horizontal: 20.w,
            vertical: 24.h,
          ), // Hapus const, tambah .w & .h
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
                          radius: 53.r, // Tambah .r
                          backgroundColor: const Color(0xFF960606),
                          child: Text(
                            // Hapus const
                            userName.isNotEmpty
                                ? userName[0].toUpperCase()
                                : 'H',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 40.sp,
                              fontWeight: FontWeight.bold,
                            ), // Tambah .sp
                          ),
                        ),
                        CircleAvatar(
                          radius: 16.r, // Tambah .r
                          backgroundColor: Colors.white,
                          child: IconButton(
                            padding: EdgeInsets.zero,
                            icon: Icon(
                              Icons.edit,
                              size: 16.sp,
                              color: const Color(0xFF960606),
                            ), // Hapus const, tambah .sp
                            onPressed: () {},
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.h), // Hapus const, tambah .h
                    Text(
                      // Hapus const
                      userName,
                      style: TextStyle(
                        color: const Color(0xFF960606),
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                      ), // Tambah .sp
                    ),
                    SizedBox(height: 4.h), // Hapus const, tambah .h
                    Text(
                      // Hapus const
                      userEmail,
                      style: TextStyle(
                        color: const Color(0xFF960606),
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                      ), // Tambah .sp
                    ),
                  ],
                ),
              ),
              SizedBox(height: 32.h), // Hapus const, tambah .h
              // LEARNING PROGRESS
              Text(
                // Hapus const
                'Learning Progress',
                style: TextStyle(
                  color: const Color(0xFF960606),
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                ), // Tambah .sp
              ),
              SizedBox(height: 12.h), // Hapus const, tambah .h

              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                mainAxisSpacing: 16.h, // Tambah .h
                crossAxisSpacing: 16.w, // Tambah .w
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
              SizedBox(height: 20.h), // Hapus const, tambah .h
              // SECTION PROGRESS BAR
              Container(
                padding: EdgeInsets.all(16.w), // Hapus const, tambah .w
                decoration: BoxDecoration(
                  // Hapus const
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15.r), // Tambah .r
                  border: Border.all(
                    color: const Color(0xFFE7E6E6),
                    width: 1.5,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 4,
                      offset: Offset(0, 2.h),
                    ), // Hapus const, tambah .h
                  ],
                ),
                child: Column(
                  children: [
                    _buildSectionProgress(
                      'Section 1',
                      1.0,
                      '100%',
                      Colors.green,
                    ),
                    SizedBox(height: 16.h), // Hapus const, tambah .h
                    _buildSectionProgress(
                      'Section 2',
                      0.6,
                      '60%',
                      const Color(0xFF960606),
                    ),
                    SizedBox(height: 16.h), // Hapus const, tambah .h
                    _buildSectionProgress(
                      'Section 3',
                      0.0,
                      '0%',
                      Colors.grey.withOpacity(0.5),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 32.h), // Hapus const, tambah .h
              // ACCOUNT SETTING LIST MENU
              Text(
                // Hapus const
                'Account Setting',
                style: TextStyle(
                  color: const Color(0xFF960606),
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                ), // Tambah .sp
              ),
              SizedBox(height: 12.h), // Hapus const, tambah .h

              _buildAccountTile(
                icon: Icons.settings,
                iconColor: const Color(0xFF960679),
                bgColor: const Color(0x22960679),
                title: 'Settings',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SettingsScreen(),
                    ),
                  );
                },
              ),
              SizedBox(height: 12.h), // Hapus const, tambah .h
              _buildAccountTile(
                icon: Icons.bar_chart,
                iconColor: const Color(0xFF5D8BCD),
                bgColor: const Color(0x225D8BCD),
                title: 'Statistics',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const StatisticsScreen(),
                    ),
                  );
                },
              ),
              SizedBox(height: 12.h), // Hapus const, tambah .h
              _buildAccountTile(
                icon: Icons.logout,
                iconColor: const Color(0xFFD54E00),
                bgColor: const Color(0x22D54E00),
                title: 'Logout',
                onTap: () => _showLogoutDialog(context),
              ),
              SizedBox(height: 12.h), // Hapus const, tambah .h
              _buildAccountTile(
                icon: Icons.delete_forever,
                iconColor: const Color(0xFF960606),
                bgColor: const Color(0x22960606),
                title: 'Delete Account',
                onTap: () {
                  _showDeleteDialog(context);
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
      padding: EdgeInsets.all(12.w), // Hapus const, tambah .w
      decoration: BoxDecoration(
        // Hapus const
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.r), // Tambah .r
        border: Border.all(color: const Color(0xFFE7E6E6), width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(8.w), // Hapus const, tambah .w
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(10.r),
            ), // Tambah .r
            child: Icon(
              icon,
              color: iconColor,
              size: 36.sp,
            ), // Hapus const, tambah .sp
          ),
          SizedBox(height: 12.h), // Hapus const, tambah .h
          Text(
            title,
            style: TextStyle(
              color: const Color(0xFF960606),
              fontSize: 13.sp,
              fontWeight: FontWeight.w500,
            ),
          ), // Hapus const, tambah .sp
          SizedBox(height: 2.h), // Hapus const, tambah .h
          Text(
            value,
            style: TextStyle(
              color: const Color(0xFF960606),
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
            ),
          ), // Hapus const, tambah .sp
        ],
      ),
    );
  }

  Widget _buildSectionProgress(
    String sectionName,
    double progressValue,
    String percentage,
    Color progressColor,
  ) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              sectionName,
              style: const TextStyle(
                color: Color(0xFF960606),
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              percentage,
              style: const TextStyle(
                color: Color(0xFF960606),
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        SizedBox(height: 6.h), // Hapus const, tambah .h
        ClipRRect(
          borderRadius: BorderRadius.circular(13.r), // Tambah .r
          child: LinearProgressIndicator(
            value: progressValue,
            minHeight: 10.h, // Tambah .h
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
      onTap: onTap,
      borderRadius: BorderRadius.circular(15.r), // Tambah .r
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 16.w,
          vertical: 12.h,
        ), // Hapus const, tambah .w & .h
        decoration: BoxDecoration(
          // Hapus const
          color: Colors.white,
          borderRadius: BorderRadius.circular(15.r), // Tambah .r
          border: Border.all(color: const Color(0xFFE7E6E6), width: 1.5),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 4,
              offset: Offset(0, 2.h),
            ), // Hapus const, tambah .h
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(8.w), // Hapus const, tambah .w
              decoration: BoxDecoration(
                color: bgColor,
                borderRadius: BorderRadius.circular(26.r),
              ), // Tambah .r
              child: Icon(
                icon,
                color: iconColor,
                size: 24.sp,
              ), // Hapus const, tambah .sp
            ),
            SizedBox(width: 16.w), // Hapus const, tambah .w
            Expanded(
              child: Text(
                // Hapus const
                title,
                style: TextStyle(
                  color: iconColor,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                ), // Tambah .sp
              ),
            ),
            Icon(Icons.chevron_right, color: iconColor.withOpacity(0.5)),
          ],
        ),
      ),
    );
  }
}
