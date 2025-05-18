
import 'package:fashora_app/View/Home_Screen.dart';
import 'package:fashora_app/View/login.dart';
import 'package:fashora_app/View/sign_up.dart';
import 'package:fashora_app/View/dashboard.dart';
import 'package:fashora_app/View/splashscreen.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fashora App',
      home: SplashScreen(),
    
      debugShowCheckedModeBanner: false,
    );
  }
}