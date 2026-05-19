import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../intro/intro_screen1.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  // 1. Definisikan Controller untuk menangkap input
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // State untuk status sembunyikan password
  bool _obscurePassword = true;
  bool _isLoading = false;

  // 2. Fungsi untuk Sign Up ke Firebase
  Future<void> _signUp() async {
    final email = _emailController.text.trim();
    final name = _nameController.text.trim();
    final password = _passwordController.text.trim();

    if (email.isEmpty || name.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Semua field harus diisi!'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      // Create user di Firebase Auth
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      // Update display name di Firebase Auth profile
      await userCredential.user?.updateDisplayName(name);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Registrasi Berhasil!'),
            backgroundColor: Colors.green,
          ),
        );
        // Arahkan ke Login Screen setelah berhasil
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const IntroScreen1()),
        );
      }
    } on FirebaseAuthException catch (e) {
      String errorMessage = 'Terjadi kesalahan.';
      if (e.code == 'weak-password') {
        errorMessage = 'Password terlalu lemah.';
      } else if (e.code == 'email-already-in-use') {
        errorMessage = 'Email sudah terdaftar.';
      } else if (e.code == 'invalid-email') {
        errorMessage = 'Format email salah.';
      }

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(errorMessage), backgroundColor: Colors.red),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  void dispose() {
    // Bersihkan controller saat screen di-dispose
    _emailController.dispose();
    _nameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
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
              // 2. White Container (Form Area)
              Positioned(
                left: 0,
                top: 281,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height - 281,
                  decoration: ShapeDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment(0.50, -0.00),
                      end: Alignment(0.50, 1.00),
                      colors: [Colors.white, Color(0xFFFFEEEC)],
                    ),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(47),
                        topRight: Radius.circular(47),
                      ),
                    ),
                    shadows: const [
                      BoxShadow(
                        color: Color(0x3F000000),
                        blurRadius: 10,
                        offset: Offset(0, 4),
                        spreadRadius: 15,
                      ),
                    ],
                  ),
                ),
              ),
              // 3. Tab Bar (Login & Sign Up)
              Positioned(
                left: 49,
                right: 49,
                top: 313,
                child: Container(
                  height: 51,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE1E1E1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      // TAB LOGIN (BISA DIPENCET)
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LoginScreen(),
                              ),
                            );
                          },
                          child: const Center(
                            child: Text(
                              "Login",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ),
                      // TAB SIGN UP (ACTIVE)
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFF960606),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Center(
                            child: Text(
                              "Sign Up",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // 4. Header Text
              Positioned(
                left: 0,
                right: 0,
                top: 15, // Menurunkan sedikit agar tidak mentok ke atas layar
                child: Column(
                  children: [
                    // --- TEMPAT LOGO PNG ANDA ---
                    Image.asset(
                      'assets/images/logoutama.png',
                      width: 190,   // Ukurannya diperkecil agar pas dengan area header
                      height: 190,
                      fit: BoxFit.contain,
                    ),
                    Transform.translate(
                      offset: const Offset(0, -5), // <-- Angka -25 ini akan menarik teks ke atas sebesar 25 piksel
                      child: const Text(
                        'Hello!',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    const SizedBox(height: 0),
                    const Text(
                      "Let's explore together!",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                  ],
                ),
              ),

              // 5. Input Fhields
              _buildInputField(
                top: 415,
                label: 'Email Address',
                hint: 'your.email@gmail.com',
                controller: _emailController,
                icon: Icons.email_outlined, 
              ),
              _buildInputField(
                top: 515,
                label: 'Full Name',
                hint: 'your name',
                controller: _nameController,
                icon: Icons.person_outline,
              ),
              _buildInputField(
                top: 615,
                label: 'Password',
                hint: 'password',
                isPassword: true, // Mengaktifkan mode password
                controller: _passwordController,
                icon: Icons.lock_outline,
              ),

              // 6. Tombol Create Account (Sign Up)
              Positioned(
                left: 27,
                right: 27,
                top: 745, // Sesuaikan koordinat top agar pas di layar
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _signUp,
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    elevation: 3,
                  ),
                  child: Ink(
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFFD60000), Color(0xFF960505)],
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Container(
                      height: 62,
                      alignment: Alignment.center,
                      child: _isLoading
                          ? const SizedBox(
                              width: 24,
                              height: 24,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 3,
                              ),
                            )
                          : const Text(
                              'Create Account',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    ),
                  ),
                ),
              ),
              // 7. Text Bawah: Already have an account? Login (BISA DIPENCET)
              Positioned(
                left: 0,
                right: 0,
                bottom:
                    30, // Menggunakan bottom agar adaptif saat keyboard muncul
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Already have an account? ',
                      style: TextStyle(color: Color(0xFF878181), fontSize: 14),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginScreen(),
                          ),
                        );
                      },
                      child: const Text(
                        'Login',
                        style: TextStyle(
                          color: Color(0xFF960606),
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
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
    );
  }

  // Helper Widget untuk Input Field (Sudah ditambahkan fitur toggle visibility)
  Widget _buildInputField({
    required double top,
    required String label,
    required String hint,
    required TextEditingController controller,
    required IconData icon,
    bool isPassword = false,
  }) {
    return Positioned(
      left: 45,
      right: 45,
      top: top,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            height: 62,
            decoration: BoxDecoration(
              color: const Color(0xFFEAEAEA),
              border: Border.all(color: const Color(0xFFD0D0D0), width: 2),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Center(
              child: TextField(
                controller: controller,
                // Menggunakan status state jika ini field password
                obscureText: isPassword ? _obscurePassword : false,
                style: const TextStyle(color: Colors.black, fontSize: 16),
                decoration: InputDecoration(
                  hintText: hint,
                  hintStyle: const TextStyle(
                    color: Color(0xFFA6A6A6),
                    fontSize: 16,
                  ),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),

                  prefixIcon: Icon(
                    icon,
                    color: const Color.fromARGB(255, 0, 0, 0), // Warnanya disamakan dengan tema merah Anda
                    size: 22,
                  ),

                  // Menambahkan ikon mata jika isPassword bernilai true
                  suffixIcon: isPassword
                      ? IconButton(
                          icon: Icon(
                            _obscurePassword
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: const Color.fromARGB(255, 0, 0, 0),
                          ),
                          onPressed: () {
                            setState(() {
                              _obscurePassword = !_obscurePassword;
                            });
                          },
                        )
                      : null,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
