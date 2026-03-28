import 'package:agrimind/core/widgets/app_icons.dart';
import 'package:agrimind/core/widgets/app_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Onboarding2 extends StatelessWidget {
  const Onboarding2({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              AppImages.onboarding2,
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.blue.withValues(alpha: 0.7),
                    Colors.transparent,
                  ],
                  stops: const [
                    0.0,
                    0.7,
                  ],
                ),
              ),
            ),
          ),
          SafeArea(
            child: Center(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: size.width * 0.05,
                ),
                child: Column(
                  children: [
                    SizedBox(height: size.height * 0.08),

                    SvgPicture.asset(
                      AppIcons.mainIcon,
                      width: size.width * 0.2,
                      height: size.height * 0.05,
                      fit: BoxFit.contain,
                    ),

                    const SizedBox(height: 8),

                    const Text(
                      'Agrimind',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                      ),
                    ),

                    SizedBox(height: size.height * 0.18),

                    const Text(
                      'Easily Explore the Fish and \n Supplies You Need',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 24,
                        color: Colors.white,
                      ),
                    ),

                    SizedBox(height: size.height * 0.03),

                    const Text(
                      'Search and discover your preferred fish \n and all related accessories with smooth\nand accurate filtering',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}