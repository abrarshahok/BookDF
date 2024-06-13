import 'package:bookdf/components/shimmer_effect.dart';
import 'package:flutter/widgets.dart';

class ContinueReadingLoading extends StatelessWidget {
  const ContinueReadingLoading({
    super.key,
    required this.height,
    required this.width,
    this.showSizedBox = true,
  });

  final double height;
  final double width;
  final bool showSizedBox;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: showSizedBox ? 200 : null,
      child: ListView.builder(
        scrollDirection: showSizedBox ? Axis.horizontal : Axis.vertical,
        itemCount: 3,
        itemBuilder: (ctx, index) =>
            ShimmerEffect(width: width, height: height),
      ),
    );
  }
}
