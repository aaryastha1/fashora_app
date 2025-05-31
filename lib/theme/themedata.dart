import 'package:flutter/material.dart';

ThemeData getApplicationTheme(){
  return ThemeData(
     useMaterial3: false, primarySwatch: Colors.cyan,
     fontFamily: 'Opensans Regular',
     elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        textStyle: const TextStyle(
          fontSize: 17,
          color: Colors.white,
          fontWeight: FontWeight.w700,
        ),
        backgroundColor: Color(0xFF8A6D43),
         minimumSize: const Size(double.infinity,50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
     ),
     appBarTheme: const AppBarTheme(
    
      color:Color.fromARGB(255, 136, 187, 228),
      elevation: 10,
      shadowColor: Colors.black,
      titleTextStyle: TextStyle(
        fontFamily:'Ancizar Serif',
        fontSize: 20    ,
        color: Colors.black,
        fontWeight: FontWeight.bold,
      ),
     ),

  );
}