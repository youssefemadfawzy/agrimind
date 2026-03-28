import 'package:flutter/material.dart';
import '../../core/widgets/app_image.dart';

class Onboarding1 extends StatelessWidget {
  const Onboarding1({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Column(
      children: [
        SizedBox(height: height * 0.12),

        const Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [

            Image(image: AssetImage(AppImages.img1w)),
            Image(image: AssetImage(AppImages.img2w)),
            Image(image: AssetImage(AppImages.img3w)),
            Image(image: AssetImage(AppImages.img4w)),
          ],
        ),

        SizedBox(height: height * 0.02),

        /// الصف التاني
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image(image: AssetImage(AppImages.img5w)),

            Image(image: AssetImage(AppImages.img6w)),

            Image(image: AssetImage(AppImages.img7w)),

            Image(image: AssetImage(AppImages.img8w)),
          ],
        ),

        SizedBox(height: height * 0.04),

        /// العنوان
        const Text(
          'Browse All Your Products \n in One Place',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 24,
          ),
        ),

        SizedBox(height: height * 0.02),

        /// الوصف
        Padding(
          padding: EdgeInsets.symmetric(horizontal: width * 0.05),
          child: const Text(
            'Find everything you need \n fish, plants, and essential supplies \n all organized for fast,effortless shopping',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0x33000000),
              fontWeight: FontWeight.w400,
              fontSize: 16,
            ),
          ),
        ),
      ],
    );
  }
}