import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../about/view.dart';
import '../../book_lesson/view.dart';
import '../../courses/view.dart';
import '../../reviews/view.dart';
import '../view.dart';

class BottomFooterSection extends StatelessWidget {
  const BottomFooterSection({super.key});

  Future<void> _openWhatsApp() async {
    final Uri whatsappUrl = Uri.parse("https://wa.me/923234248524");
    await launchUrl(whatsappUrl, mode: LaunchMode.externalApplication);
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isMobile = screenWidth < 800;

    return Container(
      width: double.infinity,
      constraints: BoxConstraints(
        minHeight: screenHeight * 0.45,
      ),
      decoration: const BoxDecoration(
        color: Color(0xFF2E1065), // Deep Royal Purple Card
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 50,
        vertical: isMobile ? 30 : 44,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Center(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 1100),
              child: isMobile
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildBrandInfo(),
                        const SizedBox(height: 24),
                        const Divider(color: Colors.white24),
                        const SizedBox(height: 20),
                        _buildQuickLinks(),
                        const SizedBox(height: 24),
                        const Divider(color: Colors.white24),
                        const SizedBox(height: 20),
                        _buildContactInfo(context),
                      ],
                    )
                  : Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Left Brand Info
                        Expanded(flex: 5, child: _buildBrandInfo()),
                        const SizedBox(width: 40),
                        // Middle Quick Links
                        Expanded(flex: 3, child: _buildQuickLinks()),
                        const SizedBox(width: 40),
                        // Right Contact Details
                        Expanded(flex: 4, child: _buildContactInfo(context)),
                      ],
                    ),
            ),
          ),
          const SizedBox(height: 30),
          // Bottom Copyright Notice
          Center(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 1100),
              child: Column(
                children: [
                  const Divider(color: Colors.white24),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Flexible(
                        child: Text(
                          '© 2026 Parwaaz Driving Institute. All rights reserved.',
                          style: TextStyle(
                            color: Color(0x99FFFFFF),
                            fontSize: 12.5,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          const Text(
                            'Vehari, Punjab',
                            style: TextStyle(
                              color: Color(0xB3FFFFFF),
                              fontSize: 12.5,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(width: 8),
                          IconButton(
                            icon: const FaIcon(
                              FontAwesomeIcons.whatsapp,
                              color: Color(0xFF25D366),
                              size: 20,
                            ),
                            onPressed: _openWhatsApp,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBrandInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color.fromRGBO(255, 255, 255, 0.15),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Image.asset(
                'assets/images/img_1.png',
                height: 32,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(width: 12),
            const Flexible(
              child: Text(
                'Parwaaz Driving Institute',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        const Text(
          'Empowering women in Vehari through safe, respectful, and professional driving education taught by certified female instructors.',
          style: TextStyle(
            color: Color(0xB3FFFFFF),
            fontSize: 14,
            height: 1.5,
          ),
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: const [
            _FeaturePill(label: '👩‍🏫 Female Instructors'),
            _FeaturePill(label: '🚘 Dual-Control Cars'),
            _FeaturePill(label: '🗓️ 7 Days Training'),
            _FeaturePill(label: '🏡 Doorstep Pickup'),
          ],
        ),
      ],
    );
  }

  Widget _buildQuickLinks() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Quick Navigation',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 14),
        _buildFooterLink('Home', () => Get.offAll(() => const Home())),
        _buildFooterLink(
            'Courses (7 Days)', () => Get.to(() => const CoursesView())),
        _buildFooterLink('About Us', () => Get.to(() => const AboutView())),
        _buildFooterLink(
            'Student Reviews', () => Get.to(() => const ReviewsView())),
        _buildFooterLink(
            'Book a Lesson', () => Get.to(() => const BookLessonView())),
      ],
    );
  }

  Widget _buildFooterLink(String label, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: InkWell(
        onTap: onTap,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.chevron_right_rounded,
                color: Color(0x99FFFFFF), size: 18),
            const SizedBox(width: 4),
            Text(
              label,
              style: const TextStyle(
                color: Color(0xB3FFFFFF),
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactInfo(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Contact & Timings',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 14),
        const Row(
          children: [
            Icon(Icons.location_on_outlined, color: Color(0xB3FFFFFF), size: 18),
            SizedBox(width: 8),
            Expanded(
              child: Text(
                'Main City Area, Vehari, Punjab, Pakistan',
                style: TextStyle(color: Color(0xCCFFFFFF), fontSize: 13.5),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        const Row(
          children: [
            Icon(Icons.access_time_outlined, color: Color(0xB3FFFFFF), size: 18),
            SizedBox(width: 8),
            Text(
              'Training Hours: 9:00 AM - 5:00 PM',
              style: TextStyle(color: Color(0xCCFFFFFF), fontSize: 13.5),
            ),
          ],
        ),
        const SizedBox(height: 10),
        const Row(
          children: [
            Icon(Icons.phone_outlined, color: Color(0xB3FFFFFF), size: 18),
            SizedBox(width: 8),
            Text(
              '+92 323 4248524',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ],
        ),
        const SizedBox(height: 18),
        ElevatedButton.icon(
          onPressed: _openWhatsApp,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF25D366),
            foregroundColor: Colors.white,
            padding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            elevation: 0,
          ),
          icon: const FaIcon(FontAwesomeIcons.whatsapp, size: 18),
          label: const Text(
            'Chat on WhatsApp',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
        ),
      ],
    );
  }
}

class _FeaturePill extends StatelessWidget {
  final String label;
  const _FeaturePill({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(255, 255, 255, 0.12),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: Color(0xB3FFFFFF),
          fontSize: 11.5,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
