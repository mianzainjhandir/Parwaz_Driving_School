import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CtaBannerSection extends StatelessWidget {
  const CtaBannerSection({super.key});

  Future<void> _onBookLesson(BuildContext context) async {
    final Uri whatsappUrl = Uri.parse(
        "https://wa.me/923234248524?text=Hello%20Parwaaz%20Driving%20Institute,%20I%20want%20to%20book%20a%20driving%20lesson.");
    if (!await launchUrl(whatsappUrl, mode: LaunchMode.externalApplication)) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Could not launch WhatsApp'),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isMobile = screenWidth < 850;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 16 : 40,
        vertical: 24,
      ),
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 1100),
          decoration: BoxDecoration(
            color: const Color(0xFFF8FAF9),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: const Color(0xFFE2ECE9)),
          ),
          padding: EdgeInsets.all(isMobile ? 20 : 28),
          child: isMobile
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Image for Mobile
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.asset(
                        'assets/images/cultus.png',
                        width: double.infinity,
                        height: 220,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Content for Mobile
                    const Text(
                      'YOUR JOURNEY MATTERS',
                      style: TextStyle(
                        color: Color(0xFF4A6B6C),
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                        letterSpacing: 2,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Drive Your Future',
                      style: TextStyle(
                        color: Color(0xFF0F3854),
                        fontWeight: FontWeight.bold,
                        fontSize: 28,
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Join Parwaaz Driving Institute and get the skills, confidence and support you need to be a safe and independent driver.',
                      style: TextStyle(
                        color: Color(0xFF556B7A),
                        fontSize: 14,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () => _onBookLesson(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF0F3854),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 14,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                        elevation: 0,
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Book Your Lesson',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),
                          SizedBox(width: 8),
                          Icon(Icons.arrow_forward, size: 16),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    // Motivational text for mobile
                    const Center(
                      child: Column(
                        children: [
                          Text(
                            'Safe Drivers • Stronger Women • Better Tomorrows',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFF386B5A),
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                            ),
                          ),
                          SizedBox(height: 4),
                          SizedBox(
                            width: 140,
                            child: Divider(
                              color: Color(0xFF386B5A),
                              thickness: 1.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Left Image
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: SizedBox(
                        width: 300,
                        height: 220,
                        child: Image.asset(
                          'assets/images/cultus.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(width: 28),
                    // Middle Text Content
                    Expanded(
                      flex: 6,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'YOUR JOURNEY MATTERS',
                            style: TextStyle(
                              color: Color(0xFF4A6B6C),
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                              letterSpacing: 2,
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Drive Your Future',
                            style: TextStyle(
                              color: Color(0xFF0F3854),
                              fontWeight: FontWeight.bold,
                              fontSize: 32,
                            ),
                          ),
                          const SizedBox(height: 12),
                          const Text(
                            'Join Parwaaz Driving Institute and get the skills, confidence and support you need to be a safe and independent driver.',
                            style: TextStyle(
                              color: Color(0xFF556B7A),
                              fontSize: 15,
                              height: 1.5,
                            ),
                          ),
                          const SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: () => _onBookLesson(context),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF0F3854),
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 26,
                                vertical: 15,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24),
                              ),
                              elevation: 0,
                            ),
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'Book Your Lesson',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15,
                                  ),
                                ),
                                SizedBox(width: 8),
                                Icon(Icons.arrow_forward, size: 18),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 24),
                    // Right Handwritten Motivational Quote
                    Expanded(
                      flex: 4,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Safe Drivers',
                            style: TextStyle(
                              color: Color(0xFF386B5A),
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.w500,
                              fontSize: 26,
                              height: 1.3,
                            ),
                          ),
                          const Text(
                            'Stronger Women',
                            style: TextStyle(
                              color: Color(0xFF386B5A),
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.w500,
                              fontSize: 26,
                              height: 1.3,
                            ),
                          ),
                          const Text(
                            'Better Tomorrows',
                            style: TextStyle(
                              color: Color(0xFF386B5A),
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.w500,
                              fontSize: 26,
                              height: 1.3,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Container(
                            height: 2,
                            width: 160,
                            color: const Color(0xFF386B5A),
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
