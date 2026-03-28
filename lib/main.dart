
import 'package:agrimind/features/auth/peresentation/views/login_view.dart';
import 'package:agrimind/features/auth/peresentation/views/signup_view.dart';
import 'package:agrimind/features/home/presentation/view/home_view.dart';
import 'package:agrimind/onboarding/screens/onboardingview.dart';
import 'package:flutter/material.dart';
import 'core/splash-screen.dart';



void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/onboarding': (context) => const OnboardingView(),
        '/signup': (context) => const SignupView(),
        '/login':(context) => const LoginView(),
        '/home':(context) => const HomeView(),


      },
    ),
  );
}
