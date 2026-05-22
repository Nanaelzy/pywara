import 'package:flutter/material.dart';
import '../../home/home_screen.dart';

class ScrambleCodeScreen extends StatefulWidget {
  const ScrambleCodeScreen({super.key});

  @override
  State<ScrambleCodeScreen> createState() => _ScrambleCodeScreenState();
}

class _ScrambleCodeScreenState extends State<ScrambleCodeScreen> {
  // --- STATE ---
  List<String> availableWords = ['typ', 'type', 'print', 'echo'];
  List<String?> filledSlots = [null, null]; 
  bool hasCheckedAnswer = false;
  final List<String> correctAnswers = ['print', 'type'];

  // Fungsi saat kata di bawah diklik (masuk ke slot kosong)
  void _onWordTapped(String word) {
    if (hasCheckedAnswer) return;

    setState(() {
      int emptySlotIndex = filledSlots.indexOf(null);
      if (emptySlotIndex != -1) {
        filledSlots[emptySlotIndex] = word;
        availableWords.remove(word);
      }
    });
  }

  // Fungsi saat kata di slot atas diklik (kembali ke bawah)
  void _onSlotTapped(int index) {
    if (hasCheckedAnswer) return;

    setState(() {
      if (filledSlots[index] != null) {
        availableWords.add(filledSlots[index]!);
        filledSlots[index] = null;
      }
    });
  }

  // Fungsi popup dari bawah saat tombol Continue ditekan
  void _showFinishBottomSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent, 
      isDismissible: false, 
      enableDrag: false,    
      builder: (BuildContext context) {
        return SizedBox(
          height: 363,
          width: double.infinity,
          child: Stack(
            children: [
              Positioned(
                left: 0,
                right: 0,
                top: 0,
                child: Container(
                  height: 363,
                  decoration: const BoxDecoration(
                    color: Color(0xFF8A1212),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                top: 8,
                child: Container(
                  height: 355,
                  decoration: const BoxDecoration(
                    color: Color(0xFFD85959),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    ),
                  ),
                ),
              ),
              const Positioned(
                left: 20,
                right: 20,
                top: 77,
                child: Text(
                  'you already finished the lesson',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFFFDFFFC),
                    fontSize: 32,
                    fontFamily: 'Baloo Bhaijaan',
                    height: 1.2,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Positioned(
                left: 32,
                right: 32,
                top: 246,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                      context, 
                      MaterialPageRoute(builder: (context) => const HomeScreen()),
                    );
                  },
                  child: Container(
                    height: 74,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFFCFB),
                      borderRadius: BorderRadius.circular(40),
                      boxShadow: const [
                        BoxShadow(color: Colors.black26, blurRadius: 4, offset: Offset(0, 2))
                      ],
                    ),
                    child: const Text(
                      'back to homepage',
                      style: TextStyle(
                        color: Color(0xFF956B0B),
                        fontSize: 20,
                        fontFamily: 'B612 Mono',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
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

  
  void _showHintDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            width: 356,
            height: 331,
            decoration: ShapeDecoration(
              color: const Color(0xFFF5E3E3),
              shape: RoundedRectangleBorder(
                side: const BorderSide(width: 2, color: Color(0xFFA32A2A)),
                borderRadius: BorderRadius.circular(26),
              ),
            ),
            child: Stack(
              children: [
                Positioned(
                  left: 21, top: 37, right: 21,
                  child: const Text(
                    'which one do you want AI to do to this question?',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Color(0xFFA30D0D), fontSize: 15, fontFamily: 'Ubuntu'),
                  ),
                ),
                // Tombol Penjelasan
                Positioned(
                  left: 21, top: 96, right: 21,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context); // Tutup dialog
                      // TODO: Panggil fungsi AI untuk penjelasan di sini
                      print("User minta penjelasan syntax");
                    },
                    child: Container(
                      height: 80,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(color: const Color(0xFF824141), borderRadius: BorderRadius.circular(13)),
                      child: const Text('give me an explanation on how the\nsyntax on this question works', textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 15, fontFamily: 'Ubuntu')),
                    ),
                  ),
                ),
                // Tombol Jawaban
                Positioned(
                  left: 21, top: 199, right: 21,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context); // Tutup dialog
                      _showAnswerDialog();
                    },
                    child: Container(
                      height: 80,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(color: const Color(0xFF824141), borderRadius: BorderRadius.circular(13)),
                      child: const Text('give me the answer of this question', textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 15, fontFamily: 'Ubuntu')),
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

  // Fungsi untuk memunculkan popup jawaban langsung (untuk Task Scramble Code)
  void _showAnswerDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            width: 356,
            height: 399, // Tinggi disesuaikan dengan konten baru
            decoration: ShapeDecoration(
              color: const Color(0xFFF5E3E3),
              shape: RoundedRectangleBorder(
                side: const BorderSide(width: 2, color: Color(0xFFA32A2A)),
                borderRadius: BorderRadius.circular(26),
              ),
            ),
            child: Stack(
              children: [
                // Header (Tombol Jawaban)
                Positioned(
                  left: 19, top: 36, right: 19,
                  child: Container(
                    width: 317,
                    height: 80,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(color: const Color(0xFF824141), borderRadius: BorderRadius.circular(13)),
                    child: const Text(
                      'give me the answer of this question', 
                      textAlign: TextAlign.center, 
                      style: TextStyle(color: Colors.white, fontSize: 15, fontFamily: 'Ubuntu')
                    ),
                  ),
                ),
                // Isi Jawaban (Text.rich)
                Positioned(
                  left: 26, top: 130, right: 26,
                  child: Text.rich(
                    TextSpan(
                      children: [
                        const TextSpan(
                          text: 'The correct sequence is ',
                          style: TextStyle(color: Colors.black, fontSize: 16, fontFamily: 'Tsukimi Rounded'),
                        ),
                        const TextSpan(
                          text: 'print',
                          style: TextStyle(color: Colors.black, fontSize: 16, fontFamily: 'Tsukimi Rounded', fontWeight: FontWeight.w700),
                        ),
                        const TextSpan(
                          text: ' and ',
                          style: TextStyle(color: Colors.black, fontSize: 16, fontFamily: 'Tsukimi Rounded'),
                        ),
                        const TextSpan(
                          text: 'type.\n',
                          style: TextStyle(color: Colors.black, fontSize: 16, fontFamily: 'Tsukimi Rounded', fontWeight: FontWeight.w700),
                        ),
                        const TextSpan(
                          text: 'The full line should be print(type(myvar)).\n'
                                'In Python, type() identifies the data\n'
                                'category of a variable, while print()\n'
                                'displays that information on the screen.',
                          style: TextStyle(color: Colors.black, fontSize: 16, fontFamily: 'Tsukimi Rounded'),
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

            // --- 4. Progress Bar (3/3) ---
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
                width: 290, 
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
                '3/3',
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
                  'Select the correct functions to print the data type of a variable:',
                  style: TextStyle(
                    color: Color(0xFFA30D0D),
                    fontSize: 16,
                    fontFamily: 'Ubuntu',
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),

            // --- 7. AREA SCRAMBLE TARGET ---
            Positioned(
              left: 26,
              right: 26,
              top: 250,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildSlot(0), 
                  const Text(
                    ' ( ',
                    style: TextStyle(color: Color(0xFFA30D0D), fontSize: 23, fontFamily: 'Ubuntu', fontWeight: FontWeight.bold),
                  ),
                  _buildSlot(1), 
                  const Text(
                    ' (myvar))',
                    style: TextStyle(color: Color(0xFFA30D0D), fontSize: 23, fontFamily: 'Ubuntu', fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),

            // --- 8. AREA WORD BANK ---
            Positioned(
              left: 26,
              right: 26,
              top: 350,
              child: Wrap(
                alignment: WrapAlignment.center,
                spacing: 15, 
                runSpacing: 15, 
                children: availableWords.map((word) {
                  return GestureDetector(
                    onTap: () => _onWordTapped(word),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      decoration: BoxDecoration(
                        color: hasCheckedAnswer ? Colors.grey.shade200 : Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: const Color(0xFFD0D0D0), width: 2),
                        boxShadow: [
                          if (!hasCheckedAnswer)
                            const BoxShadow(color: Color(0xFFD0D0D0), offset: Offset(0, 3))
                        ],
                      ),
                      child: Text(
                        word,
                        style: TextStyle(
                          color: hasCheckedAnswer ? Colors.grey : const Color(0xFFA30D0D),
                          fontSize: 20,
                          fontFamily: 'Ubuntu',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),

            // --- 9. Hint Text ---
            Positioned(
              left: 0,
              right: 0,
              bottom: 110,
              child: Center(
                child: GestureDetector( // BUNGKUS DENGAN INI
                  onTap: _showHintDialog, // PANGGIL FUNGSI POPUP DI SINI
                  child: const Text(
                    'Need a hint ? Try our AI!',
                    style: TextStyle(
                      color: Color(0xFFA30D0D),
                      fontSize: 15,
                      fontFamily: 'Ubuntu',
                      fontWeight: FontWeight.w500,
                      decoration: TextDecoration.underline, // Opsional: Tambahkan underline agar user tahu ini tombol
                    ),
                  ),
                ),
              ),
            ),

            // --- 10. Bottom Bar & Check Answer Button ---
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
                    if (!hasCheckedAnswer && !filledSlots.contains(null)) {
                      setState(() {
                        hasCheckedAnswer = true;
                      });
                    } 
                    else if (hasCheckedAnswer) {
                      _showFinishBottomSheet();
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

  Widget _buildSlot(int index) {
    bool isFilled = filledSlots[index] != null;
    
    Color slotColor = Colors.white;
    Color borderColor = const Color(0xFFD0D0D0);
    Color textColor = const Color(0xFFA30D0D);

    if (hasCheckedAnswer && isFilled) {
      bool isCorrect = filledSlots[index] == correctAnswers[index];
      
      if (isCorrect) {
        slotColor = Colors.green.shade50;
        borderColor = Colors.green;
        textColor = Colors.green.shade800;
      } else {
        slotColor = Colors.red.shade50;
        borderColor = Colors.red;
        textColor = Colors.red.shade800;
      }
    }

    return GestureDetector(
      onTap: () => _onSlotTapped(index),
      child: Container(
        width: 80, 
        height: 45,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isFilled ? slotColor : const Color(0x33A30D0D), 
          borderRadius: BorderRadius.circular(8),
          border: isFilled ? Border.all(color: borderColor, width: 2) : null,
          boxShadow: (isFilled && !hasCheckedAnswer) 
              ? const [BoxShadow(color: Color(0xFFD0D0D0), offset: Offset(0, 3))] 
              : null,
        ),
        child: isFilled
            ? Text(
                filledSlots[index]!,
                style: TextStyle(
                  color: textColor, 
                  fontSize: 20,
                  fontFamily: 'Ubuntu',
                  fontWeight: FontWeight.bold,
                ),
              )
            : null, 
      ),
    );
  }
}