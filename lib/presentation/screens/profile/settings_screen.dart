import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../auth/login_screen.dart'; // Sesuaikan dengan jalur file login kamu
import 'package:flutter_screenutil/flutter_screenutil.dart'; // Tambahkan import ini

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  // State untuk saklar otomatis (Switch)
  bool _pushNotifications = true;
  bool _soundEffects = true;
  bool _darkMode = false; // State tambahan untuk Preferences Dark Mode

  // Fungsi Log Out Firebase
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
              mainAxisSize:
                  MainAxisSize.min, // Tinggi dialog fleksibel mengikuti konten
              children: [
                // 1. Icon Keluar Resmi Flutter
                Container(
                  width: 50.w, // Tambah .w
                  height: 50.w, // Menggunakan .w juga agar bulat sempurna
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
                // 3. Deskripsi Teks
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
                // 4. Tombol: Yes, Log Out (Mengarah ke LoginScreen)
                InkWell(
                  onTap: () async {
                    Navigator.pop(dialogContext); // Tutup dialog
                    await FirebaseAuth.instance
                        .signOut(); // Keluar sesi Firebase
                    if (context.mounted) {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginScreen(),
                        ),
                        (route) => false, // Bersihkan riwayat navigasi
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          // Hapus const
          'Setting',
          style: TextStyle(
            // Hapus const
            color: const Color(0xFF960606),
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
          icon: const Icon(Icons.arrow_back, color: Color(0xFF960606)),
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
            horizontal: 20.w,
            vertical: 24.h,
          ), // Hapus const, tambah .w & .h
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ================= SECTION 1: ACCOUNT =================
              Text(
                // Hapus const
                'ACCOUNT',
                style: TextStyle(
                  // Hapus const
                  color: const Color(0xFF960606),
                  fontSize: 14.sp, // Tambah .sp
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 12.h), // Hapus const, tambah .h
              Container(
                decoration: _buildBoxDecoration(),
                child: Column(
                  children: [
                    _buildSettingTile(
                      icon: Icons.person_outline,
                      title: 'Profile',
                      subtitle: 'Manage your profile',
                      onTap: () {},
                    ),
                    _buildDivider(),
                    _buildSettingTile(
                      icon: Icons.privacy_tip_outlined,
                      title: 'Privacy',
                      subtitle: 'Data and privacy settings',
                      onTap: () {},
                    ),
                  ],
                ),
              ),

              SizedBox(height: 28.h), // Hapus const, tambah .h
              // ================= SECTION 2: LEARNING =================
              Text(
                // Hapus const
                'LEARNING',
                style: TextStyle(
                  // Hapus const
                  color: const Color(0xFF59168B),
                  fontSize: 14.sp, // Tambah .sp
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 12.h), // Hapus const, tambah .h
              Container(
                decoration: _buildBoxDecoration(),
                child: Column(
                  children: [
                    _buildSettingTile(
                      icon: Icons.track_changes,
                      title: 'Daily Goal',
                      subtitle: '10 minutes per day',
                      onTap: () {},
                    ),
                    _buildDivider(),
                    _buildSettingSwitchTile(
                      icon: Icons.notifications_none,
                      title: 'Push Notifications',
                      subtitle: 'Reminders to practice',
                      value: _pushNotifications,
                      onChanged: (bool newValue) {
                        setState(() => _pushNotifications = newValue);
                      },
                    ),
                    _buildDivider(),
                    _buildSettingSwitchTile(
                      icon: Icons.volume_up_outlined,
                      title: 'Sound Effects',
                      subtitle: 'Play sounds during lessons',
                      value: _soundEffects,
                      onChanged: (bool newValue) {
                        setState(() => _soundEffects = newValue);
                      },
                    ),
                  ],
                ),
              ),

              SizedBox(height: 28.h), // Hapus const, tambah .h
              // ================= SECTION 3: PREFERENCES =================
              Text(
                // Hapus const
                'PREFERENCES',
                style: TextStyle(
                  // Hapus const
                  color: const Color(0xFF59168B),
                  fontSize: 14.sp, // Tambah .sp
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 12.h), // Hapus const, tambah .h
              Container(
                decoration: _buildBoxDecoration(),
                child: Column(
                  children: [
                    _buildSettingSwitchTile(
                      icon: Icons.dark_mode_outlined,
                      title: 'Dark Mode',
                      subtitle: 'Toggle dark theme',
                      value: _darkMode,
                      onChanged: (bool newValue) {
                        setState(() => _darkMode = newValue);
                      },
                    ),
                    _buildDivider(),
                    _buildSettingTile(
                      icon: Icons.language_outlined,
                      title: 'Language',
                      subtitle: 'English',
                      onTap: () {},
                    ),
                  ],
                ),
              ),

              SizedBox(height: 28.h), // Hapus const, tambah .h
              // ================= SECTION 4: ABOUT =================
              Text(
                // Hapus const
                'ABOUT',
                style: TextStyle(
                  // Hapus const
                  color: const Color(0xFF59168B),
                  fontSize: 14.sp, // Tambah .sp
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 12.h), // Hapus const, tambah .h
              Container(
                decoration: _buildBoxDecoration(),
                child: Column(
                  children: [
                    _buildSettingTile(
                      icon: Icons.info_outline,
                      title: 'About PyWara',
                      subtitle: 'Version 1.0.0',
                      onTap: () {},
                    ),
                    _buildDivider(),
                    _buildSettingTile(
                      icon: Icons.menu_book_outlined,
                      title: 'Terms & Privacy',
                      subtitle: 'Legal information',
                      onTap: () {},
                    ),
                    _buildDivider(),
                    _buildSettingTile(
                      icon: Icons.help_outline,
                      title: 'Help Center',
                      subtitle: 'Get support',
                      onTap: () {},
                    ),
                  ],
                ),
              ),

              SizedBox(height: 35.h), // Hapus const, tambah .h
              // ================= RED LOG OUT BUTTON =================
              InkWell(
                onTap: () => _showLogoutDialog(context),
                borderRadius: BorderRadius.circular(16.r), // Tambah .r
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(
                    vertical: 16.h,
                  ), // Hapus const, tambah .h
                  decoration: BoxDecoration(
                    // Hapus const
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16.r), // Tambah .r
                    border: Border.all(
                      color: const Color(0xFFFFC9C9),
                      width: 2,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 3,
                        offset: const Offset(0, 1),
                      ),
                    ],
                  ),
                  child: Row(
                    // Hapus const
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.logout,
                        color: const Color(0xFFE7000B),
                        size: 20.sp,
                      ), // Hapus const, tambah .sp
                      SizedBox(width: 8.w), // Hapus const, tambah .w
                      Text(
                        // Hapus const
                        'Log Out',
                        style: TextStyle(
                          // Hapus const
                          color: const Color(0xFFE7000B),
                          fontSize: 16.sp, // Tambah .sp
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 30.h), // Hapus const, tambah .h
              // ================= FOOTER TEXT =================
              Center(
                // Hapus const
                child: Text(
                  // Hapus const
                  'Made with love for Python learners',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    // Hapus const
                    color: const Color(0xFF960606),
                    fontSize: 14.sp, // Tambah .sp
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  BoxDecoration _buildBoxDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16.r), // Tambah .r
      border: Border.all(color: const Color(0xFFF3E8FF), width: 1),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.05),
          blurRadius: 3,
          offset: const Offset(0, 1),
        ),
      ],
    );
  }

  Widget _buildDivider() {
    return Divider(
      // Hapus const
      height: 1.h, // Tambah .h
      thickness: 1,
      color: const Color(0xFFFAF5FF),
      indent: 16.w, // Tambah .w
      endIndent: 16.w, // Tambah .w
    );
  }

  Widget _buildSettingTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16.r), // Tambah .r
      child: Padding(
        padding: EdgeInsets.all(16.w), // Hapus const, tambah .w
        child: Row(
          children: [
            Container(
              width: 40.w, // Tambah .w
              height: 40.w, // Gunakan .w agar tetap bulat sempurna
              decoration: BoxDecoration(
                // Hapus const
                color: const Color(0xFFFAF5FF),
                borderRadius: BorderRadius.circular(20.r), // Tambah .r
              ),
              child: Icon(
                icon,
                color: const Color(0xFF960606),
                size: 20.sp,
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
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.chevron_right,
              color: const Color(0xFF960606),
              size: 20.sp,
            ), // Hapus const, tambah .sp
          ],
        ),
      ),
    );
  }

  Widget _buildSettingSwitchTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Padding(
      padding: EdgeInsets.all(16.w), // Hapus const, tambah .w
      child: Row(
        children: [
          Container(
            width: 40.w, // Tambah .w
            height: 40.w, // Gunakan .w agar tetap bulat sempurna
            decoration: BoxDecoration(
              // Hapus const
              color: const Color(0xFFFAF5FF),
              borderRadius: BorderRadius.circular(20.r), // Tambah .r
            ),
            child: Icon(
              icon,
              color: const Color(0xFF960606),
              size: 20.sp,
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
                    color: const Color(0xFFD60000),
                    fontSize: 14.sp,
                  ), // Tambah .sp
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            activeColor: Colors.white,
            activeTrackColor: const Color(0xFF9810FA),
            inactiveTrackColor: Colors.grey[300],
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}
