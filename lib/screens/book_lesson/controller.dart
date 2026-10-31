import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class BookLessonController extends GetxController {
  final formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final messageController = TextEditingController();

  var selectedCourse = RxnString();
  var selectedTime = RxnString();
  var selectedStartDate = Rxn<DateTime>();
  var selectedEndDate = Rxn<DateTime>();

  final List<String> coursesList = [
    'Beginner Driving (7 Days)',
    'Road Practice (7 Days)',
    'Refresher Course (7 Days)',
    'Advanced Driving (7 Days)',
    'VIP Custom Course (7 Days)',
  ];

  final List<String> timeSlots = [
    'Morning (9:00 AM - 12:00 PM)',
    'Afternoon (12:00 PM - 3:00 PM)',
    'Evening (3:00 PM - 6:00 PM)',
  ];

  @override
  void onClose() {
    nameController.dispose();
    phoneController.dispose();
    messageController.dispose();
    super.onClose();
  }

  void pickStartDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedStartDate.value ?? DateTime.now().add(const Duration(days: 1)),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 180)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF0F3854),
              onPrimary: Colors.white,
              onSurface: Color(0xFF0F3854),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      selectedStartDate.value = picked;
      // Automatically set default End Date to 7th day (start date + 6 days = 7 days total duration)
      selectedEndDate.value = picked.add(const Duration(days: 6));
    }
  }

  void pickEndDate(BuildContext context) async {
    final DateTime first = selectedStartDate.value ?? DateTime.now();
    final DateTime initial = selectedEndDate.value ?? first.add(const Duration(days: 6));

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initial.isBefore(first) ? first : initial,
      firstDate: first,
      lastDate: DateTime.now().add(const Duration(days: 180)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF0F3854),
              onPrimary: Colors.white,
              onSurface: Color(0xFF0F3854),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      selectedEndDate.value = picked;
    }
  }

  Future<void> sendBookingRequest(BuildContext context) async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    final String name = nameController.text.trim();
    final String phone = phoneController.text.trim();
    final String course = selectedCourse.value ?? 'Not specified';
    final String startDate = selectedStartDate.value != null
        ? "${selectedStartDate.value!.day}/${selectedStartDate.value!.month}/${selectedStartDate.value!.year}"
        : 'Not specified';
    final String endDate = selectedEndDate.value != null
        ? "${selectedEndDate.value!.day}/${selectedEndDate.value!.month}/${selectedEndDate.value!.year}"
        : 'Not specified';
    final String time = selectedTime.value ?? 'Not specified';
    final String additionalMsg = messageController.text.trim();

    final String whatsappText = '''
*NEW LESSON BOOKING REQUEST*
-----------------------------
*Full Name:* $name
*Phone Number:* $phone
*Selected Course:* $course
*Course Duration:* 7 Days
*Start Date:* $startDate
*End Date:* $endDate
*Preferred Time:* $time
${additionalMsg.isNotEmpty ? "*Additional Message:* $additionalMsg" : ""}
-----------------------------
Sent from Parwaaz Driving Institute App.
''';

    final Uri whatsappUrl = Uri.parse(
        "https://wa.me/923234248524?text=${Uri.encodeComponent(whatsappText)}");

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

  Future<void> openDirectWhatsApp() async {
    final Uri whatsappUrl = Uri.parse("https://wa.me/923234248524");
    await launchUrl(whatsappUrl, mode: LaunchMode.externalApplication);
  }
}
