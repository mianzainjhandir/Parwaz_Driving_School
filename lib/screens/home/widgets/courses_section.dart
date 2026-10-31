import 'dart:async';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../courses/view.dart';

class HomeCoursesSection extends StatefulWidget {
  const HomeCoursesSection({super.key});

  @override
  State<HomeCoursesSection> createState() => _HomeCoursesSectionState();
}

class _HomeCoursesSectionState extends State<HomeCoursesSection> {
  final ScrollController _scrollController = ScrollController();
  Timer? _autoScrollTimer;

  @override
  void initState() {
    super.initState();
    _startAutoScroll();
  }

  void _startAutoScroll() {
    _autoScrollTimer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (_scrollController.hasClients) {
        final double maxScroll = _scrollController.position.maxScrollExtent;
        final double currentScroll = _scrollController.offset;
        final double targetScroll = currentScroll + 320.0;

        if (currentScroll >= maxScroll - 10) {
          _scrollController.animateTo(
            0,
            duration: const Duration(milliseconds: 800),
            curve: Curves.easeOut,
          );
        } else {
          _scrollController.animateTo(
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
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _onWhatsAppTap(String courseName, String price) async {
    final String message =
        "Hello Parwaaz Driving Institute, I am interested in enrolling in the '$courseName' ($price).";
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

  void _onViewAllCourses() {
    Get.to(() => const CoursesView());
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isMobile = screenWidth < 700;

    final List<_CourseItem> courses = [
      _CourseItem(
        imagePath: 'assets/images/bignear.png',
        title: 'Beginner Driving',
        description: 'Learn the basics and build confidence on the road.',
        duration: '10–15 Hours',
        price: 'PKR 12,000',
      ),
      _CourseItem(
        imagePath: 'assets/images/road.png',
        title: 'Road Practice',
        description: 'Real road experience with expert guidance.',
        duration: '10–12 Hours',
        price: 'PKR 12,000',
      ),
      _CourseItem(
        imagePath: 'assets/images/refresher.png',
        title: 'Refresher Course',
        description: 'Improve your skills and build confidence.',
        duration: '6–8 Hours',
        price: 'PKR 9,000',
      ),
      _CourseItem(
        imagePath: 'assets/images/advance.png',
        title: 'Advanced Driving',
        description: 'For experienced drivers and special needs.',
        duration: '12–15 Hours',
        price: 'PKR 18,000',
      ),
    ];

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 16 : 40,
        vertical: 24,
      ),
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 1100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Our Courses',
                          style: TextStyle(
                            color: Color(0xFF0F3854),
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          'Choose the right course for your journey.',
                          style: TextStyle(
                            color: Color(0xFF556B7A),
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: _onViewAllCourses,
                    borderRadius: BorderRadius.circular(6),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 4.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'View All Courses',
                            style: TextStyle(
                              color: Color(0xFF0F3854),
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                          SizedBox(width: 4),
                          Icon(
                            Icons.arrow_forward,
                            size: 16,
                            color: Color(0xFF0F3854),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // Horizontal Scrollable Cards
              SizedBox(
                height: 350,
                child: ListView.builder(
                  controller: _scrollController,
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  itemCount: courses.length,
                  itemBuilder: (context, index) {
                    final course = courses[index];
                    return Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: _buildCourseCard(course),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCourseCard(_CourseItem course) {
    return Container(
      width: 300,
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
                course.imagePath,
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
                  course.title,
                  style: const TextStyle(
                    color: Color(0xFF0F3854),
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  course.description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Color(0xFF627B77),
                    fontSize: 12.5,
                    height: 1.3,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    const Icon(
                      Icons.access_time_rounded,
                      size: 16,
                      color: Color(0xFF556B7A),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'Duration ${course.duration}',
                      style: const TextStyle(
                        color: Color(0xFF556B7A),
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                InkWell(
                  onTap: () => _onWhatsAppTap(course.title, course.price),
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
                          course.price,
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
}

class _CourseItem {
  final String imagePath;
  final String title;
  final String description;
  final String duration;
  final String price;

  _CourseItem({
    required this.imagePath,
    required this.title,
    required this.description,
    required this.duration,
    required this.price,
  });
}
