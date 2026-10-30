import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../home/view.dart';

class AboutView extends StatefulWidget {
  const AboutView({super.key});

  @override
  State<AboutView> createState() => _AboutViewState();
}

class _AboutViewState extends State<AboutView> {
  final int _selectedIndex = 2; // About Us is index 2

  void _onHomeTap() {
    Get.offAll(() => const Home());
  }

  void _onCoursesTap() {
    Get.offAll(() => const Home());
  }

  void _onAboutTap() {
    // Already on About Us
  }

  void _onContactTap() {
    _onWhatsAppTap();
  }

  Future<void> _onWhatsAppTap() async {
    final Uri whatsappUrl = Uri.parse("https://wa.me/923234248524");
    if (!await launchUrl(whatsappUrl, mode: LaunchMode.externalApplication)) {
      if (mounted) {
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
    const Color activeColor = Colors.blue;
    const Color inactiveColor = Colors.black87;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leadingWidth: 120,
        leading: Padding(
          padding: const EdgeInsets.only(left: 12, top: 4, bottom: 4),
          child: GestureDetector(
            onTap: _onHomeTap,
            child: Image.asset(
              'assets/images/img_1.png',
              fit: BoxFit.contain,
            ),
          ),
        ),
        centerTitle: !isMobile,
        title: isMobile
            ? null
            : Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextButton(
                    onPressed: _onHomeTap,
                    child: Text(
                      'Home',
                      style: TextStyle(
                        color: _selectedIndex == 0 ? activeColor : inactiveColor,
                        fontWeight: _selectedIndex == 0 ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  TextButton(
                    onPressed: _onCoursesTap,
                    child: Text(
                      'Courses',
                      style: TextStyle(
                        color: _selectedIndex == 1 ? activeColor : inactiveColor,
                        fontWeight: _selectedIndex == 1 ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  TextButton(
                    onPressed: _onAboutTap,
                    child: Text(
                      'About Us',
                      style: TextStyle(
                        color: _selectedIndex == 2 ? activeColor : inactiveColor,
                        fontWeight: _selectedIndex == 2 ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  TextButton(
                    onPressed: _onContactTap,
                    child: Text(
                      'Contact Us',
                      style: TextStyle(
                        color: _selectedIndex == 3 ? activeColor : inactiveColor,
                        fontWeight: _selectedIndex == 3 ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                  ),
                ],
              ),
        actions: [
          IconButton(
            tooltip: 'WhatsApp',
            onPressed: _onWhatsAppTap,
            icon: const FaIcon(
              FontAwesomeIcons.whatsapp,
              color: Color(0xFF25D366),
              size: 27,
            ),
          ),

          if (isMobile)
            PopupMenuButton<String>(
              icon: const Icon(Icons.menu, color: Colors.black),
              onSelected: (value) {
                switch (value) {
                  case 'Home':
                    _onHomeTap();
                    break;
                  case 'Courses':
                    _onCoursesTap();
                    break;
                  case 'About Us':
                    _onAboutTap();
                    break;
                  case 'Contact Us':
                    _onContactTap();
                    break;
                }
              },
              itemBuilder: (context) => [
                PopupMenuItem(
                  value: 'Home',
                  child: Text(
                    'Home',
                    style: TextStyle(
                      color: _selectedIndex == 0 ? activeColor : Colors.black,
                      fontWeight: _selectedIndex == 0 ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                ),
                PopupMenuItem(
                  value: 'Courses',
                  child: Text(
                    'Courses',
                    style: TextStyle(
                      color: _selectedIndex == 1 ? activeColor : Colors.black,
                      fontWeight: _selectedIndex == 1 ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                ),
                PopupMenuItem(
                  value: 'About Us',
                  child: Text(
                    'About Us',
                    style: TextStyle(
                      color: _selectedIndex == 2 ? activeColor : Colors.black,
                      fontWeight: _selectedIndex == 2 ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                ),
                PopupMenuItem(
                  value: 'Contact Us',
                  child: Text(
                    'Contact Us',
                    style: TextStyle(
                      color: _selectedIndex == 3 ? activeColor : Colors.black,
                      fontWeight: _selectedIndex == 3 ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                ),
              ],
            )
          else
            const SizedBox(width: 16),
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
                      ),
                      const SizedBox(height: 16),
                      _buildInfoCard(
                        icon: Icons.security_outlined,
                        title: 'Safety First & Modern Vehicles',
                        description:
                            'We use modern, well-maintained dual-control vehicles to ensure complete safety and confidence throughout your learning journey.',
                      ),
                      const SizedBox(height: 16),
                      _buildInfoCard(
                        icon: Icons.schedule_outlined,
                        title: 'Flexible Class Timings',
                        description:
                            'We offer convenient morning, afternoon, and evening slots designed to easily fit into your daily personal or professional schedule.',
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
                              onPressed: _onWhatsAppTap,
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
