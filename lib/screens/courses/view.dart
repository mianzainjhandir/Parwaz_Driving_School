import 'dart:async';
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
  final ScrollController _horizontalScrollController = ScrollController();
  Timer? _autoScrollTimer;

  @override
  void initState() {
    super.initState();
    _startAutoScroll();
  }

  void _startAutoScroll() {
    _autoScrollTimer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (_horizontalScrollController.hasClients) {
        final double maxScroll =
            _horizontalScrollController.position.maxScrollExtent;
        final double currentScroll = _horizontalScrollController.offset;
        final double targetScroll = currentScroll + 340.0;

        if (currentScroll >= maxScroll - 10) {
          _horizontalScrollController.animateTo(
            0,
            duration: const Duration(milliseconds: 800),
            curve: Curves.easeOut,
          );
        } else {
          _horizontalScrollController.animateTo(
            targetScroll > maxScroll ? maxScroll : targetScroll,
            duration: const Duration(milliseconds: 800),
            curve: Curves.easeInOut,
          );
        }
      }
    });
  }

  @override
  void dispose() {
    _autoScrollTimer?.cancel();
    _horizontalScrollController.dispose();
    super.dispose();
  }

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

    final List<_QuickCourseData> quickCourses = [
      _QuickCourseData(
        imagePath: 'assets/images/bignear.png',
        title: 'Beginner Driving',
        duration: '10–15 Hours',
        price: 'PKR 12,000',
      ),
      _QuickCourseData(
        imagePath: 'assets/images/road.png',
        title: 'Road Practice',
        duration: '10–12 Hours',
        price: 'PKR 15,000',
      ),
      _QuickCourseData(
        imagePath: 'assets/images/refresher.png',
        title: 'Refresher Course',
        duration: '6–8 Hours',
        price: 'PKR 9,000',
      ),
      _QuickCourseData(
        imagePath: 'assets/images/advance.png',
        title: 'Advanced Driving',
        duration: '12–15 Hours',
        price: 'PKR 18,000',
      ),
    ];

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
                        color:
                            _selectedIndex == 0 ? activeColor : inactiveColor,
                        fontWeight: _selectedIndex == 0
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  TextButton(
                    onPressed: _onCoursesTap,
                    child: Text(
                      'Courses',
                      style: TextStyle(
                        color:
                            _selectedIndex == 1 ? activeColor : inactiveColor,
                        fontWeight: _selectedIndex == 1
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  TextButton(
                    onPressed: _onAboutTap,
                    child: Text(
                      'About Us',
                      style: TextStyle(
                        color:
                            _selectedIndex == 2 ? activeColor : inactiveColor,
                        fontWeight: _selectedIndex == 2
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  TextButton(
                    onPressed: _onContactTap,
                    child: Text(
                      'Contact Us',
                      style: TextStyle(
                        color:
                            _selectedIndex == 3 ? activeColor : inactiveColor,
                        fontWeight: _selectedIndex == 3
                            ? FontWeight.bold
                            : FontWeight.normal,
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
                      fontWeight: _selectedIndex == 0
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                  ),
                ),
                PopupMenuItem(
                  value: 'Courses',
                  child: Text(
                    'Courses',
                    style: TextStyle(
                      color: _selectedIndex == 1 ? activeColor : Colors.black,
                      fontWeight: _selectedIndex == 1
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                  ),
                ),
                PopupMenuItem(
                  value: 'About Us',
                  child: Text(
                    'About Us',
                    style: TextStyle(
                      color: _selectedIndex == 2 ? activeColor : Colors.black,
                      fontWeight: _selectedIndex == 2
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                  ),
                ),
                PopupMenuItem(
                  value: 'Contact Us',
                  child: Text(
                    'Contact Us',
                    style: TextStyle(
                      color: _selectedIndex == 3 ? activeColor : Colors.black,
                      fontWeight: _selectedIndex == 3
                          ? FontWeight.bold
                          : FontWeight.normal,
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Section
            Container(
              width: double.infinity,
              color: const Color(0xFFF8FAF9),
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 20 : 40,
                vertical: isMobile ? 24 : 36,
              ),
              child: Center(
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 1100),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Our Driving Courses',
                        style: TextStyle(
                          color: Color(0xFF0F3854),
                          fontWeight: FontWeight.bold,
                          fontSize: 32,
                        ),
                      ),
                      SizedBox(height: 6),
                      Text(
                        'Choose the course that fits your needs.',
                        style: TextStyle(
                          color: Color(0xFF556B7A),
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Horizontal Auto-Scrolling Row Section
            Center(
              child: Container(
                constraints: const BoxConstraints(maxWidth: 1100),
                height: 330,
                child: ListView.builder(
                  controller: _horizontalScrollController,
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: quickCourses.length,
                  itemBuilder: (context, index) {
                    final course = quickCourses[index];
                    return Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: _buildHorizontalCourseCard(
                        imagePath: course.imagePath,
                        title: course.title,
                        duration: course.duration,
                        price: course.price,
                        onTap: () => _onWhatsAppTap(
                          courseName: course.title,
                          price: course.price,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),

            const SizedBox(height: 40),

            // Section 2 Header: Detailed Programs
            Container(
              width: double.infinity,
              color: const Color(0xFFF8FAF9),
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 20 : 40,
                vertical: isMobile ? 24 : 36,
              ),
              child: Center(
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 1100),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'EXPLORE DETAILED PROGRAMS',
                        style: TextStyle(
                          color: Color(0xFF4A6B6C),
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                          letterSpacing: 2,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Full Course Curriculum & Features',
                        style: TextStyle(
                          color: Color(0xFF0F3854),
                          fontWeight: FontWeight.bold,
                          fontSize: 28,
                        ),
                      ),
                      SizedBox(height: 6),
                      Text(
                        'Detailed breakdown of our training courses taught by certified female instructors.',
                        style: TextStyle(
                          color: Color(0xFF556B7A),
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Detailed Courses Section (Original Detailed Cards)
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 20 : 40,
                vertical: 36,
              ),
              child: Center(
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 1100),
                  child: Column(
                    children: [
                      Wrap(
                        spacing: 24,
                        runSpacing: 24,
                        alignment: WrapAlignment.center,
                        children: [
                          _buildDetailedCourseCard(
                            isMobile: isMobile,
                            title: 'Beginner Driving Course',
                            duration: '2 to 4 Weeks',
                            badgeText: 'Most Popular',
                            badgeColor: const Color(0xFF0F3854),
                            description:
                                'Ideal for absolute beginners with no prior driving experience. Learn basic controls to confident solo driving.',
                            features: const [
                              'Basic car controls & steering practice',
                              'Gear shifting & clutch control',
                              'Traffic rules & road signs education',
                              'Parallel & reverse parking training',
                              '1-on-1 Female instructor guidance',
                            ],
                            onEnroll: () => _onWhatsAppTap(
                              courseName: 'Beginner Driving Course',
                            ),
                          ),
                          _buildDetailedCourseCard(
                            isMobile: isMobile,
                            title: 'Refresher & Confidence Course',
                            duration: '1 to 2 Weeks',
                            badgeText: 'Skill Booster',
                            badgeColor: const Color(0xFF2A4D45),
                            description:
                                'Perfect for learners who know basic driving but lack confidence on busy roads or heavy traffic areas in Vehari.',
                            features: const [
                              'Main road & city traffic driving practice',
                              'Overcoming driving fear & anxiety',
                              'Narrow street & market driving',
                              'Proper braking & hill start control',
                              'Patient & supportive female mentor',
                            ],
                            onEnroll: () => _onWhatsAppTap(
                              courseName: 'Refresher Course',
                            ),
                          ),
                          _buildDetailedCourseCard(
                            isMobile: isMobile,
                            title: 'Fast-Track / VIP Course',
                            duration: 'Flexible Schedule',
                            badgeText: 'Customized',
                            badgeColor: const Color(0xFF386B5A),
                            description:
                                'Customized fast-track course with flexible morning, afternoon, or evening slots according to your busy schedule.',
                            features: const [
                              'Flexible time slot selection',
                              'Fast-track intensive training',
                              'Comprehensive license test preparation',
                              'Pickup & drop options available',
                              'Dedicated certified female instructor',
                            ],
                            onEnroll: () => _onWhatsAppTap(
                              courseName: 'Fast-Track VIP Course',
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 40),

                      // Contact Banner
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: const Color(0xFFF1F5F4),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: const Color(0xFFD5E0DC)),
                        ),
                        padding: const EdgeInsets.all(28),
                        child: Column(
                          children: [
                            const Text(
                              'Need help choosing the right course?',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0xFF0F3854),
                                fontWeight: FontWeight.bold,
                                fontSize: 22,
                              ),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              'Send us a message on WhatsApp. Our team will guide you on course schedules, fees, and class availability.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0xFF556B7A),
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 20),
                            ElevatedButton.icon(
                              onPressed: () => _onWhatsAppTap(),
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
                                elevation: 0,
                              ),
                              icon: const FaIcon(
                                FontAwesomeIcons.whatsapp,
                                size: 20,
                              ),
                              label: const Text(
                                'Inquire on WhatsApp',
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

  Widget _buildHorizontalCourseCard({
    required String imagePath,
    required String title,
    required String duration,
    required String price,
    required VoidCallback onTap,
  }) {
    return Container(
      width: 310,
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
          // Image
          ClipRRect(
            borderRadius:
                const BorderRadius.vertical(top: Radius.circular(16)),
            child: SizedBox(
              height: 150,
              width: double.infinity,
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Color(0xFF0F3854),
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    const Icon(
                      Icons.access_time_rounded,
                      size: 16,
                      color: Color(0xFF627B77),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      duration,
                      style: const TextStyle(
                        color: Color(0xFF627B77),
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                InkWell(
                  onTap: onTap,
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    width: double.infinity,
                    padding:
                        const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
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
                            fontSize: 15,
                          ),
                        ),
                        const Row(
                          children: [
                            Text(
                              'Inquire',
                              style: TextStyle(
                                color: Color(0xFF2A4D45),
                                fontWeight: FontWeight.w600,
                                fontSize: 12,
                              ),
                            ),
                            SizedBox(width: 4),
                            FaIcon(
                              FontAwesomeIcons.whatsapp,
                              size: 14,
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

  Widget _buildDetailedCourseCard({
    required bool isMobile,
    required String title,
    required String duration,
    required String badgeText,
    required Color badgeColor,
    required String description,
    required List<String> features,
    required VoidCallback onEnroll,
  }) {
    return Container(
      width: isMobile ? double.infinity : 340,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAF9),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE2ECE9)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: badgeColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  badgeText,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Row(
                children: [
                  const Icon(
                    Icons.timer_outlined,
                    size: 16,
                    color: Color(0xFF556B7A),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    duration,
                    style: const TextStyle(
                      color: Color(0xFF556B7A),
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            title,
            style: const TextStyle(
              color: Color(0xFF0F3854),
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            description,
            style: const TextStyle(
              color: Color(0xFF556B7A),
              fontSize: 13,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 18),
          const Divider(color: Color(0xFFE2ECE9)),
          const SizedBox(height: 12),
          Column(
            children: features
                .map(
                  (feature) => Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.check_circle_outline_rounded,
                          size: 18,
                          color: Color(0xFF2A4D45),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            feature,
                            style: const TextStyle(
                              color: Color(0xFF334A52),
                              fontSize: 13,
                              height: 1.3,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
                .toList(),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: onEnroll,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0F3854),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0,
              ),
              icon: const FaIcon(
                FontAwesomeIcons.whatsapp,
                size: 18,
              ),
              label: const Text(
                'Enroll Now',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _QuickCourseData {
  final String imagePath;
  final String title;
  final String duration;
  final String price;

  _QuickCourseData({
    required this.imagePath,
    required this.title,
    required this.duration,
    required this.price,
  });
}
