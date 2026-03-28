import 'dart:math';
import 'package:flutter/material.dart';

class ParametersPlant extends StatelessWidget {
  final String name;
  final String description;
  final int num;
  final double value;
  final double min;
  final double max;

  const ParametersPlant({
    super.key,
    required this.name,
    required this.description,
    required this.num,
    this.value = 14,
    this.min = 0,
    this.max = 40,
  });

  @override
  Widget build(BuildContext context) {
    // نحسب العرض المتاح للـ widget من الشاشة مباشرة
    final screenWidth = MediaQuery.of(context).size.width;
    // كل card بتاخد نص الشاشة ناقص الـ margins
    final cardWidth = (screenWidth / 2) - 24;
    final gaugeSize = cardWidth - 40; // ناقص الـ padding الداخلي

    return Container(
      width: cardWidth,
      margin: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Header ──
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    name,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF2D3A5E),
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const Icon(
                  Icons.thermostat_rounded,
                  color: Color(0xFF4A90D9),
                  size: 22,
                ),
              ],
            ),
            const SizedBox(height: 10),

            // ── Gauge بـ size محسوب مسبقاً ──
            SizedBox(
              width: gaugeSize,
              height: gaugeSize,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: gaugeSize,
                    height: gaugeSize,
                    child: CustomPaint(
                      painter: TemperatureGaugePainter(
                        value: value,
                        min: min,
                        max: max,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: gaugeSize * 0.22,
                    child: Column(
                      children: [
                        Text(
                          '$num°',
                          style: TextStyle(
                            fontSize: gaugeSize * 0.13,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF4CAF91),
                          ),
                        ),
                        Text(
                          description,
                          style: TextStyle(
                            fontSize: gaugeSize * 0.09,
                            color: const Color(0xFF4CAF91),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TemperatureGaugePainter extends CustomPainter {
  final double value;
  final double min;
  final double max;

  const TemperatureGaugePainter({
    required this.value,
    required this.min,
    required this.max,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final cx = size.width / 2;
    final cy = size.height * 0.62;
    final radius = size.width * 0.38;
    final strokeWidth = size.width * 0.05;

    const startAngle = pi * 0.75;
    const sweepAngle = pi * 1.5;
    final valueAngle = sweepAngle * ((value - min) / (max - min));

    // ── Ticks ──
    const totalTicks = 40;
    for (int i = 0; i <= totalTicks; i++) {
      final angle = startAngle + (i / totalTicks) * sweepAngle;
      final isMajor = i % 8 == 0;
      final tickOuter = radius - size.width * 0.01;
      final tickInner = isMajor
          ? radius - size.width * 0.09
          : radius - size.width * 0.05;

      canvas.drawLine(
        Offset(cx + cos(angle) * tickInner, cy + sin(angle) * tickInner),
        Offset(cx + cos(angle) * tickOuter, cy + sin(angle) * tickOuter),
        Paint()
          ..color = const Color(0xFFB0BEC5).withOpacity(0.5)
          ..strokeWidth = isMajor ? 1.5 : 1.0
          ..style = PaintingStyle.stroke,
      );
    }

    // ── Background arc ──
    canvas.drawArc(
      Rect.fromCircle(center: Offset(cx, cy), radius: radius - strokeWidth),
      startAngle,
      sweepAngle,
      false,
      Paint()
        ..color = const Color(0xFFE8EDF5).withOpacity(0.6)
        ..strokeWidth = strokeWidth
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round,
    );

    // ── Filled arc ──
    if (valueAngle > 0) {
      final shader = SweepGradient(
        startAngle: startAngle,
        endAngle: startAngle + valueAngle,
        colors: const [Color(0xFF4A90D9), Color(0xFF4CAF91)],
      ).createShader(
        Rect.fromCircle(center: Offset(cx, cy), radius: radius),
      );

      canvas.drawArc(
        Rect.fromCircle(center: Offset(cx, cy), radius: radius - strokeWidth),
        startAngle,
        valueAngle,
        false,
        Paint()
          ..shader = shader
          ..strokeWidth = strokeWidth
          ..style = PaintingStyle.stroke
          ..strokeCap = StrokeCap.round,
      );
    }

    // ── Labels ──
    final labels = [
      (value: 0.0, label: '0'),
      (value: 10.0, label: '10'),
      (value: 20.0, label: '20'),
      (value: 30.0, label: '30'),
      (value: 40.0, label: '30+'),
    ];

    for (final item in labels) {
      final angle = startAngle + ((item.value - min) / (max - min)) * sweepAngle;
      final labelR = radius + size.width * 0.1;
      final lx = cx + cos(angle) * labelR;
      final ly = cy + sin(angle) * labelR;

      final tp = TextPainter(
        text: TextSpan(
          text: item.label,
          style: TextStyle(
            color: const Color(0xFF8A9CC0).withOpacity(0.85),
            fontSize: size.width * 0.08,
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout();

      tp.paint(canvas, Offset(lx - tp.width / 2, ly - tp.height / 2));
    }
  }

  @override
  bool shouldRepaint(TemperatureGaugePainter old) =>
      old.value != value || old.min != min || old.max != max;
}