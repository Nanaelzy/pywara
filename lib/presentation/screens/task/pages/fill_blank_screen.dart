import 'package:flutter/material.dart';
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

            // --- 4. Progress Bar (2/3) ---
            Positioned(
              left: 70,
              top: 30,
              child: Container(
                width: 290, // Lebar maksimal progress bar
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
                width: 200, // Diperpanjang menjadi sekitar 2/3 dari 302
                height: 10,
                decoration: BoxDecoration(
                  color: const Color(0xFF960606),
                  borderRadius: BorderRadius.circular(13),
                ),
              ),
            ),
            
            // --- 5. Teks Indikator Soal ---
            const Positioned(
              right: 18,
              top: 24,
              child: Text(
                '2/3', // Berubah dari 1/10 menjadi 2/3
                style: TextStyle(
                  color: Color(0xFF960606),
                  fontSize: 15.50,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            // --- 6. Box Pertanyaan ---
            Positioned(
              left: 26,
              top: 100,
              right: 26,
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0x99DDDDDD),
                  borderRadius: BorderRadius.circular(13),
                ),
                child: const Text(
                  'Insert the correct syntax to convert x into a complex number.',
                  style: TextStyle(
                    color: Color(0xFFA30D0D),
                    fontSize: 16,
                    fontFamily: 'Ubuntu',
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),

            // --- 7. AREA FILL IN THE BLANK ---
            Positioned(
              left: 41,
              top: 260,
              right: 41,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'x = 5',
                    style: TextStyle(
                      color: Color(0xFFA30D0D),
                      fontSize: 23,
                      fontFamily: 'Ubuntu',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const Text(
                        'x = ',
                        style: TextStyle(
                          color: Color(0xFFA30D0D),
                          fontSize: 23,
                          fontFamily: 'Ubuntu',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(width: 8),
                      // Kolom input teks
                      SizedBox(
                        width: 120,
                        child: TextField(
                          controller: _answerController,
                          enabled: !hasCheckedAnswer, // Input dikunci setelah Check Answer ditekan
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: inputColor, // Berubah hijau/merah berdasarkan hasil
                            fontSize: 20,
                            fontFamily: 'Ubuntu',
                            fontWeight: FontWeight.bold,
                          ),
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(vertical: 4),
                            // Garis bawah form (saat tidak dipilih)
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: inputColor, width: 2),
                            ),
                            // Garis bawah form (saat diklik/dipilih)
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: inputColor, width: 3),
                            ),
                            // Garis bawah form (saat dikunci/disabled)
                            disabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: inputColor, width: 2),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        '(x)',
                        style: TextStyle(
                          color: Color(0xFFA30D0D),
                          fontSize: 23,
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

            // --- 9. Bottom Bar & Check Answer Button ---
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
                    // Jika teks belum kosong dan belum pernah diperiksa
                    if (!hasCheckedAnswer && _answerController.text.trim().isNotEmpty) {
                      setState(() {
                        hasCheckedAnswer = true; // Kunci kolom jawaban
                        // Cek apakah ketikan user persis "complex" (mengabaikan huruf besar/kecil)
                        isCorrect = _answerController.text.trim().toLowerCase() == "complex";
                      });
                    } 
                    // Jika sudah diperiksa, tombol menjadi "Continue" dan pindah halaman
                    else if (hasCheckedAnswer) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ScrambleCodeScreen(), 
                        ),
                      );
                    }
                  },
                  child: Container(
                    width: 358,
                    height: 62,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        // Jika sudah diperiksa, tombol berubah abu-abu (Continue)
                        colors: hasCheckedAnswer 
                            ? [Colors.grey, Colors.grey.shade700] 
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
}