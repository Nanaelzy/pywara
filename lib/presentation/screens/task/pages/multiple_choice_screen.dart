import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // Tambahkan import ini
import 'fill_blank_screen.dart';
import '../../home/home_screen.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  // --- STATE ---
  int? selectedAnswerIndex;
  bool hasCheckedAnswer = false; // Melacak apakah user sudah klik Check Answer

  // Jawaban yang benar (Misal index 1: 'print(type(x))')
  final int correctAnswerIndex = 1;

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
                side: BorderSide(
                  width: 2.w,
                  color: const Color(0xFFA32A2A),
                ), // Hapus const, tambah .w
                borderRadius: BorderRadius.circular(26.r), // Tambah .r
              ),
            ),
            child: Stack(
              children: [
                Positioned(
                  left: 21.w,
                  top: 37.h,
                  right: 21.w, // Tambah .w & .h
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
                  right: 21.w, // Tambah .w & .h
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
                  right: 21.w, // Tambah .w & .h
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

  // Fungsi untuk memunculkan dialog jawaban langsung
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
                side: BorderSide(
                  width: 2.w,
                  color: const Color(0xFFA32A2A),
                ), // Hapus const, tambah .w
                borderRadius: BorderRadius.circular(26.r), // Tambah .r
              ),
            ),
            child: Stack(
              children: [
                Positioned(
                  left: 25.w,
                  top: 14.h,
                  right: 25.w, // Tambah .w & .h
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
                  right: 26.w, // Tambah .w & .h
                  child: Text(
                    // Hapus const
                    'The correct answer is:\nprint(type(x))\n\nThis will print the data type of the variable x in Python.\nThe type() function returns the type object and print()\ndisplays it to the console.',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.sp,
                      fontFamily: 'Tsukimi Rounded',
                    ), // Tambah .sp
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
                  height: 39.w, // Tambah .w agar bundar sempurna
                  decoration: const BoxDecoration(
                    color: Color(0xFFF8F8F8),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.close, color: Colors.black54),
                ),
              ),
            ),

            // Progress Bar (1/3)
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
                width: 100.w, // Tambah .w
                height: 10.h, // Tambah .h
                decoration: BoxDecoration(
                  // Hapus const
                  color: const Color(0xFF960606),
                  borderRadius: BorderRadius.circular(13.r), // Tambah .r
                ),
              ),
            ),

            // Teks Indikator Soal
            Positioned(
              // Hapus const
              right: 18.w, // Tambah .w
              top: 24.h, // Tambah .h
              child: Text(
                '1/3',
                style: TextStyle(
                  // Hapus const
                  color: const Color(0xFF960606),
                  fontSize: 15.50.sp, // Tambah .sp
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            // Box Pertanyaan
            Positioned(
              left: 26.w, // Tambah .w
              top: 136.h, // Tambah .h
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
                  'If x = 5, what is the correct syntax for printing the data type of the variable x?',
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

            // Opsi Pilihan Ganda
            Positioned(
              left: 25.w, // Tambah .w
              right: 25.w, // Tambah .w
              top: 320.h, // Tambah .h
              child: Column(
                children: [
                  _buildOptionButton(index: 0, text: 'print(dtype(x))'),
                  SizedBox(height: 16.h), // Hapus const, tambah .h
                  _buildOptionButton(index: 1, text: 'print(type(x))'),
                  SizedBox(height: 16.h), // Hapus const, tambah .h
                  _buildOptionButton(index: 2, text: 'print(x.dtype())'),
                  SizedBox(height: 16.h), // Hapus const, tambah .h
                  _buildOptionButton(index: 3, text: 'print(x.type())'),
                ],
              ),
            ),

            // Hint Text
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

            // Bottom Bar & Check Answer Button
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
                    // Cek jika sudah ada opsi yang dipilih dan belum di-check
                    if (selectedAnswerIndex != null && !hasCheckedAnswer) {
                      setState(() {
                        hasCheckedAnswer =
                            true; // Mengaktifkan mode "Tampil Jawaban"
                      });
                    } else if (hasCheckedAnswer) {
                      // Pindah ke halaman tugas berikutnya (Fill in the Blank)
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const FillBlankScreen(),
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

  // Widget Helper untuk Tombol Pilihan Ganda (Dengan Logika Benar/Salah)
  Widget _buildOptionButton({required int index, required String text}) {
    bool isSelected = selectedAnswerIndex == index;
    bool isCorrectAnswer = index == correctAnswerIndex;

    // --- MENENTUKAN WARNA BERDASARKAN STATE ---
    Color borderColor = const Color(0xFFD0D0D0); // Default abu-abu
    Color backgroundColor = Colors.white;
    Color textColor = const Color(0xFF4B4B4B);

    if (hasCheckedAnswer) {
      // SETELAH TOMBOL CHECK ANSWER DITEKAN
      if (isCorrectAnswer) {
        // Jawaban Benar
        borderColor = Colors.green;
        backgroundColor = Colors.green.shade50;
        textColor = Colors.green.shade800;
      } else if (isSelected && !isCorrectAnswer) {
        // Jawaban yang dipilih pengguna ternyata SALAH
        borderColor = Colors.red;
        backgroundColor = Colors.red.shade50;
        textColor = Colors.red.shade800;
      }
    } else {
      // SEBELUM CHECK ANSWER
      if (isSelected) {
        borderColor = const Color(0xFFD60000);
        backgroundColor = const Color(0xFFFFEEEB);
        textColor = const Color(0xFFD60000);
      }
    }

    return GestureDetector(
      onTap: () {
        if (!hasCheckedAnswer) {
          setState(() {
            selectedAnswerIndex = index;
          });
        }
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 20.h), // Hapus const, tambah .h
        decoration: ShapeDecoration(
          // Hapus const
          color: backgroundColor,
          shape: RoundedRectangleBorder(
            // Hapus const
            side: BorderSide(
              width: 2.w, // Tambah .w
              color: borderColor,
            ),
            borderRadius: BorderRadius.circular(12.r), // Tambah .r
          ),
          shadows: [
            BoxShadow(
              color: const Color(0xFFD0D0D0),
              offset: Offset(0, 2.h),
            ), // Hapus const, tambah .h
          ],
        ),
        child: Text(
          // Hapus const
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            // Hapus const
            color: textColor,
            fontSize: 16.sp, // Tambah .sp
            fontFamily: 'Nunito',
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
