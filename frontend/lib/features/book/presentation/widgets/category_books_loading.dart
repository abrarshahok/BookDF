import 'package:flutter/widgets.dart';
import '/components/shimmer_effect.dart';

class CategoryBooksLoading extends StatelessWidget {
  const CategoryBooksLoading({
    super.key,
    required this.height,
    required this.width,
    this.itemCount = 4,
    this.useSizedBox = true,
  });

  final double height;
  final double width;
  final int itemCount;
  final bool useSizedBox;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: useSizedBox ? 400 : null,
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 2 / 2.5,
          crossAxisSpacing: 20,
          mainAxisSpacing: 10,
        ),
        itemCount: itemCount,
        itemBuilder: (ctx, index) => ShimmerEffect(
          width: width,
          height: height,
        ),
      ),
    );
  }
}
