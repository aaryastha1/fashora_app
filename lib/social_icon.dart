import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SocialIcon extends StatelessWidget {
  final IconData icon;
  final Color color;

  const SocialIcon({
    Key? key,
    required this.icon,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 24,
      backgroundColor: color.withOpacity(0.1),
      child: FaIcon(
        icon,
        color: color,
        size: 28,
      ),
    );
  }
}

