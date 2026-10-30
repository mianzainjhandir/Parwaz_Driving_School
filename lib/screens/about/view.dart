import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutView extends StatelessWidget {
  const AboutView({super.key});

  Future<void> _onWhatsAppTap(BuildContext context) async {
    final Uri whatsappUrl = Uri.parse("https://wa.me/923234248524");
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
    final bool isMobile = screenWidth < 700;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leadingWidth: 120,
        leading: Padding(
          padding: const EdgeInsets.only(left: 12, top: 4, bottom: 4),
          child: Image.asset(
            'assets/images/img_1.png',
            fit: BoxFit.contain,
          ),
        ),
        title: const Text(
          'About Us',
          style: TextStyle(
            color: Color(0xFF0F3854),
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            tooltip: 'WhatsApp',
            onPressed: () => _onWhatsAppTap(context),
            icon: const FaIcon(
              FontAwesomeIcons.whatsapp,
              color: Color(0xFF25D366),
              size: 27,
            ),
          ),
          const SizedBox(width: 12),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Hero Header
            Container(
              width: double.infinity,
              color: const Color(0xFFF8FAF9),
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 20 : 40,
                vertical: isMobile ? 30 : 50,
              ),
              child: Center(
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 1000),
                  child: Column(
                    children: [
                      const Text(
                        'ABOUT US',
                        style: TextStyle(
                          color: Color(0xFF4A6B6C),
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                          letterSpacing: 2,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Empowering Women Through Safe & Professional Driving Lessons',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: const Color(0xFF0F3854),
                          fontWeight: FontWeight.bold,
                          fontSize: isMobile ? 26 : 38,
                          height: 1.2,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Parwaaz Driving Institute in Vehari is dedicated to providing high-quality, professional, and respectful driving education specifically tailored for women.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: const Color(0xFF556B7A),
                          fontSize: isMobile ? 14 : 16,
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Main Info Cards
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 20 : 40,
                vertical: 30,
              ),
              child: Center(
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 1000),
                  child: Column(
                    children: [
                      _buildInfoCard(
                        icon: Icons.groups_outlined,
                        title: 'Certified Female Instructors',
                        description:
                            'Our team consists of highly experienced, patient, and certified female instructors who create a comfortable and encouraging environment for beginners.',
                        isMobile: isMobile,
                      ),
                      const SizedBox(height: 16),
                      _buildInfoCard(
                        icon: Icons.security_outlined,
                        title: 'Safety First & Modern Vehicles',
                        description:
                            'We use modern, well-maintained dual-control vehicles to ensure complete safety and confidence throughout your learning journey.',
                        isMobile: isMobile,
                      ),
                      const SizedBox(height: 16),
                      _buildInfoCard(
                        icon: Icons.schedule_outlined,
                        title: 'Flexible Class Timings',
                        description:
                            'We offer convenient morning, afternoon, and evening slots designed to easily fit into your daily personal or professional schedule.',
                        isMobile: isMobile,
                      ),
                      const SizedBox(height: 30),

                      // Call to action card
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: const Color(0xFF0F3854),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: const EdgeInsets.all(28),
                        child: Column(
                          children: [
                            const Text(
                              'Ready to Start Driving with Confidence?',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 22,
                              ),
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              'Contact us on WhatsApp to book your lesson or inquire about courses.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 20),
                            ElevatedButton.icon(
                              onPressed: () => _onWhatsAppTap(context),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF25D366),
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 24,
                                  vertical: 14,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(24),
                                ),
                              ),
                              icon: const FaIcon(
                                FontAwesomeIcons.whatsapp,
                                size: 20,
                              ),
                              label: const Text(
                                'Chat on WhatsApp',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard({
    required IconData icon,
    required String title,
    required String description,
    required bool isMobile,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAF9),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2ECE9)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFE6F2EE),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: const Color(0xFF0F3854),
              size: 28,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Color(0xFF0F3854),
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  description,
                  style: const TextStyle(
                    color: Color(0xFF556B7A),
                    fontSize: 14,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
