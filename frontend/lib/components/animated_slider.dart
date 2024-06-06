import 'package:bookdf/constants/app_colors.dart';
import 'package:bookdf/constants/app_font_styles.dart';
import 'package:bookdf/constants/app_sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';

class AnimatedSlider extends StatelessWidget {
  const AnimatedSlider({
    super.key,
    required this.currentValue,
  });

  final double currentValue;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        FAProgressBar(
          currentValue: currentValue,
          size: 5,
          maxValue: 100,
          animatedDuration: const Duration(milliseconds: 600),
          progressColor: accentColor,
          backgroundColor: accentColor.withOpacity(0.2),
        ),
        gapH4,
        Text(
          '${currentValue.toInt()}%',
          style: secondaryLightStyle,
        ),
      ],
    );
  }
}
