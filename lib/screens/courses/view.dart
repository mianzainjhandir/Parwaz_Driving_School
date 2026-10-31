import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../about/view.dart';
import '../home/view.dart';

class CoursesView extends StatefulWidget {
  const CoursesView({super.key});

  @override
  State<CoursesView> createState() => _CoursesViewState();
}

class _CoursesViewState extends State<CoursesView> {
  final int _selectedIndex = 1; // Courses is index 1

  void _onHomeTap() {
    Get.offAll(() => const Home());
  }

  void _onCoursesTap() {
    // Already on Courses
  }

  void _onAboutTap() {
    Get.offAll(() => const AboutView());
  }

  void _onContactTap() {
    _onWhatsAppTap();
  }

  Future<void> _onWhatsAppTap({String? courseName, String? price}) async {
    final String message = courseName != null
        ? "Hello Parwaaz Driving Institute, I am interested in enrolling in the '$courseName' (${price ?? ''})."
        : "Hello Parwaaz Driving Institute, I want to inquire about your driving courses.";
    final Uri whatsappUrl = Uri.parse(
        "https://wa.me/923234248524?text=${Uri.encodeComponent(message)}");
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
            onPressed: () => _onWhatsAppTap(),
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
            // Header Section
            Container(
              width: double.infinity,
              color: const Color(0xFFF8FAF9),
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 20 : 40,
                vertical: isMobile ? 24 : 40,
              ),
              child: Center(
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 1000),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Our Driving Courses',
                        style: TextStyle(
                          color: Color(0xFF0F3854),
                          fontWeight: FontWeight.bold,
                          fontSize: 34,
                        ),
                      ),
                      const SizedBox(height: 6),
                      const Text(
                        'Choose the course that fits your needs.',
                        style: TextStyle(
                          color: Color(0xFF556B7A),
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Courses Grid
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 16 : 40,
                vertical: 30,
              ),
              child: Center(
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 1040),
                  child: Wrap(
                    spacing: 24,
                    runSpacing: 24,
                    alignment: WrapAlignment.center,
                    children: [
                      _buildGridCourseCard(
                        isMobile: isMobile,
                        imagePath: 'assets/images/img_2.png',
                        title: 'Beginner Driving',
                        duration: '10–15 Hours',
                        price: 'PKR 12,000',
                        onTap: () => _onWhatsAppTap(
                          courseName: 'Beginner Driving',
                          price: 'PKR 12,000',
                        ),
                      ),
                      _buildGridCourseCard(
                        isMobile: isMobile,
                        imagePath: 'assets/images/guide.png',
                        title: 'Road Practice',
                        duration: '10–12 Hours',
                        price: 'PKR 15,000',
                        onTap: () => _onWhatsAppTap(
                          courseName: 'Road Practice',
                          price: 'PKR 15,000',
                        ),
                      ),
                      _buildGridCourseCard(
                        isMobile: isMobile,
                        imagePath: 'assets/images/img_2.png',
                        title: 'Refresher Course',
                        duration: '6–8 Hours',
                        price: 'PKR 9,000',
                        onTap: () => _onWhatsAppTap(
                          courseName: 'Refresher Course',
                          price: 'PKR 9,000',
                        ),
                      ),
                      _buildGridCourseCard(
                        isMobile: isMobile,
                        imagePath: 'assets/images/guide.png',
                        title: 'Advanced Driving',
                        duration: '12–15 Hours',
                        price: 'PKR 18,000',
                        onTap: () => _onWhatsAppTap(
                          courseName: 'Advanced Driving',
                          price: 'PKR 18,000',
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

  Widget _buildGridCourseCard({
    required bool isMobile,
    required String imagePath,
    required String title,
    required String duration,
    required String price,
    required VoidCallback onTap,
  }) {
    return Container(
      width: isMobile ? double.infinity : 480,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2ECE9)),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.03),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top Image
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            child: AspectRatio(
              aspectRatio: 16 / 9,
              child: Image.asset(
                imagePath,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                Text(
                  title,
                  style: const TextStyle(
                    color: Color(0xFF0F3854),
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                ),
                const SizedBox(height: 8),
                // Duration with Clock Icon
                Row(
                  children: [
                    const Icon(
                      Icons.access_time_rounded,
                      size: 18,
                      color: Color(0xFF627B77),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      duration,
                      style: const TextStyle(
                        color: Color(0xFF627B77),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                // Price Pill Container / Button
                InkWell(
                  onTap: onTap,
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                    decoration: BoxDecoration(
                      color: const Color(0xFFECF2EF),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          price,
                          style: const TextStyle(
                            color: Color(0xFF0F3854),
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const Row(
                          children: [
                            Text(
                              'Inquire / Register',
                              style: TextStyle(
                                color: Color(0xFF2A4D45),
                                fontWeight: FontWeight.w600,
                                fontSize: 13,
                              ),
                            ),
                            SizedBox(width: 6),
                            FaIcon(
                              FontAwesomeIcons.whatsapp,
                              size: 16,
                              color: Color(0xFF25D366),
                            ),
                          ],
                        ),
                      ],
                    ),
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
