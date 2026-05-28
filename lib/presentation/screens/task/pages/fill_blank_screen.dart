import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // Tambahkan import ini
import 'scramble_code_screen.dart';
import '../../home/home_screen.dart';

class FillBlankScreen extends StatefulWidget {
  const FillBlankScreen({super.key});

  @override
  State<FillBlankScreen> createState() => _FillBlankScreenState();
}

class _FillBlankScreenState extends State<FillBlankScreen> {
  // Controller untuk mengambil teks yang diketik pengguna
  final TextEditingController _answerController = TextEditingController();

  // --- TAMBAHAN STATE ---
  bool hasCheckedAnswer = false; // Melacak apakah tombol check sudah ditekan
  bool isCorrect = false; // Melacak apakah jawaban pengguna benar atau salah

  @override
  void dispose() {
    _answerController.dispose();
    super.dispose();
  }

  // Fungsi untuk memunculkan popup konfirmasi keluar
  void _showQuitConfirmation() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r), // Tambah .r
          ),
          title: Text(
            // Hapus const
            'Quit Lesson?',
            style: TextStyle(
              // Hapus const
              fontFamily: 'Ubuntu',
              fontWeight: FontWeight.bold,
              color: const Color(0xFFA30D0D),
            ),
          ),
          content: Text(
            // Hapus const
            'Are you sure you want to quit? All your progress in this lesson will be lost.',
            style: TextStyle(
              // Hapus const
              fontFamily: 'Nunito',
              fontSize: 16.sp, // Tambah .sp
            ),
          ),
          actions: [
            // Tombol Cancel (Batal keluar)
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Hanya menutup dialog popup
              },
              child: Text(
                // Hapus const
                'Cancel',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16.sp,
                ), // Tambah .sp
              ),
            ),
            // Tombol Quit (Jadi keluar)
            TextButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()),
                );
              },
              child: Text(
                // Hapus const
                'Quit',
                style: TextStyle(
                  // Hapus const
                  color: const Color(0xFFD60000),
                  fontSize: 16.sp, // Tambah .sp
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showHintDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            width: 356.w, // Tambah .w
            height: 331.h, // Tambah .h
            decoration: ShapeDecoration(
              // Hapus const
              color: const Color(0xFFF5E3E3),
              shape: RoundedRectangleBorder(
                // Hapus const
                side: const BorderSide(
                  width: 2,
                  color: Color(0xFFA32A2A),
                ), // Pindah const
                borderRadius: BorderRadius.circular(26.r), // Tambah .r
              ),
            ),
            child: Stack(
              children: [
                Positioned(
                  left: 21.w,
                  top: 37.h,
                  right: 21.w, // Tambah .w dan .h
                  child: Text(
                    // Hapus const
                    'which one do you want AI to do to this question?',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: const Color(0xFFA30D0D),
                      fontSize: 15.sp,
                      fontFamily: 'Ubuntu',
                    ), // Tambah .sp
                  ),
                ),
                // Tombol Penjelasan
                Positioned(
                  left: 21.w,
                  top: 96.h,
                  right: 21.w, // Tambah .w dan .h
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context); // Tutup dialog
                      // TODO: Panggil fungsi AI untuk penjelasan di sini
                      print("User minta penjelasan syntax");
                    },
                    child: Container(
                      height: 80.h, // Tambah .h
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: const Color(0xFF824141),
                        borderRadius: BorderRadius.circular(13.r),
                      ), // Tambah .r
                      child: Text(
                        'give me an explanation on how the\nsyntax on this question works',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15.sp,
                          fontFamily: 'Ubuntu',
                        ),
                      ), // Tambah .sp
                    ),
                  ),
                ),
                // Tombol Jawaban
                Positioned(
                  left: 21.w,
                  top: 199.h,
                  right: 21.w, // Tambah .w dan .h
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context); // Tutup dialog
                      _showAnswerDialog();
                    },
                    child: Container(
                      height: 80.h, // Tambah .h
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: const Color(0xFF824141),
                        borderRadius: BorderRadius.circular(13.r),
                      ), // Tambah .r
                      child: Text(
                        'give me the answer of this question',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15.sp,
                          fontFamily: 'Ubuntu',
                        ),
                      ), // Tambah .sp
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

  // Fungsi untuk memunculkan popup jawaban langsung
  void _showAnswerDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            width: 356.w, // Tambah .w
            height: 347.h, // Tambah .h
            decoration: ShapeDecoration(
              // Hapus const
              color: const Color(0xFFF5E3E3),
              shape: RoundedRectangleBorder(
                // Hapus const
                side: const BorderSide(
                  width: 2,
                  color: Color(0xFFA32A2A),
                ), // Pindah const
                borderRadius: BorderRadius.circular(26.r), // Tambah .r
              ),
            ),
            child: Stack(
              children: [
                Positioned(
                  left: 25.w,
                  top: 14.h,
                  right: 25.w, // Tambah .w dan .h
                  child: Container(
                    height: 80.h, // Tambah .h
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: const Color(0xFF824141),
                      borderRadius: BorderRadius.circular(13.r),
                    ), // Tambah .r
                    child: Text(
                      'give me the answer of this question',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15.sp,
                        fontFamily: 'Ubuntu',
                      ),
                    ), // Tambah .sp
                  ),
                ),
                Positioned(
                  // Hapus const
                  left: 26.w,
                  top: 125.h,
                  right: 26.w, // Tambah .w dan .h
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'The answer is ',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16.sp,
                            fontFamily: 'Tsukimi Rounded',
                            fontWeight: FontWeight.w400,
                          ), // Tambah .sp
                        ),
                        TextSpan(
                          text: 'complex.',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16.sp,
                            fontFamily: 'Tsukimi Rounded',
                            fontWeight: FontWeight.w700,
                          ), // Tambah .sp
                        ),
                        TextSpan(
                          text:
                              ' This function\nconverts the integer 5 into the\ncomplex number format (5+0j).',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16.sp,
                            fontFamily: 'Tsukimi Rounded',
                            fontWeight: FontWeight.w400,
                          ), // Tambah .sp
                        ),
                      ],
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
    // Menentukan warna input berdasarkan status jawaban
    Color inputColor = const Color(0xFFA30D0D); // Merah gelap default
    if (hasCheckedAnswer) {
      inputColor = isCorrect ? Colors.green : Colors.red;
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            // --- 1. Background Gradient ---
            Container(
              width: double.infinity,
              height: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.white, Color(0xFFFFEEEB)],
                ),
              ),
            ),

            // --- 2. Top Bar Shadow ---
            Container(
              width: double.infinity,
              height: 70.h, // Tambah .h
              decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Color(0x3F000000),
                    blurRadius: 4,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
            ),

            // --- 3. Tombol Back ---
            Positioned(
              left: 18.w, // Tambah .w
              top: 15.h, // Tambah .h
              child: InkWell(
                onTap: () => _showQuitConfirmation(),
                child: Container(
                  width: 39.w, // Tambah .w
                  height: 39.w, // Tambah .w (agar bulat sempurna)
                  decoration: const BoxDecoration(
                    color: Color(0xFFF8F8F8),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.close, color: Colors.black54),
                ),
              ),
            ),

            // --- 4. Progress Bar (2/3) ---
            Positioned(
              left: 70.w, // Tambah .w
              top: 30.h, // Tambah .h
              child: Container(
                width: 290.w, // Tambah .w
                height: 10.h, // Tambah .h
                decoration: BoxDecoration(
                  // Hapus const
                  color: const Color(0x4C909090),
                  borderRadius: BorderRadius.circular(13.r), // Tambah .r
                ),
              ),
            ),
            Positioned(
              left: 70.w, // Tambah .w
              top: 30.h, // Tambah .h
              child: Container(
                width: 200.w, // Tambah .w
                height: 10.h, // Tambah .h
                decoration: BoxDecoration(
                  // Hapus const
                  color: const Color(0xFF960606),
                  borderRadius: BorderRadius.circular(13.r), // Tambah .r
                ),
              ),
            ),

            // --- 5. Teks Indikator Soal ---
            Positioned(
              // Hapus const
              right: 18.w, // Tambah .w
              top: 24.h, // Tambah .h
              child: Text(
                '2/3',
                style: TextStyle(
                  // Hapus const
                  color: const Color(0xFF960606),
                  fontSize: 15.50.sp, // Tambah .sp
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            // --- 6. Box Pertanyaan ---
            Positioned(
              left: 26.w, // Tambah .w
              top: 100.h, // Tambah .h
              right: 26.w, // Tambah .w
              child: Container(
                padding: EdgeInsets.all(20.w), // Hapus const, tambah .w
                decoration: BoxDecoration(
                  // Hapus const
                  color: const Color(0x99DDDDDD),
                  borderRadius: BorderRadius.circular(13.r), // Tambah .r
                ),
                child: Text(
                  // Hapus const
                  'Insert the correct syntax to convert x into a complex number.',
                  style: TextStyle(
                    // Hapus const
                    color: const Color(0xFFA30D0D),
                    fontSize: 16.sp, // Tambah .sp
                    fontFamily: 'Ubuntu',
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),

            // --- 7. AREA FILL IN THE BLANK ---
            Positioned(
              left: 41.w, // Tambah .w
              top: 260.h, // Tambah .h
              right: 41.w, // Tambah .w
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    // Hapus const
                    'x = 5',
                    style: TextStyle(
                      // Hapus const
                      color: const Color(0xFFA30D0D),
                      fontSize: 23.sp, // Tambah .sp
                      fontFamily: 'Ubuntu',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 10.h), // Hapus const, tambah .h
                  Row(
                    children: [
                      Text(
                        // Hapus const
                        'x = ',
                        style: TextStyle(
                          // Hapus const
                          color: const Color(0xFFA30D0D),
                          fontSize: 23.sp, // Tambah .sp
                          fontFamily: 'Ubuntu',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(width: 8.w), // Hapus const, tambah .w
                      // Kolom input teks
                      SizedBox(
                        width: 120.w, // Tambah .w
                        child: TextField(
                          controller: _answerController,
                          enabled: !hasCheckedAnswer,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            // Hapus const
                            color: inputColor,
                            fontSize: 20.sp, // Tambah .sp
                            fontFamily: 'Ubuntu',
                            fontWeight: FontWeight.bold,
                          ),
                          decoration: InputDecoration(
                            // Hapus const
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 4.h,
                            ), // Hapus const, tambah .h
                            enabledBorder: UnderlineInputBorder(
                              // Pindah const
                              borderSide: BorderSide(
                                color: inputColor,
                                width: 2,
                              ),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              // Pindah const
                              borderSide: BorderSide(
                                color: inputColor,
                                width: 3,
                              ),
                            ),
                            disabledBorder: UnderlineInputBorder(
                              // Pindah const
                              borderSide: BorderSide(
                                color: inputColor,
                                width: 2,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 8.w), // Hapus const, tambah .w
                      Text(
                        // Hapus const
                        '(x)',
                        style: TextStyle(
                          // Hapus const
                          color: const Color(0xFFA30D0D),
                          fontSize: 23.sp, // Tambah .sp
                          fontFamily: 'Ubuntu',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // --- 8. Hint Text ---
            Positioned(
              left: 0,
              right: 0,
              bottom: 110.h, // Tambah .h
              child: Center(
                child: GestureDetector(
                  onTap: _showHintDialog,
                  child: Text(
                    // Hapus const
                    'Need a hint ? Try our AI!',
                    style: TextStyle(
                      // Hapus const
                      color: const Color(0xFFA30D0D),
                      fontSize: 15.sp, // Tambah .sp
                      fontFamily: 'Ubuntu',
                      fontWeight: FontWeight.w500,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ),
            ),

            // --- 9. Bottom Bar & Check Answer Button ---
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                height: 91.h, // Tambah .h
                decoration: const BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x3F000000),
                      blurRadius: 4,
                      offset: Offset(0, -2),
                    ),
                  ],
                ),
                alignment: Alignment.center,
                child: GestureDetector(
                  onTap: () {
                    if (!hasCheckedAnswer &&
                        _answerController.text.trim().isNotEmpty) {
                      setState(() {
                        hasCheckedAnswer = true;
                        isCorrect =
                            _answerController.text.trim().toLowerCase() ==
                            "complex";
                      });
                    } else if (hasCheckedAnswer) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ScrambleCodeScreen(),
                        ),
                      );
                    }
                  },
                  child: Container(
                    width: 358.w, // Tambah .w
                    height: 62.h, // Tambah .h
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      // Hapus const
                      gradient: LinearGradient(
                        // Pindah const
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: hasCheckedAnswer
                            ? [Colors.grey, Colors.grey.shade700]
                            : [
                                const Color(0xFFD60000),
                                const Color(0xFF960505),
                              ],
                      ),
                      borderRadius: BorderRadius.circular(20.r), // Tambah .r
                    ),
                    child: Text(
                      // Hapus const
                      hasCheckedAnswer ? 'Continue' : 'Check Answer',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ), // Tambah .sp
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
