import 'package:flutter/material.dart';

// ─── AI Health Analytics Widget ──────────────────────────────
class AIHealthAnalytics extends StatelessWidget {
  final String image;

  const AIHealthAnalytics({
    super.key,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'AI Health Analytics',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: Color(0xFF1A1A2E),
          ),
        ),
        const SizedBox(height: 16),

        SizedBox(
          height: 180,
          child: Stack(
            alignment: Alignment.center,
            children: [
              /// ── 4 Cards ──
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: _StatCard(
                          icon: 'assets/icons/growth.svg',
                          fallbackIcon: Icons.eco,
                          iconColor: const Color(0xFF4CAF50),
                          label: 'Growth Stage',
                          value: 'Harvest Ready',
                        ),
                      ),
                      const SizedBox(width: 90),
                      Expanded(
                        child: _StatCard(
                          icon: 'assets/icons/height.svg',
                          fallbackIcon: Icons.straighten,
                          iconColor: const Color(0xFF2196F3),
                          label: 'Avg. Height',
                          value: '15 cm',
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: _StatCard(
                          icon: 'assets/icons/hydration.svg',
                          fallbackIcon: Icons.water_drop_outlined,
                          iconColor: const Color(0xFF2196F3),
                          label: 'Hydration',
                          value: 'Optimal',
                        ),
                      ),
                      const SizedBox(width: 90),
                      Expanded(
                        child: _StatCard(
                          icon: 'assets/icons/health.svg',
                          fallbackIcon: Icons.favorite_border,
                          iconColor: const Color(0xFF4CAF50),
                          label: 'Health Status',
                          value: 'Healthy',
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              /// ── Plant Image ──
              Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(image), // ❗ بدون const هنا
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ─── Stat Card ────────────────────────────────────────────────
class _StatCard extends StatelessWidget {
  final String icon;
  final IconData fallbackIcon;
  final Color iconColor;
  final String label;
  final String value;

  const _StatCard({
    required this.icon,
    required this.fallbackIcon,
    required this.iconColor,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: const Color(0xFFD1FAE5),
          width: 1.2,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Icon(fallbackIcon, size: 15, color: iconColor),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  label,
                  style: const TextStyle(
                    fontSize: 11,
                    color: Colors.grey,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Color(0xFF1A1A2E),
            ),
          ),
        ],
      ),
    );
  }
}