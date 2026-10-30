import 'package:flutter/material.dart';

class FeaturesSection extends StatelessWidget {
  const FeaturesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isMobile = screenWidth < 800;

    final List<_FeatureData> features = [
      _FeatureData(
        icon: Icons.person_outline_rounded,
        title: 'Female Instructors',
        subtitle: 'Comfortable & respectful learning',
      ),
      _FeatureData(
        icon: Icons.verified_user_outlined,
        title: 'Safe Training',
        subtitle: 'Modern vehicles & proper guidance',
      ),
      _FeatureData(
        icon: Icons.calendar_today_outlined,
        title: 'Flexible Timings',
        subtitle: 'Day & evening slots available',
      ),
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 1200),
          decoration: BoxDecoration(
            color: const Color(0xFFF1F5F4),
            borderRadius: BorderRadius.circular(16),
          ),
          padding: EdgeInsets.all(isMobile ? 20 : 24),
          child: isMobile
              ? Column(
                  children: [
                    _buildFeatureItem(features[0]),
                    const Divider(height: 28, color: Color(0xFFD5E0DC)),
                    _buildFeatureItem(features[1]),
                    const Divider(height: 28, color: Color(0xFFD5E0DC)),
                    _buildFeatureItem(features[2]),
                  ],
                )
              : Row(
                  children: [
                    Expanded(child: _buildFeatureItem(features[0])),
                    Container(
                      height: 48,
                      width: 1,
                      color: const Color(0xFFD5E0DC),
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                    ),
                    Expanded(child: _buildFeatureItem(features[1])),
                    Container(
                      height: 48,
                      width: 1,
                      color: const Color(0xFFD5E0DC),
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                    ),
                    Expanded(child: _buildFeatureItem(features[2])),
                  ],
                ),
        ),
      ),
    );
  }

  Widget _buildFeatureItem(_FeatureData feature) {
    return Row(
      children: [
        Icon(
          feature.icon,
          size: 32,
          color: const Color(0xFF2A4D45),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                feature.title,
                style: const TextStyle(
                  color: Color(0xFF0F3854),
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                feature.subtitle,
                style: const TextStyle(
                  color: Color(0xFF627B77),
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _FeatureData {
  final IconData icon;
  final String title;
  final String subtitle;

  _FeatureData({
    required this.icon,
    required this.title,
    required this.subtitle,
  });
}
