import 'dart:math';
import 'package:flutter/material.dart';

class TemperatureBarWidget extends StatelessWidget {
  final String name;
  final double value;
  final double min;
  final double max;
  final IconData icon;

  const TemperatureBarWidget({
    super.key,
    required this.name,
    required this.value,
    this.min = 0,
    this.max = 40,
    this.icon = Icons.thermostat_rounded,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // ── Header ──
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                name,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1A2340),
                ),
              ),
              Icon(icon, color: const Color(0xFF2ECC8A), size: 28),
            ],
          ),
          const SizedBox(height: 14),

          // ── Value badge ──
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFFFF6B8A),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              '${value.toInt()}°C',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 16,
              ),
            ),
          ),
          const SizedBox(height: 16),

          // ── Ticks bar + pointer ──
          SizedBox(
            height: 60,
            child: CustomPaint(
              painter: _TicksBarPainter(
                value: value,
                min: min,
                max: max,
              ),
              size: Size.infinite,
            ),
          ),
          const SizedBox(height: 6),

          // ── Progress bar ──
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: SizedBox(
              height: 6,
              child: CustomPaint(
                painter: _ProgressBarPainter(
                  value: value,
                  min: min,
                  max: max,
                ),
                size: Size.infinite,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Ticks + pointer painter ──
class _TicksBarPainter extends CustomPainter {
  final double value;
  final double min;
  final double max;

  const _TicksBarPainter({
    required this.value,
    required this.min,
    required this.max,
  });

  Color _tickColor(double t) {
    // t: 0.0 → 1.0
    // أول نص: أحمر/وردي → أخضر، تاني نص: أخضر → برتقالي → وردي
    if (t < 0.5) {
      return Color.lerp(
        const Color(0xFFFF8FAB),
        const Color(0xFF2ECC8A),
        t * 2,
      )!;
    } else {
      return Color.lerp(
        const Color(0xFF2ECC8A),
        const Color(0xFFFF8FAB),
        (t - 0.5) * 2,
      )!;
    }
  }

  @override
  void paint(Canvas canvas, Size size) {
    const totalTicks = 50;
    final pointerT = (value - min) / (max - min);
    final pointerX = pointerT * size.width;

    for (int i = 0; i <= totalTicks; i++) {
      final t = i / totalTicks;
      final x = t * size.width;
      final isMajor = i % 5 == 0;

      // الـ tick المجاور للـ pointer يكون أخضر ومختلف
      final isPointer = (x - pointerX).abs() < (size.width / totalTicks / 2);

      final tickHeight = isPointer
          ? size.height * 0.85
          : isMajor
          ? size.height * 0.65
          : size.height * 0.4;

      final color = isPointer
          ? const Color(0xFF2ECC8A)
          : _tickColor(t).withOpacity(0.75);

      final top = (size.height - tickHeight) / 2;

      final paint = Paint()
        ..color = color
        ..strokeWidth = isPointer ? 3.0 : isMajor ? 2.5 : 1.8
        ..strokeCap = StrokeCap.round;

      canvas.drawLine(
        Offset(x, top),
        Offset(x, top + tickHeight),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(_TicksBarPainter old) =>
      old.value != value || old.min != min || old.max != max;
}

// ── Progress bar painter ──
class _ProgressBarPainter extends CustomPainter {
  final double value;
  final double min;
  final double max;

  const _ProgressBarPainter({
    required this.value,
    required this.min,
    required this.max,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final t = (value - min) / (max - min);
    final fillWidth = t * size.width;

    // Background
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, size.width, size.height),
        const Radius.circular(10),
      ),
      Paint()..color = const Color(0xFFE8EDF5),
    );

    if (fillWidth > 0) {
      // Filled gradient
      final shader = const LinearGradient(
        colors: [Color(0xFFFF6B8A), Color(0xFFFF8FAB)],
      ).createShader(Rect.fromLTWH(0, 0, fillWidth, size.height));

      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(0, 0, fillWidth, size.height),
          const Radius.circular(10),
        ),
        Paint()..shader = shader,
      );
    }
  }

  @override
  bool shouldRepaint(_ProgressBarPainter old) =>
      old.value != value || old.min != min || old.max != max;
}