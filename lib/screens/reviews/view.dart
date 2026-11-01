import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../about/view.dart';
import '../courses/view.dart';
import '../home/view.dart';
import 'controller.dart';

class ReviewsView extends StatefulWidget {
  const ReviewsView({super.key});

  @override
  State<ReviewsView> createState() => _ReviewsViewState();
}

class _ReviewsViewState extends State<ReviewsView> {
  final ReviewsController controller = Get.put(ReviewsController());
  final int _selectedIndex = 3; // Reviews is index 3

  void _onHomeTap() {
    Get.offAll(() => const Home());
  }

  void _onCoursesTap() {
    Get.offAll(() => const CoursesView());
  }

  void _onAboutTap() {
    Get.offAll(() => const AboutView());
  }

  void _onReviewsTap() {
    // Already on Reviews
  }

  void _onContactTap() {
    _onWhatsAppTap();
  }

  Future<void> _onWhatsAppTap() async {
    final Uri whatsappUrl = Uri.parse("https://wa.me/923234248524");
    await launchUrl(whatsappUrl, mode: LaunchMode.externalApplication);
  }

  void _showWriteReviewDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Text(
            'Write a Review',
            style: TextStyle(
              color: Color(0xFF0F3854),
              fontWeight: FontWeight.bold,
            ),
          ),
          content: SingleChildScrollView(
            child: Form(
              key: controller.formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Your Full Name *',
                    style: TextStyle(
                      color: Color(0xFF0F3854),
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 6),
                  TextFormField(
                    controller: controller.nameController,
                    decoration: InputDecoration(
                      hintText: 'e.g. Ayesha Khan',
                      hintStyle: const TextStyle(
                          color: Color(0xFF94A3B8), fontSize: 14),
                      filled: true,
                      fillColor: const Color(0xFFF9FBFB),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            const BorderSide(color: Color(0xFFE2ECE9)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            const BorderSide(color: Color(0xFFE2ECE9)),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter your name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Your Rating *',
                    style: TextStyle(
                      color: Color(0xFF0F3854),
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Obx(
                    () => Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: List.generate(5, (index) {
                        final starValue = index + 1.0;
                        return InkWell(
                          onTap: () {
                            controller.selectedRating.value = starValue;
                          },
                          borderRadius: BorderRadius.circular(20),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 4.0, vertical: 4.0),
                            child: Icon(
                              starValue <= controller.selectedRating.value
                                  ? Icons.star_rounded
                                  : Icons.star_outline_rounded,
                              color: const Color(0xFFFFB800),
                              size: 30,
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Your Review / Feedback *',
                    style: TextStyle(
                      color: Color(0xFF0F3854),
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 6),
                  TextFormField(
                    controller: controller.commentController,
                    maxLines: 4,
                    decoration: InputDecoration(
                      hintText: 'Share your experience learning to drive...',
                      hintStyle: const TextStyle(
                          color: Color(0xFF94A3B8), fontSize: 14),
                      filled: true,
                      fillColor: const Color(0xFFF9FBFB),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            const BorderSide(color: Color(0xFFE2ECE9)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            const BorderSide(color: Color(0xFFE2ECE9)),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter your feedback comment';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () => controller.submitReview(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0F3854),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text('Submit Review'),
            ),
          ],
        );
      },
    );
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
                    onPressed: _onReviewsTap,
                    child: Text(
                      'Reviews',
                      style: TextStyle(
                        color:
                            _selectedIndex == 3 ? activeColor : inactiveColor,
                        fontWeight: _selectedIndex == 3
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  TextButton(
                    onPressed: _onContactTap,
                    child: const Text(
                      'Contact Us',
                      style: TextStyle(
                        color: inactiveColor,
                        fontWeight: FontWeight.normal,
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
                  case 'Reviews':
                    _onReviewsTap();
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
                    ),
                  ),
                ),
                PopupMenuItem(
                  value: 'Courses',
                  child: Text(
                    'Courses',
                    style: TextStyle(
                      color: _selectedIndex == 1 ? activeColor : Colors.black,
                    ),
                  ),
                ),
                PopupMenuItem(
                  value: 'About Us',
                  child: Text(
                    'About Us',
                    style: TextStyle(
                      color: _selectedIndex == 2 ? activeColor : Colors.black,
                    ),
                  ),
                ),
                PopupMenuItem(
                  value: 'Reviews',
                  child: Text(
                    'Reviews',
                    style: TextStyle(
                      color: _selectedIndex == 3 ? activeColor : Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const PopupMenuItem(
                  value: 'Contact Us',
                  child: Text('Contact Us'),
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
            // Rating Header Summary
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
                  child: isMobile
                      ? Column(
                          children: [
                            _buildRatingSummary(context),
                            const SizedBox(height: 24),
                            ElevatedButton.icon(
                              onPressed: () => _showWriteReviewDialog(context),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF0F3854),
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 24, vertical: 14),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(24),
                                ),
                              ),
                              icon: const Icon(Icons.rate_review_outlined,
                                  size: 20),
                              label: const Text(
                                'Write a Review',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ],
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(child: _buildRatingSummary(context)),
                            ElevatedButton.icon(
                              onPressed: () => _showWriteReviewDialog(context),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF0F3854),
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 28, vertical: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(24),
                                ),
                                elevation: 0,
                              ),
                              icon: const Icon(Icons.rate_review_outlined,
                                  size: 20),
                              label: const Text(
                                'Write a Review',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ],
                        ),
                ),
              ),
            ),

            // Reviews List Section
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 20 : 40,
                vertical: 36,
              ),
              child: Center(
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 1000),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Obx(
                        () => Text(
                          'Client Reviews (${controller.totalReviews})',
                          style: const TextStyle(
                            color: Color(0xFF0F3854),
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),

                      // List of Reviews
                      Obx(
                        () => Column(
                          children: controller.reviewsList
                              .map(
                                (review) => Padding(
                                  padding: const EdgeInsets.only(bottom: 16.0),
                                  child: _buildReviewCard(review),
                                ),
                              )
                              .toList(),
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

  Widget _buildRatingSummary(BuildContext context) {
    return Obx(() {
      final avg = controller.averageRating;
      final total = controller.totalReviews;

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'STUDENT REVIEWS & RATINGS',
            style: TextStyle(
              color: Color(0xFF4A6B6C),
              fontWeight: FontWeight.w600,
              fontSize: 12,
              letterSpacing: 2,
            ),
          ),
          const SizedBox(height: 10),
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 12,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text(
                    avg.toStringAsFixed(1),
                    style: const TextStyle(
                      color: Color(0xFF0F3854),
                      fontWeight: FontWeight.bold,
                      fontSize: 48,
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    '/ 5.0',
                    style: TextStyle(
                      color: Color(0xFF64748B),
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(5, (index) {
                  return Icon(
                    index < avg.floor()
                        ? Icons.star_rounded
                        : (index < avg
                            ? Icons.star_half_rounded
                            : Icons.star_outline_rounded),
                    color: const Color(0xFFFFB800),
                    size: 26,
                  );
                }),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            'Based on $total verified student ratings in Vehari',
            style: const TextStyle(
              color: Color(0xFF556B7A),
              fontSize: 14,
            ),
          ),
        ],
      );
    });
  }

  Widget _buildReviewCard(ReviewModel review) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2ECE9)),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.02),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: const Color(0xFF0F3854),
                    child: Text(
                      review.name.isNotEmpty ? review.name[0].toUpperCase() : 'U',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        review.name,
                        style: const TextStyle(
                          color: Color(0xFF0F3854),
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Row(
                        children: List.generate(5, (index) {
                          return Icon(
                            index < review.rating.floor()
                                ? Icons.star_rounded
                                : (index < review.rating ? Icons.star_half_rounded : Icons.star_outline_rounded),
                            color: const Color(0xFFFFB800),
                            size: 16,
                          );
                        }),
                      ),
                    ],
                  ),
                ],
              ),
              Text(
                review.date,
                style: const TextStyle(
                  color: Color(0xFF94A3B8),
                  fontSize: 12,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Text(
            review.comment,
            style: const TextStyle(
              color: Color(0xFF334A52),
              fontSize: 14,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
