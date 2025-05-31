


import 'package:fashora_app/View/splashscreen.dart';
import 'package:fashora_app/theme/themedata.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fashora App',
      theme: getApplicationTheme(),
      home: SplashScreen(),

    
      debugShowCheckedModeBanner: false,
    );
  }
}