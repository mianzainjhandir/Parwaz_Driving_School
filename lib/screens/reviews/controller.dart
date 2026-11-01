import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class ReviewModel {
  final String id;
  final String name;
  final double rating;
  final String comment;
  final String date;
  final String? photoUrl;
  final String? email;

  ReviewModel({
    required this.id,
    required this.name,
    required this.rating,
    required this.comment,
    required this.date,
    this.photoUrl,
    this.email,
  });
}

class ReviewsController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final commentController = TextEditingController();

  var selectedRating = 5.0.obs;

  final GoogleSignIn _googleSignIn = GoogleSignIn();
  var googleUser = Rxn<GoogleSignInAccount>();

  final RxList<ReviewModel> reviewsList = <ReviewModel>[
    ReviewModel(
      id: '1',
      name: 'Ayesha Khan',
      rating: 5.0,
      comment:
          'MashaAllah, Parwaaz Driving Institute is the best for women in Vehari! The female instructor was extremely patient and gentle. I passed my license test on the first try!',
      date: '28 Oct 2026',
    ),
    ReviewModel(
      id: '2',
      name: 'Fatima Zahra',
      rating: 5.0,
      comment:
          'Very safe and respectful learning environment. Dual control car made me feel 100% safe. Highly recommended for all sisters in Vehari!',
      date: '25 Oct 2026',
    ),
    ReviewModel(
      id: '3',
      name: 'Sana Malik',
      rating: 5.0,
      comment:
          'Refresher course took away all my driving fear on busy roads. The timing was super flexible. Thank you so much!',
      date: '20 Oct 2026',
    ),
    ReviewModel(
      id: '4',
      name: 'Maria Bibi',
      rating: 4.5,
      comment:
          'Great experience learning to drive. Female instructor explained traffic rules and parking very clearly.',
      date: '15 Oct 2026',
    ),
  ].obs;

  double get averageRating {
    if (reviewsList.isEmpty) return 0.0;
    final total = reviewsList.fold(0.0, (sum, item) => sum + item.rating);
    return total / reviewsList.length;
  }

  int get totalReviews => reviewsList.length;

  int getStarCount(int star) {
    return reviewsList.where((r) => r.rating.round() == star).length;
  }

  @override
  void onClose() {
    nameController.dispose();
    commentController.dispose();
    super.onClose();
  }

  Future<void> signInWithGoogle(BuildContext context) async {
    try {
      final account = await _googleSignIn.signIn();
      if (account != null) {
        googleUser.value = account;
        if (account.displayName != null && account.displayName!.isNotEmpty) {
          nameController.text = account.displayName!;
        }
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: const Color(0xFF0F3854),
              content: Text('Signed in as ${account.displayName ?? account.email}'),
            ),
          );
        }
      }
    } catch (error) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.redAccent,
            content: Text('Google Sign-In note: $error'),
          ),
        );
      }
    }
  }

  Future<void> signOutGoogle() async {
    await _googleSignIn.signOut();
    googleUser.value = null;
  }

  void submitReview(BuildContext context) {
    if (!formKey.currentState!.validate()) {
      return;
    }

    final String name = nameController.text.trim();
    final String comment = commentController.text.trim();
    final DateTime now = DateTime.now();
    final String formattedDate =
        "${now.day} ${_getMonthName(now.month)} ${now.year}";

    final newReview = ReviewModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: name,
      rating: selectedRating.value,
      comment: comment,
      date: formattedDate,
      photoUrl: googleUser.value?.photoUrl,
      email: googleUser.value?.email,
    );

    reviewsList.insert(0, newReview);

    nameController.clear();
    commentController.clear();
    selectedRating.value = 5.0;

    if (context.mounted) {
      Navigator.of(context).pop(); // Close dialog if opened in dialog
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Color(0xFF2A4D45),
          content:
              Text('Thank you! Your review has been submitted successfully.'),
        ),
      );
    }
  }

  String _getMonthName(int month) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    return months[month - 1];
  }
}
