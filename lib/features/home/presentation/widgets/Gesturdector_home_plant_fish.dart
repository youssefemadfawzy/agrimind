import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class GesturdectorHomePlantFish extends StatelessWidget {
  final String icon;
  final String text;
  final bool isSelected;
  final VoidCallback onTap;
  final Color activeColor;

  const GesturdectorHomePlantFish({
    super.key,
    required this.icon,
    required this.text,
    required this.isSelected,
    required this.onTap,
    required this.activeColor,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery
        .of(context)
        .size;

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque, // مهم جدًا
      child: Container(
        margin: EdgeInsets.all(5),
        padding:  EdgeInsets.symmetric(horizontal: 25, vertical: 15),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              icon,
              color: isSelected ? activeColor : Colors.grey,
              width: 20,
              height: 20,
            ),
            SizedBox(width: 8),
            Text(
              text,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: isSelected
                    ? activeColor
                    : const Color(0xff878686),
              ),
            ),
          ],
        ),
      ),
    );
  }}
