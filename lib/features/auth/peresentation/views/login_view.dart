import 'dart:ui';
import 'package:agrimind/core/widgets/Custom_InkWell_Icon.dart';
import 'package:agrimind/core/widgets/app_icons.dart';
import 'package:agrimind/core/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  // 🔥 Controllers (مفيش أي تأثير على الشكل)
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // 🔥 Login function (جاهزة للربط مع Django)
  void login() {
    if (emailController.text.isNotEmpty &&
        passwordController.text.isNotEmpty) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        '/home',
            (route) => false,
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill all fields")),
      );
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
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
                    'Log In',
                    style: TextStyle(
                      fontSize: size.width * 0.08,
                      fontWeight: FontWeight.w800,
                      color: Colors.black,
                      letterSpacing: -1,
                    ),
                  ),

                  SizedBox(height: size.height * 0.02),

                  Text(
                    'Welcome back! Continue caring for\n your fish and plants',
                    style: TextStyle(
                      fontSize: size.width * 0.04,
                      fontWeight: FontWeight.w400,
                      color: Colors.black54,
                      height: 1.4,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  SizedBox(height: size.height * 0.04),

                  // 🔥 EMAIL (نفس الشكل بدون تغيير)
                  CustomTextField(
                    controller: emailController,
                    label: "Email",
                    hintText: "email",
                    prefixIcon: Icons.email,
                    keyboardType: TextInputType.emailAddress,
                  ),

                  // 🔥 PASSWORD (نفس الشكل بدون تغيير)
                  CustomTextField(
                    controller: passwordController,
                    isPassword: true,
                    label: "Password",
                    hintText: "password",
                    prefixIcon: Icons.lock,
                  ),

                  const Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Forgot password?',
                        style: TextStyle(
                          color: Color(0xff337eff),
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
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

                  SizedBox(height: size.height * 0.02),

                  // 🔥 BUTTON (غيرنا بس الوظيفة مش الشكل)
                  SizedBox(
                    width: size.width * 0.8,
                    child: ElevatedButton(
                      onPressed: () {
                        login(); // 🔥 هنا الربط الحقيقي
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
                      child: Text(
                        "Continue",
                        style: TextStyle(
                          fontSize: size.width * 0.045,
                          color: Colors.white,
                        ),
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