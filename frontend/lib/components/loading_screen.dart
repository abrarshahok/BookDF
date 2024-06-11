import 'package:bookdf/constants/app_colors.dart';
import 'package:bookdf/constants/app_font_styles.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: buttonStyle.copyWith(
                  fontSize: 24,
                  color: secondaryColor,
                  fontWeight: FontWeight.w900,
                ),
                textAlign: TextAlign.center,
              ),
              LoadingAnimationWidget.prograssiveDots(
                color: secondaryColor,
                size: 60,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
