// import 'package:agrimind/core/welcome_page.dart';
// import 'package:agrimind/views/onboardingview.dart';
import 'package:agrimind/onboarding/screens/onboardingview.dart';
import 'package:agrimind/onboarding/widgets/onboardingbody.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox.expand(
        child: Lottie.asset(
          'assets/lottie/splash (1).json',
          repeat: false,
          fit: BoxFit.cover,
          width: size.width,
          height: size.height,
          onLoaded: (composition) {
            Future.delayed(composition.duration, () {
              if (mounted) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>  const OnboardingView(),
                  ),
                );
              }
            });
          },
        ),
      ),
    );
  }
}