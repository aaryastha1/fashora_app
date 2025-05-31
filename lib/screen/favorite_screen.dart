import 'package:flutter/material.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Color(0xFFF6EBDD),
      appBar: AppBar(
         backgroundColor: Colors.white,
        elevation: 0,
        title: Image.asset(
          'assets/images/fashoraa.png',
          height: 80,
        ),

      ),
      

    );
  }
}