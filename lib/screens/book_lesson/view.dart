import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import '../about/view.dart';
import '../courses/view.dart';
import '../home/view.dart';
import 'controller.dart';

class BookLessonView extends StatefulWidget {
  const BookLessonView({super.key});

  @override
  State<BookLessonView> createState() => _BookLessonViewState();
}

class _BookLessonViewState extends State<BookLessonView> {
  final BookLessonController controller = Get.put(BookLessonController());

  void _onHomeTap() {
    Get.offAll(() => const Home());
  }

  void _onCoursesTap() {
    Get.offAll(() => const CoursesView());
  }

  void _onAboutTap() {
    Get.offAll(() => const AboutView());
  }

  void _onContactTap() {
    controller.openDirectWhatsApp();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isMobile = screenWidth < 700;

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
                    child: const Text(
                      'Home',
                      style: TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  TextButton(
                    onPressed: _onCoursesTap,
                    child: const Text(
                      'Courses',
                      style: TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  TextButton(
                    onPressed: _onAboutTap,
                    child: const Text(
                      'About Us',
                      style: TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  TextButton(
                    onPressed: _onContactTap,
                    child: const Text(
                      'Contact Us',
                      style: TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                ],
              ),
        actions: [
          IconButton(
            tooltip: 'WhatsApp',
            onPressed: controller.openDirectWhatsApp,
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
              itemBuilder: (context) => const [
                PopupMenuItem(value: 'Home', child: Text('Home')),
                PopupMenuItem(value: 'Courses', child: Text('Courses')),
                PopupMenuItem(value: 'About Us', child: Text('About Us')),
                PopupMenuItem(value: 'Contact Us', child: Text('Contact Us')),
              ],
            )
          else
            const SizedBox(width: 16),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: isMobile ? 16 : 40,
          vertical: isMobile ? 20 : 36,
        ),
        child: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 600),
            padding: EdgeInsets.all(isMobile ? 20 : 32),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: const Color(0xFFE2ECE9)),
              boxShadow: const [
                BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.02),
                  blurRadius: 12,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Form(
              key: controller.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Heading
                  const Text(
                    'Book a Lesson',
                    style: TextStyle(
                      color: Color(0xFF0F3854),
                      fontWeight: FontWeight.bold,
                      fontSize: 32,
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    "Fill in the form below and we'll get back to you.",
                    style: TextStyle(
                      color: Color(0xFF556B7A),
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 28),

                  // Full Name
                  _buildLabel('Full Name *'),
                  TextFormField(
                    controller: controller.nameController,
                    decoration: _buildInputDecoration('Your name'),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter your full name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),

                  // Phone Number
                  _buildLabel('Phone Number *'),
                  TextFormField(
                    controller: controller.phoneController,
                    keyboardType: TextInputType.phone,
                    decoration: _buildInputDecoration('03XX-XXXXXXX'),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter your phone number';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),

                  // Course Dropdown
                  _buildLabel('Course *'),
                  Obx(
                    () => DropdownButtonFormField<String>(
                      initialValue: controller.selectedCourse.value,
                      hint: const Text(
                        'Select Course',
                        style: TextStyle(color: Color(0xFF94A3B8), fontSize: 14),
                      ),
                      items: controller.coursesList
                          .map(
                            (course) => DropdownMenuItem(
                              value: course,
                              child: Text(course),
                            ),
                          )
                          .toList(),
                      onChanged: (val) {
                        controller.selectedCourse.value = val;
                      },
                      decoration: _buildInputDecoration('Select Course'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please select a course';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Start Date & End Date
                  isMobile
                      ? Column(
                          children: [
                            _buildDateField(
                              label: 'Start Date',
                              getValue: () => controller.selectedStartDate.value,
                              onTap: () => controller.pickStartDate(context),
                            ),
                            const SizedBox(height: 20),
                            _buildDateField(
                              label: 'End Date',
                              getValue: () => controller.selectedEndDate.value,
                              onTap: () => controller.pickEndDate(context),
                            ),
                          ],
                        )
                      : Row(
                          children: [
                            Expanded(
                              child: _buildDateField(
                                label: 'Start Date',
                                getValue: () => controller.selectedStartDate.value,
                                onTap: () => controller.pickStartDate(context),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: _buildDateField(
                                label: 'End Date',
                                getValue: () => controller.selectedEndDate.value,
                                onTap: () => controller.pickEndDate(context),
                              ),
                            ),
                          ],
                        ),
                  const SizedBox(height: 6),
                  const Text(
                    'ℹ Note: All driving courses are 7 days duration. End date is automatically set to the 7th day.',
                    style: TextStyle(
                      color: Color(0xFF386B5A),
                      fontSize: 12,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Preferred Time
                  _buildLabel('Preferred Time'),
                  Obx(
                    () => DropdownButtonFormField<String>(
                      initialValue: controller.selectedTime.value,
                      hint: const Text(
                        'Select Time',
                        style: TextStyle(color: Color(0xFF94A3B8), fontSize: 14),
                      ),
                      items: controller.timeSlots
                          .map(
                            (time) => DropdownMenuItem(
                              value: time,
                              child: Text(time),
                            ),
                          )
                          .toList(),
                      onChanged: (val) {
                        controller.selectedTime.value = val;
                      },
                      decoration: _buildInputDecoration('Select Time'),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Additional Message
                  _buildLabel('Additional Message (optional)'),
                  TextFormField(
                    controller: controller.messageController,
                    maxLines: 3,
                    decoration:
                        _buildInputDecoration('Tell us anything else...'),
                  ),
                  const SizedBox(height: 28),

                  // Submit Button
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      onPressed: () => controller.sendBookingRequest(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF0F3854),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 0,
                      ),
                      child: const Text(
                        'Send Booking Request',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Bottom WhatsApp Contact Info
                  GestureDetector(
                    onTap: controller.openDirectWhatsApp,
                    child: Center(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const FaIcon(
                            FontAwesomeIcons.whatsapp,
                            color: Color(0xFF25D366),
                            size: 28,
                          ),
                          const SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                'Or contact us on WhatsApp',
                                style: TextStyle(
                                  color: Color(0xFF64748B),
                                  fontSize: 12,
                                ),
                              ),
                              SizedBox(height: 2),
                              Text(
                                '+92 323 4248524',
                                style: TextStyle(
                                  color: Color(0xFF0F3854),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
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
          ),
        ),
      ),
    );
  }

  Widget _buildDateField({
    required String label,
    required DateTime? Function() getValue,
    required VoidCallback onTap,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel(label),
        Obx(() {
          final value = getValue();
          return InkWell(
            onTap: onTap,
            child: InputDecorator(
              decoration: _buildInputDecoration(
                'dd / mm / yyyy',
                suffixIcon: const Icon(
                  Icons.calendar_today_outlined,
                  size: 18,
                  color: Color(0xFF556B7A),
                ),
              ),
              child: Text(
                value != null
                    ? "${value.day.toString().padLeft(2, '0')} / ${value.month.toString().padLeft(2, '0')} / ${value.year}"
                    : 'dd / mm / yyyy',
                style: TextStyle(
                  color: value != null
                      ? const Color(0xFF0F3854)
                      : const Color(0xFF94A3B8),
                  fontSize: 14,
                ),
              ),
            ),
          );
        }),
      ],
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        text,
        style: const TextStyle(
          color: Color(0xFF0F3854),
          fontWeight: FontWeight.w600,
          fontSize: 14,
        ),
      ),
    );
  }

  InputDecoration _buildInputDecoration(String hintText,
      {Widget? suffixIcon}) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: const TextStyle(color: Color(0xFF94A3B8), fontSize: 14),
      filled: true,
      fillColor: const Color(0xFFF9FBFB),
      suffixIcon: suffixIcon,
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Color(0xFFE2ECE9)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Color(0xFFE2ECE9)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Color(0xFF0F3854), width: 1.5),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Colors.redAccent),
      ),
    );
  }
}
