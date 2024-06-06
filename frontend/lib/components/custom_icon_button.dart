import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  const CustomIconButton({
    super.key,
    required this.onTap,
    required this.icon,
    this.iconColor,
    this.angle = 0,
  });

  final VoidCallback onTap;
  final Color? iconColor;
  final IconData icon;
  final double angle;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onTap,
      icon: Transform.rotate(
        angle: angle,
        child: Icon(
          icon,
          color: iconColor,
        ),
      ),
    );
  }
}
