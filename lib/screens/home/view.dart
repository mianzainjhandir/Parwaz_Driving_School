
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  void _onHomeTap() {}

  void _onCoursesTap() {}

  void _onAboutTap() {}

  void _onContactTap() {}

  void _onWhatsAppTap() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('WhatsApp link will be connected here.'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isMobile = screenWidth < 700;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leadingWidth: 120,
        leading: Padding(
          padding: const EdgeInsets.only(
            left: 12,
            top: 4,
            bottom: 4,
          ),
          child: Image.asset(
            'assets/images/img_1.png',
            fit: BoxFit.contain,
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
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: 16),
            TextButton(
              onPressed: _onCoursesTap,
              child: const Text(
                'Courses',
                style: TextStyle(color: Colors.black),
              ),
            ),
            const SizedBox(width: 16),
            TextButton(
              onPressed: _onAboutTap,
              child: const Text(
                'About Us',
                style: TextStyle(color: Colors.black),
              ),
            ),
            const SizedBox(width: 16),
            TextButton(
              onPressed: _onContactTap,
              child: const Text(
                'Contact Us',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        ),
        actions: [
          // WhatsApp icon on BOTH mobile and desktop
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
                  case 'Contact Us':
                    _onContactTap();
                    break;
                }
              },
              itemBuilder: (context) => const [
                PopupMenuItem(
                  value: 'Home',
                  child: Text('Home'),
                ),
                PopupMenuItem(
                  value: 'Courses',
                  child: Text('Courses'),
                ),
                PopupMenuItem(
                  value: 'About Us',
                  child: Text('About Us'),
                ),
                PopupMenuItem(
                  value: 'Contact Us',
                  child: Text('Contact Us'),
                ),
              ],
            )
          else
            const SizedBox(width: 16),
        ],
      ),
      body: const SizedBox.expand(),
    );
  }
}
