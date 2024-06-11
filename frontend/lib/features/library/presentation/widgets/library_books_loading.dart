import 'package:bookdf/components/shimmer_effect.dart';
import 'package:flutter/widgets.dart';

class LibraryBooksLoading extends StatelessWidget {
  const LibraryBooksLoading({
    super.key,
    required this.height,
    required this.width,
  });

  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return ShimmerEffect(width: width, height: height);
        },
        childCount: 6,
      ),
    );
  }
}
