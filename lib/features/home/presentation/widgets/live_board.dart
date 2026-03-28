import 'package:agrimind/core/widgets/app_image.dart';
import 'package:flutter/material.dart';

class LiveBoard extends StatefulWidget {
  const LiveBoard({super.key});

  @override
  State<LiveBoard> createState() => _LiveBoardState();
}

class _LiveBoardState extends State<LiveBoard>
    with SingleTickerProviderStateMixin {
  late AnimationController _blinkController;
  late Animation<double> _blinkAnimation;

  @override
  void initState() {
    super.initState();
    _blinkController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);
    _blinkAnimation = Tween<double>(begin: 1.0, end: 0.2)
        .animate(CurvedAnimation(parent: _blinkController, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _blinkController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Container(
      margin: const EdgeInsets.all(5),
      height: height / 4,
      width: width,
      child: ClipPath(
        clipper: ConcaveClipper(),
        child: Stack(
          children: [
            // ── الـ stream / صورة ──
            SizedBox.expand(
              child: Image.asset(
                AppImages.onboarding2,
                fit: BoxFit.cover,
              ),
            ),

            // ── LIVE badge ──
            Positioned(
              top: 12,
              left: 14,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.3),
                    width: 0.5,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    FadeTransition(
                      opacity: _blinkAnimation,
                      child: Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                    const SizedBox(width: 6),
                    const Text(
                      'LIVE',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class ConcaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final double curve = 18.0; // قوة الانحناء — زوّد الرقم تزيد القوس
    final double corner = 24.0; // حجم الركن

    final path = Path();

    // أعلى: من شمال لـ يمين (انحناء للداخل = للأسفل)
    path.moveTo(corner, 0);
    path.quadraticBezierTo(size.width / 2, curve, size.width - corner, 0);

    // ركن أعلى يمين
    path.quadraticBezierTo(size.width, 0, size.width, corner);

    // يمين: من أعلى لأسفل (انحناء للداخل = لليسار)
    path.quadraticBezierTo(
        size.width - curve, size.height / 2, size.width, size.height - corner);

    // ركن أسفل يمين
    path.quadraticBezierTo(
        size.width, size.height, size.width - corner, size.height);

    // أسفل: من يمين لشمال (انحناء للداخل = للأعلى)
    path.quadraticBezierTo(
        size.width / 2, size.height - curve, corner, size.height);

    // ركن أسفل شمال
    path.quadraticBezierTo(0, size.height, 0, size.height - corner);

    // شمال: من أسفل لأعلى (انحناء للداخل = لليمين)
    path.quadraticBezierTo(curve, size.height / 2, 0, corner);

    // ركن أعلى شمال
    path.quadraticBezierTo(0, 0, corner, 0);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}