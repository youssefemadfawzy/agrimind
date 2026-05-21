import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:agrimind/core/widgets/Custom_InkWell_Icon.dart';
import 'package:agrimind/core/widgets/app_icons.dart';
import 'package:agrimind/core/widgets/custom_textfield.dart';

class SignupView extends StatefulWidget {
  const SignupView({super.key});

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  // 🔥 Controllers
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  // 🔥 Signup function (جاهزة للـ backend)
  void signup() {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    final confirmPassword = confirmPasswordController.text.trim();

    print("EMAIL: $email");
    print("PASSWORD: $password");
    print("CONFIRM: $confirmPassword");

    // هنا هنربط Django بعدين
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned(
            top: -size.height * 0.08,
            right: -size.width * 0.2,
            child: _buildBlurCircle(const Color(0xFF4D77F8), size.width * 0.7),
          ),
          Positioned(
            top: size.height * 0.25,
            right: size.width * 0.25,
            child: _buildBlurCircle(const Color(0xFF76FA86), size.width * 0.8),
          ),
          Positioned(
            bottom: size.height * 0.12,
            right: -size.width * 0.15,
            child: _buildBlurCircle(const Color(0xFF4D77F8), size.width * 0.7),
          ),

          SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.01),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: size.height * 0.15),

                  Text(
                    'Sign Up',
                    style: TextStyle(
                      fontSize: size.width * 0.08,
                      fontWeight: FontWeight.w800,
                      color: Colors.black,
                      letterSpacing: -1,
                    ),
                  ),

                  SizedBox(height: size.height * 0.02),

                  Text(
                    'Sign up to access all products and\nstart shopping easily',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: size.width * 0.04,
                      color: Colors.black54,
                      height: 1.4,
                    ),
                  ),

                  SizedBox(height: size.height * 0.04),

                  // 🔥 EMAIL
                  CustomTextField(
                    controller: emailController,
                    label: "Email",
                    hintText: "email",
                    prefixIcon: Icons.email,
                    keyboardType: TextInputType.emailAddress,
                  ),

                  // 🔥 PASSWORD
                  CustomTextField(
                    controller: passwordController,
                    isPassword: true,
                    label: "Password",
                    hintText: "password",
                    prefixIcon: Icons.lock,
                  ),

                  // 🔥 CONFIRM PASSWORD
                  CustomTextField(
                    controller: confirmPasswordController,
                    isPassword: true,
                    label: "Confirm Password",
                    hintText: "confirm password",
                    prefixIcon: Icons.lock,
                  ),

                  SizedBox(height: size.height * 0.04),

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
                    child: Row(
                      children: [
                        const Expanded(child: Divider(thickness: 2)),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            "or",
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: size.width * 0.05,
                            ),
                          ),
                        ),
                        const Expanded(child: Divider(thickness: 2)),
                      ],
                    ),
                  ),

                  SizedBox(height: size.height * 0.03),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CustomInkwellIcon(icon: AppIcons.facicon),
                      CustomInkwellIcon(icon: AppIcons.googlricon),
                      CustomInkwellIcon(icon: AppIcons.icloudicon),
                    ],
                  ),

                  SizedBox(height: size.height * 0.02),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "You have account? ",
                        style: TextStyle(color: Colors.black),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/login');
                        },
                        child: const Text(
                          "log in",
                          style: TextStyle(
                            color: Color(0xFF00E68A),
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: size.height * 0.02),

                  SizedBox(
                    width: size.width * 0.8,
                    child: ElevatedButton(
                      onPressed: () {
                        signup(); // 🔥 هنا الربط
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff337eff),
                        padding: EdgeInsets.symmetric(
                          vertical: size.height * 0.02,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                      ),
                      child: const Text(
                        "Continue",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBlurCircle(Color color, double size) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color.withOpacity(0.6),
        shape: BoxShape.circle,
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 80, sigmaY: 90),
        child: Container(color: Colors.transparent),
      ),
    );
  }
}