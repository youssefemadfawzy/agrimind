import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final Color? bcolor;
  final Color? fcolor;
  final double? fsize;
  final bool isOutlined; // ← جديد: عشان نفرق بين الزرار العادي والتكست

  const CustomButton({
    super.key,
    required this.text,
    this.onPressed,
    this.bcolor,
    this.fsize,
    this.fcolor,
    this.isOutlined = false, // ← افتراضي false (زرار ممتلئ)
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // لو isOutlined = true → زرار تكست (skip)
    if (isOutlined) {
      return TextButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(
            fontSize: fsize ?? 16,
            color: fcolor  // لون أزرق افتراضي
          ),
        ),
      );
    }

    // لو isOutlined = false → زرار ممتلئ (continue)
    return SizedBox(
      width: screenWidth * 0.85,     // 85% من عرض الشاشة
      height: screenHeight * 0.065,  // ارتفاع مناسب
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: bcolor , // أزرق زي الصورة
          foregroundColor: fcolor,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50), // ← حواف دائرية جداً
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: fsize ?? 16,
            fontWeight: FontWeight.w600, // ← سميك شوية
          ),
        ),
      ),
    );
  }
}