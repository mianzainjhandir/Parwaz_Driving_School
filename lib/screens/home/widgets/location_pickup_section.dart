import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class LocationPickupSection extends StatelessWidget {
  const LocationPickupSection({super.key});

  Future<void> _openGoogleMaps() async {
    final Uri mapsUrl =
        Uri.parse("https://www.google.com/maps/place/Vehari,+Punjab,+Pakistan");
    if (!await launchUrl(mapsUrl, mode: LaunchMode.externalApplication)) {
      // Fallback
    }
  }

  Future<void> _inquirePickupWhatsApp(BuildContext context) async {
    final Uri whatsappUrl = Uri.parse(
        "https://wa.me/923234248524?text=Hello%20Parwaaz%20Driving%20Institute,%20I%20want%20to%20inquire%20about%20Home%20Pickup%20service%20for%20my%20area%20in%20Vehari.");
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

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isMobile = screenWidth < 800;

    final List<String> serviceAreas = [
      'Club Road',
      'Sharqi Colony',
      'Gharbi Colony',
      'Luddan Road',
      'Multan Road Area',
      'College Town',
      'People\'s Colony',
      'Karkan Chowk',
      'All Vehari City Suburbs',
    ];

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 16 : 40,
        vertical: 24,
      ),
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 1100),
          decoration: BoxDecoration(
            color: const Color(0xFFF8FAF9),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: const Color(0xFFE2ECE9)),
          ),
          padding: EdgeInsets.all(isMobile ? 20 : 32),
          child: isMobile
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildPickupHeader(context),
                    const SizedBox(height: 24),
                    _buildServiceAreasCard(serviceAreas),
                    const SizedBox(height: 24),
                    _buildMapDirectionsCard(context),
                  ],
                )
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Left Column: Pickup details + Service areas
                    Expanded(
                      flex: 6,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildPickupHeader(context),
                          const SizedBox(height: 24),
                          _buildServiceAreasCard(serviceAreas),
                        ],
                      ),
                    ),
                    const SizedBox(width: 32),
                    // Right Column: Location Map & Get Directions Card
                    Expanded(
                      flex: 5,
                      child: _buildMapDirectionsCard(context),
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  Widget _buildPickupHeader(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'LOCATION & HOME PICKUP',
          style: TextStyle(
            color: Color(0xFF4A6B6C),
            fontWeight: FontWeight.w600,
            fontSize: 12,
            letterSpacing: 2,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Doorstep Pickup & Location',
          style: TextStyle(
            color: Color(0xFF0F3854),
            fontWeight: FontWeight.bold,
            fontSize: 28,
          ),
        ),
        const SizedBox(height: 10),
        const Text(
          'We provide safe, punctual, and comfortable home pickup and drop-off services for female students across Vehari city.',
          style: TextStyle(
            color: Color(0xFF556B7A),
            fontSize: 14.5,
            height: 1.5,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            ElevatedButton.icon(
              onPressed: () => _inquirePickupWhatsApp(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF25D366),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                elevation: 0,
              ),
              icon: const FaIcon(FontAwesomeIcons.whatsapp, size: 18),
              label: const Text(
                'Inquire Pickup Area',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildServiceAreasCard(List<String> areas) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2ECE9)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.directions_car_outlined, color: Color(0xFF0F3854), size: 22),
              SizedBox(width: 8),
              Text(
                'Covered Service Areas in Vehari:',
                style: TextStyle(
                  color: Color(0xFF0F3854),
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: areas
                .map(
                  (area) => Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEBF3F0),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: const Color(0xFFD0E2DB)),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.location_on_outlined,
                            size: 14, color: Color(0xFF2A4D45)),
                        const SizedBox(width: 4),
                        Text(
                          area,
                          style: const TextStyle(
                            color: Color(0xFF2A4D45),
                            fontWeight: FontWeight.w600,
                            fontSize: 12.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildMapDirectionsCard(BuildContext context) {
    return Container(
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
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color(0xFFEBF3F0),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.map_outlined,
                  color: Color(0xFF0F3854),
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Parwaaz Driving Institute',
                    style: TextStyle(
                      color: Color(0xFF0F3854),
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    'Vehari, Punjab, Pakistan',
                    style: TextStyle(
                      color: Color(0xFF64748B),
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Interactive Map Card (Vehari Area Map)
          GestureDetector(
            onTap: _openGoogleMaps,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Stack(
                children: [
                  Image.network(
                    'https://static-maps.yandex.ru/1.x/?lang=en-US&ll=72.3489,30.0452&z=14&l=map&size=600,280',
                    height: 180,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        height: 180,
                        width: double.infinity,
                        color: const Color(0xFFE2ECE9),
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.map_outlined, size: 40, color: Color(0xFF0F3854)),
                            SizedBox(height: 8),
                            Text('Vehari, Punjab, Pakistan',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF0F3854))),
                          ],
                        ),
                      );
                    },
                  ),
                  Positioned(
                    bottom: 12,
                    right: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(15, 56, 84, 0.90),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.location_on_rounded,
                              color: Colors.redAccent, size: 16),
                          SizedBox(width: 4),
                          Text(
                            'Vehari Area Map',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          // View Map Button
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton.icon(
              onPressed: _openGoogleMaps,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0F3854),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0,
              ),
              icon: const Icon(Icons.map_outlined, size: 20),
              label: const Text(
                'Open Vehari Area on Google Maps',
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
