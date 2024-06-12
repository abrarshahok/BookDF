import 'package:bookdf/constants/app_colors.dart';
import 'package:flutter/material.dart';

class CustomBottomAppBar extends StatelessWidget {
  const CustomBottomAppBar({
    super.key,
    required this.items,
    this.backgroundColor,
    this.currentIndex = 0,
    this.onTap,
    this.selectedItemColor,
    this.unselectedItemColor,
    this.selectedColorOpacity = 0.1,
    this.itemShape = const StadiumBorder(),
    this.margin = const EdgeInsets.all(8),
    this.itemPadding = const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
    this.duration = const Duration(milliseconds: 500),
    this.curve = Curves.easeOutQuint,
    required this.height,
    this.addDivider = false,
  });

  final List<CustomBottomAppBarItem> items;
  final int currentIndex;
  final Function(int)? onTap;
  final Color? backgroundColor;
  final Color? selectedItemColor;
  final Color? unselectedItemColor;
  final double selectedColorOpacity;
  final ShapeBorder itemShape;
  final EdgeInsets margin;
  final EdgeInsets itemPadding;
  final Duration duration;
  final Curve curve;
  final double height;
  final bool addDivider;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: backgroundColor ?? Colors.transparent,
        border: Border(
          top: BorderSide(
            color: secondaryAccentColor.withOpacity(0.15),
            width: 1,
          ),
        ),
      ),
      padding: const EdgeInsets.only(top: 10),
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: items.length <= 2
            ? MainAxisAlignment.spaceEvenly
            : MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: items.map((item) {
          final isSelected = items.indexOf(item) == currentIndex;
          final selectedColor =
              item.selectedColor ?? selectedItemColor ?? theme.primaryColor;
          final unselectedColor = item.unselectedColor ??
              unselectedItemColor ??
              theme.iconTheme.color;
          final opacityColor = selectedColor.withOpacity(selectedColorOpacity);

          return Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Spacer(),
                TweenAnimationBuilder<double>(
                  tween: Tween(end: isSelected ? 1.0 : 0.0),
                  curve: curve,
                  duration: duration,
                  builder: (context, t, _) {
                    return InkWell(
                      onTap: () => onTap?.call(items.indexOf(item)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Material(
                            color: Color.lerp(selectedColor.withOpacity(0.0),
                                opacityColor, t),
                            shape: itemShape,
                            child: InkWell(
                              onTap: () => onTap?.call(items.indexOf(item)),
                              customBorder: itemShape,
                              splashColor: opacityColor,
                              child: Padding(
                                padding: itemPadding -
                                    EdgeInsets.only(
                                      right: itemPadding.right * t,
                                      left: itemPadding.left * t,
                                    ).resolve(Directionality.of(context)),
                                child: IconTheme(
                                  data: IconThemeData(
                                    color: Color.lerp(
                                        unselectedColor, selectedColor, t),
                                    size: 24,
                                  ),
                                  child: isSelected
                                      ? item.activeIcon ?? item.icon
                                      : item.icon,
                                ),
                              ),
                            ),
                          ),
                          item.title
                        ],
                      ),
                    );
                  },
                ),
                const Spacer(),
                if (items.indexOf(item) != items.length - 1 && addDivider)
                  Container(
                    height: 30,
                    color: secondaryAccentColor.withOpacity(0.15),
                    width: 2,
                  ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}

class CustomBottomAppBarItem {
  final Widget icon;
  final Widget? activeIcon;
  final Widget title;
  final Color? selectedColor;
  final Color? unselectedColor;
  final TextStyle? textStyle;

  CustomBottomAppBarItem({
    required this.icon,
    required this.title,
    this.selectedColor,
    this.unselectedColor,
    this.activeIcon,
    this.textStyle,
  });
}
