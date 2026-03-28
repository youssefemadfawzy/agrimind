import 'package:agrimind/core/widgets/app_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomInkwellIcon extends StatelessWidget {
  final String icon;
  const CustomInkwellIcon({super.key , required this.icon});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size; // مقاسات الشاشة
    return   Container(

      padding: const EdgeInsets.symmetric(vertical: 10 , horizontal: 32),
      decoration: BoxDecoration(
        color: Colors.white, // أو بيج فاتح
        border: Border.all(
          color: const Color(0xffeeeeee),
          width: 1.5,
        ),
        borderRadius: BorderRadius.circular(12),

      ),
      child: InkWell(
        onTap: () {
          // اعمل الأكشن هنا
        },
        child: SvgPicture.asset(
         icon,
          width: size.width * 0.2,
          height: size.height * 0.05,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
