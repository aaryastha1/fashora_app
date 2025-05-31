// favorite_screen.dart
import 'package:flutter/material.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Favorites")),
      body: Center(child: Text("Favorite Items")),
    );
  }
}
