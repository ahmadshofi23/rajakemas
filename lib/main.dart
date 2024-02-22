import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:rajakemas/home_screen.dart';
import 'package:rajakemas/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp(
    options: FirebaseOptions(
        apiKey: 'AIzaSyC5z8o1E8qEHkUCN1h8jwgjuGU7LS3Tod8',
        appId: '1:958231488414:android:053c09d646367d6b8b988f',
        messagingSenderId: '958231488414',
        projectId: 'rajakemas-696bc'
    )
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          color: Color(0xffEDD358)
        )
      ),
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}


