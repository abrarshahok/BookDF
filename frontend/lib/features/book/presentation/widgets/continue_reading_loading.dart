import 'package:bookdf/components/shimmer_effect.dart';
import 'package:flutter/widgets.dart';

class ContinueReadingLoading extends StatelessWidget {
  const ContinueReadingLoading({
    super.key,
    required this.height,
    required this.width,
  });

  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 3,
        itemBuilder: (ctx, index) =>
            ShimmerEffect(width: width, height: height),
      ),
    );
  }
}
