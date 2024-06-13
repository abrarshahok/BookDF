import 'package:auto_route/auto_route.dart';
import 'package:bookdf/components/custom_text_form_field.dart';
import 'package:bookdf/constants/app_colors.dart';
import 'package:bookdf/constants/app_font_styles.dart';
import 'package:flutter/material.dart';
import '/components/custom_border_button.dart';
import '/components/custom_button.dart';
import '/components/rating_stars.dart';
import '/constants/app_sizes.dart';

class AddReviewDialog extends StatefulWidget {
  const AddReviewDialog({super.key});

  @override
  State<AddReviewDialog> createState() => _AddReviewDialogState();
}

class _AddReviewDialogState extends State<AddReviewDialog> {
  final TextEditingController _reviewController = TextEditingController();
  double _rating = 1.0;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Add a Review',
        style: titleStyle,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      backgroundColor: bgColor,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const CustomTextFormField(hintText: 'Enter review here'),
          gapH20,
          RatingStars(
            rating: _rating,
            editable: true,
            iconSize: 50,
            onRatingChanged: (rating) {
              setState(() {
                _rating = rating;
              });
            },
          ),
        ],
      ),
      actions: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomBorderButton(
              label: 'Cancel',
              width: 100,
              height: 40,
              borderRadius: 8,
              textStyle: buttonStyle.copyWith(color: primaryColor),
              onPressed: () {
                context.router.maybePop();
              },
            ),
            gapW8,
            CustomButton(
              label: 'Add Review',
              height: 40,
              width: 150,
              borderRadius: 8,
              textStyle: buttonStyle,
              onPressed: () {},
            ),
          ],
        ),
      ],
    );
  }

  @override
  void dispose() {
    _reviewController.dispose();
    super.dispose();
  }
}
