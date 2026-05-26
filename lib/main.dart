import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart'; 
import '../presentation/screens/splash/splash_screen.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
  DevicePreview(
    enabled: !kReleaseMode,
    builder: (context) => const MyApp(),
  ),
 );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(412, 892), 
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          title: 'PyWara',
          debugShowCheckedModeBanner: false,
          
          // 3. Konfigurasi tambahan agar DevicePreview tidak error saat dipakai bersama ScreenUtil
          locale: DevicePreview.locale(context),
          builder: DevicePreview.appBuilder,
          
          home: child, // child ini akan memanggil SplashScreen yang didefinisikan di bawah
        );
      },
      child: const SplashScreen(), 
    );
  }
}