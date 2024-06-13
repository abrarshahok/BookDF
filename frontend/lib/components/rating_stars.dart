import 'package:flutter/material.dart';

class RatingStars extends StatefulWidget {
  const RatingStars({
    super.key,
    required this.rating,
    this.iconSize = 30,
    required this.editable,
    this.color = Colors.amber,
    this.onRatingChanged,
    this.alignment = Alignment.center,
  });

  final double iconSize;
  final Color color;
  final bool editable;
  final double rating;
  final ValueChanged<double>? onRatingChanged;
  final Alignment? alignment;

  @override
  State<RatingStars> createState() => _RatingStarsState();
}

class _RatingStarsState extends State<RatingStars> {
  late double _rating;

  @override
  void initState() {
    super.initState();
    _rating = widget.rating;
  }

  void _handleTap(double tapPosition, int starIndex) {
    final newRating = tapPosition <= widget.iconSize / 2
        ? starIndex - 0.5
        : starIndex.toDouble();
    setState(() {
      _rating = newRating;
    });
    widget.onRatingChanged!(newRating);
  }

  Widget _buildStar(int starIndex) {
    return GestureDetector(
      onTapDown: widget.editable
          ? (details) {
              _handleTap(details.localPosition.dx, starIndex);
            }
          : null,
      child: Icon(
        _rating >= starIndex - 0.5 && _rating < starIndex
            ? Icons.star_half_rounded
            : _rating >= starIndex
                ? Icons.star_rate_rounded
                : Icons.star_border_rounded,
        size: widget.iconSize,
        color:
            _rating >= starIndex - 0.5 ? widget.color : const Color(0xffC4C4C4),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return widget.alignment == Alignment.center
        ? Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (index) {
                return Padding(
                  padding: const EdgeInsets.only(right: 2),
                  child: _buildStar(index + 1),
                );
              }),
            ),
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(5, (index) {
              return Padding(
                padding: const EdgeInsets.only(right: 2),
                child: _buildStar(index + 1),
              );
            }),
          );
  }
}
