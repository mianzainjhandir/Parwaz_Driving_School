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

  // Hourly slots from 5:00 AM to 5:00 PM
  final List<String> timeSlots = [
    '5:00 AM - 6:00 AM',
    '6:00 AM - 7:00 AM',
    '7:00 AM - 8:00 AM',
    '8:00 AM - 9:00 AM',
    '9:00 AM - 10:00 AM',
    '10:00 AM - 11:00 AM',
    '11:00 AM - 12:00 PM',
    '12:00 PM - 1:00 PM',
    '1:00 PM - 2:00 PM',
    '2:00 PM - 3:00 PM',
    '3:00 PM - 4:00 PM',
    '4:00 PM - 5:00 PM',
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

  void pickCustomTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: const TimeOfDay(hour: 9, minute: 0),
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
      // Validate time between 5 AM (5) and 5 PM (17)
      if (picked.hour < 5 || picked.hour > 17) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Please select a time between 5:00 AM and 5:00 PM.'),
            ),
          );
        }
        return;
      }
      if (!context.mounted) return;
      final String formattedStart = picked.format(context);
      final TimeOfDay end = TimeOfDay(hour: (picked.hour + 1) % 24, minute: picked.minute);
      final String formattedEnd = end.format(context);
      selectedTime.value = '$formattedStart - $formattedEnd (1 Hour)';
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
*Preferred 1-Hour Slot:* $time
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
