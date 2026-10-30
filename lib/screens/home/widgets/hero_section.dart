import 'package:flutter/material.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isMobile = screenWidth < 800;

    if (isMobile) {
      return Container(
        color: const Color(0xFFF8FAF9),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Tagline
            const Text(
              'LEARN  •  PRACTICE  •  DRIVE',
              style: TextStyle(
                color: Color(0xFF4A6B6C),
                fontWeight: FontWeight.w600,
                fontSize: 12,
                letterSpacing: 2,
              ),
            ),
            const SizedBox(height: 12),
            // Title
            const Text(
              'Learn to Drive\nwith Confidence',
              style: TextStyle(
                color: Color(0xFF0F3854),
                fontWeight: FontWeight.bold,
                fontSize: 32,
                height: 1.2,
              ),
            ),
            const SizedBox(height: 16),
            // Description
            const Text(
              'Professional driving lessons for women in a safe and supportive environment in Vehari.',
              style: TextStyle(
                color: Color(0xFF556B7A),
                fontSize: 15,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 24),
            // Buttons
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0F3854),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    elevation: 0,
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Book a Lesson',
                        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                      ),
                      SizedBox(width: 8),
                      Icon(Icons.arrow_forward, size: 16),
                    ],
                  ),
                ),
                OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFF0F3854),
                    padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
                    side: const BorderSide(color: Color(0xFF0F3854)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                  child: const Text(
                    'Explore Courses',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            // Image for Mobile
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                'assets/images/img_2.png',
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      );
    }

    // Desktop view
    return Container(
      width: double.infinity,
      color: const Color(0xFFF8FAF9),
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 1200, minHeight: 480),
          child: Stack(
            children: [
              // Image on Desktop
              Positioned.fill(
                child: Image.asset(
                  'assets/images/img_2.png',
                  fit: BoxFit.cover,
                  alignment: Alignment.centerRight,
                ),
              ),
              // Left side content with soft white gradient
              Positioned.fill(
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color(0xFFF8FAF9),
                        Color(0xFFF8FAF9),
                        Color(0xEEF8FAF9),
                        Color(0xAAF8FAF9),
                        Colors.transparent,
                      ],
                      stops: [0.0, 0.35, 0.50, 0.65, 0.85],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                  ),
                ),
              ),
              // Text and Action buttons
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 60),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'LEARN  •  PRACTICE  •  DRIVE',
                      style: TextStyle(
                        color: Color(0xFF4A6B6C),
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                        letterSpacing: 2,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Learn to Drive\nwith Confidence',
                      style: TextStyle(
                        color: Color(0xFF0F3854),
                        fontWeight: FontWeight.bold,
                        fontSize: 44,
                        height: 1.15,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const SizedBox(
                      width: 420,
                      child: Text(
                        'Professional driving lessons for women in a safe and supportive environment in Vehari.',
                        style: TextStyle(
                          color: Color(0xFF556B7A),
                          fontSize: 16,
                          height: 1.5,
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                    Row(
                      children: [
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF0F3854),
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24),
                            ),
                            elevation: 0,
                          ),
                          child: const Row(
                            children: [
                              Text(
                                'Book a Lesson',
                                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
                              ),
                              SizedBox(width: 8),
                              Icon(Icons.arrow_forward, size: 18),
                            ],
                          ),
                        ),
                        const SizedBox(width: 16),
                        OutlinedButton(
                          onPressed: () {},
                          style: OutlinedButton.styleFrom(
                            foregroundColor: const Color(0xFF0F3854),
                            padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 16),
                            side: const BorderSide(color: Color(0xFF0F3854), width: 1.2),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24),
                            ),
                          ),
                          child: const Text(
                            'Explore Courses',
                            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
