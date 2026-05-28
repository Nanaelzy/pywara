import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'signup_screen.dart';
import '../home/home_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // 1. Controller untuk menangkap input teks
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // 2. State untuk status sembunyikan password
  bool _obscurePassword = true;
  bool _isLoading = false;

  // 3. Fungsi Login Firebase
  Future<void> _loginWithFirebase() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      // Jika berhasil, arahkan ke halaman utama (Contoh: HomeScreen)
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Login Berhasil!'),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
      }
    } on FirebaseAuthException catch (e) {
      String message = 'Terjadi kesalahan';
      if (e.code == 'user-not-found') {
        message = 'Email tidak terdaftar.';
      } else if (e.code == 'wrong-password') {
        message = 'Password salah.';
      } else if (e.code == 'invalid-email') {
        message = 'Format email salah.';
      }

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(message), backgroundColor: Colors.red),
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
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: 1.sw, // Menggunakan 1.sw (100% Screen Width)
          height: 1.sh, // Menggunakan 1.sh (100% Screen Height)
          clipBehavior: Clip.antiAlias,
          decoration: const BoxDecoration(color: Colors.black),
          child: Form(
            key: _formKey, // Bungkus dengan Form untuk validasi
            child: Stack(
              children: [
                // 1. Background Gradient
                Positioned.fill(
                  child: Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment(1.00, 0.38),
                        end: Alignment(0.00, 0.00),
                        colors: [Color(0xFF810202), Color(0xFFD70000)],
                      ),
                    ),
                  ),
                ),
                // 2. Main White Container
                Positioned(
                  left: 0,
                  right: 0,
                  top: 281.h,
                  bottom: 0, // Ditarik sampai ke bawah layar
                  child: Container(
                    decoration: ShapeDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment(0.50, -0.00),
                        end: Alignment(0.50, 1.00),
                        colors: [Colors.white, Color(0xFFFFEEEC)],
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(47.r),
                          topRight: Radius.circular(47.r),
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
                // 3. Header & Logo
                Positioned(
                  left: 0,
                  right: 0,
                  top: 15.h,
                  child: Column(
                    children: [
                      // --- TEMPAT LOGO PNG ANDA ---
                      Image.asset(
                        'assets/images/logoutama.png',
                        width: 190.w, 
                        height: 190.h,
                        fit: BoxFit.contain,
                      ),
                      Transform.translate(
                        offset: Offset(0, -5.h), 
                        child: Text(
                          'Hello!',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      const SizedBox(height: 0),
                      Text(
                        "Let's explore together!",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 15.sp),
                      ),
                    ],
                  ),
                ),
                // 4. Tab Selector (Login Active)
                Positioned(
                  left: 49.w,
                  right: 49.w,
                  top: 313.h,
                  child: Container(
                    height: 51.h,
                    decoration: BoxDecoration(
                      color: const Color(0xFFE1E1E1),
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: const Color(0xFF960606),
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                            child: Center(
                              child: Text(
                                "Login",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14.sp,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const SignUpScreen(),
                                ),
                              );
                            },
                            child: Center(
                              child: Text(
                                "Sign Up",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14.sp,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // 5. Form Inputs (Menggunakan TextFormField asli)
                _buildEmailField(
                  top: 410.h,
                  label: 'Email Address',
                  hint: 'your.email@gmail.com',
                ),
                _buildPasswordField(
                  top: 525.h,
                  label: 'Enter Password',
                  hint: 'password',
                ),

                // 6. Forgot PIN
                Positioned(
                  right: 50.w,
                  top: 640.h,
                  child: GestureDetector(
                    onTap: () {
                      // Tambahkan aksi lupa password di sini
                    },
                    child: Text(
                      'Forgot PIN?',
                      style: TextStyle(
                        color: const Color(0xFF960606),
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),

                // 7. Login Button
                Positioned(
                  left: 27.w,
                  right: 27.w,
                  top: 690.h,
                  child: GestureDetector(
                    onTap: _isLoading ? null : _loginWithFirebase,
                    child: Container(
                      height: 62.h,
                      decoration: ShapeDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFFD60000), Color(0xFF960505)],
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                      ),
                      child: Center(
                        child: _isLoading
                            ? SizedBox(
                                width: 24.w,
                                height: 24.h,
                                child: const CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 3,
                                ),
                              )
                            : Text(
                                'Login',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                      ),
                    ),
                  ),
                ),
                // 8. Footer
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 30.h, // Menggunakan bottom agar fleksibel saat keyboard muncul
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Don’t have an account? ',
                        style: TextStyle(
                          color: const Color(0xFF878181),
                          fontSize: 14.sp,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SignUpScreen(),
                            ),
                          );
                        },
                        child: Text(
                          'Sign Up',
                          style: TextStyle(
                            color: const Color(0xFF960606),
                            fontSize: 14.sp,
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
      ),
    );
  }

  // Helper Input Email
  Widget _buildEmailField({
    required double top,
    required String label,
    required String hint,
  }) {
    return Positioned(
      left: 45.w,
      right: 45.w,
      top: top, // Tidak perlu top.h lagi karena sudah dikirim beserta .h dari pemanggil
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 8.h),
          TextFormField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Email tidak boleh kosong';
              }
              return null;
            },
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(color: const Color(0xFFA6A6A6), fontSize: 16.sp),
              filled: true,
              fillColor: const Color(0xFFEAEAEA),
              contentPadding: EdgeInsets.symmetric(
                horizontal: 16.w,
                vertical: 18.h,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16.r),
                borderSide: const BorderSide(
                  color: Color(0xFFD0D0D0),
                  width: 2,
                ),
              ),
              prefixIcon: Icon(
                Icons.email_outlined,
                color: const Color.fromARGB(255, 0, 0, 0),
                size: 22.sp,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16.r),
                borderSide: const BorderSide(
                  color: Color(0xFF960606),
                  width: 2,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16.r),
                borderSide: const BorderSide(color: Colors.red, width: 2),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16.r),
                borderSide: const BorderSide(color: Colors.red, width: 2),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Helper Input Password dengan Fitur Toggle Hide/Show
  Widget _buildPasswordField({
    required double top,
    required String label,
    required String hint,
  }) {
    return Positioned(
      left: 45.w,
      right: 45.w,
      top: top, // Tidak perlu top.h lagi karena sudah dikirim beserta .h dari pemanggil
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 8.h),
          TextFormField(
            controller: _passwordController,
            obscureText: _obscurePassword,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Password tidak boleh kosong';
              }
              return null;
            },
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(color: const Color(0xFFA6A6A6), fontSize: 16.sp),
              filled: true,
              fillColor: const Color(0xFFEAEAEA),
              contentPadding: EdgeInsets.symmetric(
                horizontal: 16.w,
                vertical: 18.h,
              ),
              prefixIcon: Icon(
                Icons.lock_outline,
                color: const Color.fromARGB(255, 0, 0, 0),
                size: 22.sp,
              ),
              suffixIcon: IconButton(
                icon: Icon(
                  _obscurePassword ? Icons.visibility_off : Icons.visibility,
                  color: const Color.fromARGB(255, 0, 0, 0),
                  size: 22.sp,
                ),
                onPressed: () {
                  setState(() {
                    _obscurePassword = !_obscurePassword;
                  });
                },
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16.r),
                borderSide: const BorderSide(
                  color: Color(0xFFD0D0D0),
                  width: 2,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16.r),
                borderSide: const BorderSide(
                  color: Color(0xFF960606),
                  width: 2,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16.r),
                borderSide: const BorderSide(color: Colors.red, width: 2),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16.r),
                borderSide: const BorderSide(color: Colors.red, width: 2),
              ),
            ),
          ),
        ],
      ),
    );
  }
}