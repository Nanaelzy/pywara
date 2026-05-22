import 'package:flutter/material.dart';
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

  // Fungsi untuk memunculkan popup konfirmasi keluar
  void _showQuitConfirmation() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Text(
            'Quit Lesson?',
            style: TextStyle(
              fontFamily: 'Ubuntu',
              fontWeight: FontWeight.bold,
              color: Color(0xFFA30D0D),
            ),
          ),
          content: const Text(
            'Are you sure you want to quit? All your progress in this lesson will be lost.',
            style: TextStyle(
              fontFamily: 'Nunito',
              fontSize: 16,
            ),
          ),
          actions: [
            // Tombol Cancel (Batal keluar)
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Hanya menutup dialog popup 
              },
              child: const Text(
                'Cancel',
                style: TextStyle(color: Colors.grey, fontSize: 16),
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
              child: const Text(
                'Quit',
                style: TextStyle(
                  color: Color(0xFFD60000), 
                  fontSize: 16, 
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
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
              height: 70, 
              decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(color: Color(0x3F000000), blurRadius: 4, offset: Offset(0, 4))
                ],
              ),
            ),

            // --- 3. Tombol Back ---
            Positioned(
              left: 18,
              top: 15,
              child: InkWell(
                onTap: () => _showQuitConfirmation(),
                child: Container(
                  width: 39,
                  height: 39,
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
              left: 70,
              top: 30,
              child: Container(
                width: 290,
                height: 10,
                decoration: BoxDecoration(
                  color: const Color(0x4C909090),
                  borderRadius: BorderRadius.circular(13),
                ),
              ),
            ),
            Positioned(
              left: 70, 
              top: 30,
              child: Container(
                width: 100, 
                height: 10,
                decoration: BoxDecoration(
                  color: const Color(0xFF960606),
                  borderRadius: BorderRadius.circular(13),
                ),
              ),
            ),
            
            // Teks Indikator Soal
            const Positioned(
              right: 18,
              top: 24,
              child: Text(
                '1/3',
                style: TextStyle(
                  color: Color(0xFF960606),
                  fontSize: 15.50,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            // Box Pertanyaan
            Positioned(
              left: 26,
              top: 136,
              right: 26,
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0x99DDDDDD),
                  borderRadius: BorderRadius.circular(13),
                ),
                child: const Text(
                  'If x = 5, what is the correct syntax for printing the data type of the variable x?',
                  style: TextStyle(
                    color: Color(0xFFA30D0D),
                    fontSize: 16,
                    fontFamily: 'Ubuntu',
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),

            // Opsi Pilihan Ganda
            Positioned(
              left: 25,
              right: 25,
              top: 320,
              child: Column(
                children: [
                  _buildOptionButton(index: 0, text: 'print(dtype(x))'),
                  const SizedBox(height: 16),
                  _buildOptionButton(index: 1, text: 'print(type(x))'),
                  const SizedBox(height: 16),
                  _buildOptionButton(index: 2, text: 'print(x.dtype())'),
                  const SizedBox(height: 16),
                  _buildOptionButton(index: 3, text: 'print(x.type())'),
                ],
              ),
            ),

            // Hint Text
            const Positioned(
              left: 0,
              right: 0,
              bottom: 110,
              child: Center(
                child: Text(
                  'Need a hint ? Try our AI!',
                  style: TextStyle(
                    color: Color(0xFFA30D0D),
                    fontSize: 15,
                    fontFamily: 'Ubuntu',
                    fontWeight: FontWeight.w500,
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
                height: 91,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(color: Color(0x3F000000), blurRadius: 4, offset: Offset(0, -2))
                  ],
                ),
                alignment: Alignment.center,
                child: GestureDetector(
                  onTap: () {
                    // Cek jika sudah ada opsi yang dipilih dan belum di-check
                    if (selectedAnswerIndex != null && !hasCheckedAnswer) {
                      setState(() {
                        hasCheckedAnswer = true; // Mengaktifkan mode "Tampil Jawaban"
                      });
                    }
                    else if (hasCheckedAnswer) {
                      // Pindah ke halaman tugas berikutnya (Fill in the Blank)
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const FillBlankScreen(), // Pastikan nama class-nya sesuai
                        ),
                      );
                    }
                  },
                  child: Container(
                    width: 358,
                    height: 62,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      // Mengubah warna tombol jika sudah di-check
                      gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: hasCheckedAnswer 
                            ? [Colors.grey, Colors.grey.shade700] // Jadi abu-abu kalau sudah dicek
                            : [const Color(0xFFD60000), const Color(0xFF960505)],
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      hasCheckedAnswer ? 'Continue' : 'Check Answer',
                      style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
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
        // Jawaban Benar (Selalu Hijau, baik itu dipilih atau tidak agar user tahu jawaban yang benar)
        borderColor = Colors.green;
        backgroundColor = Colors.green.shade50;
        textColor = Colors.green.shade800;
      } else if (isSelected && !isCorrectAnswer) {
        // Jawaban yang dipilih pengguna ternyata SALAH (Merah)
        borderColor = Colors.red;
        backgroundColor = Colors.red.shade50;
        textColor = Colors.red.shade800;
      }
    } else {
      // SEBELUM CHECK ANSWER (Saat baru diklik/dipilih)
      if (isSelected) {
        borderColor = const Color(0xFFD60000); // Garis merah
        backgroundColor = const Color(0xFFFFEEEB); // Background pink
        textColor = const Color(0xFFD60000); // Teks merah
      }
    }

    return GestureDetector(
      onTap: () {
        // Hanya bisa memilih jika belum menekan Check Answer
        if (!hasCheckedAnswer) {
          setState(() {
            selectedAnswerIndex = index;
          });
        }
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 20),
        decoration: ShapeDecoration(
          color: backgroundColor,
          shape: RoundedRectangleBorder(
            side: BorderSide(
              width: 2,
              color: borderColor,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          shadows: const [
            BoxShadow(color: Color(0xFFD0D0D0), offset: Offset(0, 2))
          ],
        ),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: textColor,
            fontSize: 16,
            fontFamily: 'Nunito',
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}