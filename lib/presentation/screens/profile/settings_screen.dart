import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../auth/login_screen.dart'; // Sesuaikan dengan jalur file login kamu

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
  Future<void> _logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    if (context.mounted) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
        (route) => false, // Bersihkan semua history screen sebelumnya
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Setting',
          style: TextStyle(
            color: Color(0xFF960606),
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
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ================= SECTION 1: ACCOUNT =================
              const Text(
                'ACCOUNT',
                style: TextStyle(
                  color: Color(0xFF960606),
                  fontSize: 14,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 12),
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
              
              const SizedBox(height: 28),

              // ================= SECTION 2: LEARNING =================
              const Text(
                'LEARNING',
                style: TextStyle(
                  color: Color(0xFF59168B),
                  fontSize: 14,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 12),
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

              const SizedBox(height: 28),

              // ================= SECTION 3: PREFERENCES =================
              const Text(
                'PREFERENCES',
                style: TextStyle(
                  color: Color(0xFF59168B),
                  fontSize: 14,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 12),
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

              const SizedBox(height: 28),

              // ================= SECTION 4: ABOUT =================
              const Text(
                'ABOUT',
                style: TextStyle(
                  color: Color(0xFF59168B),
                  fontSize: 14,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 12),
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

              const SizedBox(height: 35),

              // ================= RED LOG OUT BUTTON =================
              InkWell(
                onTap: () => _logout(context),
                borderRadius: BorderRadius.circular(16),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: const Color(0xFFFFC9C9), width: 2),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 3,
                        offset: const Offset(0, 1),
                      ),
                    ],
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.logout, color: Color(0xFFE7000B), size: 20),
                      SizedBox(width: 8),
                      Text(
                        'Log Out',
                        style: TextStyle(
                          color: Color(0xFFE7000B),
                          fontSize: 16,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 30),

              // ================= FOOTER TEXT =================
              const Center(
                child: Text(
                  'Made with love for Python learners',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF960606),
                    fontSize: 14,
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
      borderRadius: BorderRadius.circular(16),
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
    return const Divider(
      height: 1,
      thickness: 1,
      color: Color(0xFFFAF5FF),
      indent: 16,
      endIndent: 16,
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
      borderRadius: BorderRadius.circular(16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: const Color(0xFFFAF5FF),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Icon(icon, color: const Color(0xFF960606), size: 20),
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
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: Color(0xFF960606), size: 20),
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
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: const Color(0xFFFAF5FF),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Icon(icon, color: const Color(0xFF960606), size: 20),
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
                  style: const TextStyle(color: Color(0xFFD60000), fontSize: 14),
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