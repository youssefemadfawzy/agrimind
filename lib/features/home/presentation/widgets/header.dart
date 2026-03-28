import 'package:agrimind/core/widgets/app_icons.dart';
import 'package:agrimind/core/widgets/app_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return   Padding(
      padding: const EdgeInsets.only(top: 30.0),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: CircleAvatar(
              radius: 40,
              child: ClipOval(
                child: Image.asset(
                  AppImages.profileimg,
                  width: 80, // ضعف الـ radius
                  height: 80,
                  fit: BoxFit.cover, // عشان الصورة تملأ الدائرة بدون تمطيط
                ),
              ),
            ),
          ),
          const Column(
            children: [
              Text('Welcome,' , style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400
              ),),
              Text('joo' , style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500
              ),),
            ],
          ),
          const Spacer(flex: 1,),
          SvgPicture.asset(
            AppIcons.notification,
            width: size.width * 0.2,
            height: size.height * 0.05,
            fit: BoxFit.contain,
          ),
        ],
      ),
    );
  }
}
