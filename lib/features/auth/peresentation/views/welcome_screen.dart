import 'package:agrimind/core/widgets/app_image.dart'; // تأكد من صحة المسار
import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final sizeHeight = MediaQuery.of(context).size.height;
    final sizeWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
          // الخلفية
          Positioned.fill(
            child: Image.asset(
              AppImages.Welcomeimg,
              fit: BoxFit.cover,
            ),
          ),

          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: sizeWidth * 0.034,
              ),
              child: Column(
                children: [
                  SizedBox(height: sizeHeight * 0.3),
                  const Text(
                    'Welcome to the Agrimind\n app',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 27,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  // مسافة مرنة تدفع النصوص للأسفل قليلاً
                  SizedBox(height: sizeHeight * 0.02),

                  const Text(
                    "Shop confidently with secure payments, reliable\n suppliers, and fast delivery",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 14, // صغرت الخط قليلاً ليتناسب مع الشاشات
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: sizeHeight * 0.23),
                  // زر الاستمرار (بدون Positioned لأنه داخل Column)
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/signup');
                    },
                    child: Container(
                      width: sizeWidth * 0.85,
                      height: 58,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x4D337EFF), // أضفت شفافية للظل ليظهر بشكل أجمل
                            blurRadius: 10,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: const Center(
                        child: Text(
                          'start now',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: sizeHeight * 0.04),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Already have an account ? ",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, 'login');
                        },
                        child: const Text(
                          "log in",
                          style: TextStyle(
                            color: Color(0xFF00E68A), // أو أي لون يبرز الكلمة
                            fontSize: 14,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: sizeHeight * 0.05),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}