import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../reviews/controller.dart';
import '../../reviews/view.dart';

class HomeReviewsSection extends StatefulWidget {
  const HomeReviewsSection({super.key});

  @override
  State<HomeReviewsSection> createState() => _HomeReviewsSectionState();
}

class _HomeReviewsSectionState extends State<HomeReviewsSection> {
  final ScrollController _scrollController = ScrollController();
  Timer? _autoScrollTimer;

  late final ReviewsController reviewsController;

  @override
  void initState() {
    super.initState();
    if (Get.isRegistered<ReviewsController>()) {
      reviewsController = Get.find<ReviewsController>();
    } else {
      reviewsController = Get.put(ReviewsController());
    }
    _startAutoScroll();
  }

  void _startAutoScroll() {
    _autoScrollTimer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (_scrollController.hasClients) {
        final double maxScroll = _scrollController.position.maxScrollExtent;
        final double currentScroll = _scrollController.offset;
        final double targetScroll = currentScroll + 340.0;

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

  void _onViewAllReviews() {
    Get.to(() => const ReviewsView());
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isMobile = screenWidth < 700;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 16 : 40,
        vertical: 28,
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
                          'What Our Students Say',
                          style: TextStyle(
                            color: Color(0xFF0F3854),
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Obx(
                          () => Text(
                            '★ ${reviewsController.averageRating.toStringAsFixed(1)} / 5.0 Rating based on ${reviewsController.totalReviews} student reviews in Vehari.',
                            style: const TextStyle(
                              color: Color(0xFF556B7A),
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: _onViewAllReviews,
                    borderRadius: BorderRadius.circular(6),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 4.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'View All Reviews',
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
                height: 280,
                child: Obx(() {
                  final reviews = reviewsController.reviewsList;
                  return ListView.builder(
                    controller: _scrollController,
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    itemCount: reviews.length,
                    itemBuilder: (context, index) {
                      final review = reviews[index];
                      // Alternate card styles like screenshot
                      final bool isHighlighted = (index % 2 == 1);
                      return Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: _buildReviewCard(
                          review: review,
                          isHighlighted: isHighlighted,
                        ),
                      );
                    },
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildReviewCard({
    required ReviewModel review,
    required bool isHighlighted,
  }) {
    final Color bgColor =
        isHighlighted ? const Color(0xFF2A4D45) : const Color(0xFFF8FAF9);
    final Color textColor =
        isHighlighted ? Colors.white : const Color(0xFF0F3854);
    final Color subTextColor =
        isHighlighted ? Colors.white70 : const Color(0xFF556B7A);
    final Color commentColor =
        isHighlighted ? const Color(0xFFEBF3F0) : const Color(0xFF334A52);

    final bool hasPhoto =
        review.photoUrl != null && review.photoUrl!.isNotEmpty;

    return InkWell(
      onTap: _onViewAllReviews,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        width: 330,
        padding: const EdgeInsets.all(22),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isHighlighted
                ? Colors.transparent
                : const Color(0xFFE2ECE9),
          ),
          boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.03),
              blurRadius: 12,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top Row: Avatar + Name + Rating
                Row(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundColor: isHighlighted
                          ? Colors.white
                          : const Color(0xFF0F3854),
                      backgroundImage:
                          hasPhoto ? NetworkImage(review.photoUrl!) : null,
                      onBackgroundImageError:
                          hasPhoto ? (_, _) {} : null,
                      child: !hasPhoto
                          ? Text(
                              review.name.isNotEmpty
                                  ? review.name[0].toUpperCase()
                                  : 'S',
                              style: TextStyle(
                                color: isHighlighted
                                    ? const Color(0xFF2A4D45)
                                    : Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          : null,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            review.name,
                            style: TextStyle(
                              color: textColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Row(
                            children: List.generate(5, (starIdx) {
                              return Icon(
                                starIdx < review.rating.floor()
                                    ? Icons.star_rounded
                                    : (starIdx < review.rating
                                        ? Icons.star_half_rounded
                                        : Icons.star_outline_rounded),
                                color: const Color(0xFFFFB800),
                                size: 15,
                              );
                            }),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                // Comment text quote
                Text(
                  '"${review.comment}"',
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: commentColor,
                    fontSize: 13.5,
                    height: 1.45,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
            // Bottom Action
            Row(
              children: [
                Text(
                  'Learn more',
                  style: TextStyle(
                    color: subTextColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(width: 6),
                Icon(
                  Icons.arrow_forward,
                  size: 15,
                  color: subTextColor,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
