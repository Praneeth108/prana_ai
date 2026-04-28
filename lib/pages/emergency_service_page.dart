import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class EmergencyPage extends StatelessWidget {
  const EmergencyPage({super.key});

  // 📞 CALL FUNCTION (SAFE)
  Future<void> _makeCall(String number) async {
    final Uri phoneUri = Uri.parse("tel:$number");

    try {
      if (await canLaunchUrl(phoneUri)) {
        await launchUrl(
          phoneUri,
          mode: LaunchMode.externalApplication,
        );
      }
    } catch (e) {
      debugPrint("Cannot launch: $number");
    }
  }

  // 🗺️ OPEN GOOGLE MAPS
  Future<void> _openHospitalsMap() async {
    final Uri url = Uri.parse(
      "https://www.google.com/maps/search/hospitals+near+me/",
    );

    await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],

      body: SafeArea(
        child: Column(
          children: [
            // 🔴 HEADER
            Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color.fromARGB(255, 236, 7, 7),
                    Color.fromARGB(255, 255, 121, 49),
                  ],
                ),
              ),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const SizedBox(width: 10),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Emergency Services",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "Quick access to help",
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Icon(Icons.phone, color: Colors.white),
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 🗺️ TITLE
                    const Text(
                      "Nearby Hospitals",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),

                    const SizedBox(height: 10),

                    // 🗺️ SAFE MAP BUTTON
                    GestureDetector(
                      onTap: _openHospitalsMap,
                      child: Container(
                        height: 180,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          gradient: const LinearGradient(
                            colors: [
                              Color(0xFF2196F3),
                              Color(0xFF0D47A1),
                            ],
                          ),
                        ),
                        child: const Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.location_on,
                                size: 50,
                                color: Colors.white,
                              ),
                              SizedBox(height: 10),
                              Text(
                                "Tap to find nearby hospitals",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 15),

                    // 🔥 CARDS
                    hotlineCard(
                      "assets/images/emer.jpg",
                      "Emergency Services",
                      "Police emergency service",
                      "CRITICAL",
                      const Color.fromARGB(255, 35, 3, 245),
                      "119",
                    ),

                    hotlineCard(
                      "assets/images/ambulance.jpg",
                      "Ambulance",
                      "Medical emergency ambulance",
                      "HIGH",
                      Colors.red,
                      "1990",
                    ),

                    hotlineCard(
                      "assets/images/fire.jpg",
                      "Fire Services",
                      "Fire and rescue services",
                      "HIGH",
                      Colors.red,
                      "110",
                    ),

                    hotlineCard(
                      "assets/images/poison.jpg",
                      "Poison Control",
                      "Poison emergencies & guidance",
                      "HIGH",
                      Colors.red,
                      "0112686",
                    ),

                    hotlineCard(
                      "assets/images/women.jpeg",
                      "Women Helpline",
                      "Emergency helpline for women",
                      "MEDIUM",
                      Colors.yellow,
                      "1938",
                    ),

                    hotlineCard(
                      "assets/images/child.jpg",
                      "Child Helpline",
                      "Child emergency & protection",
                      "MEDIUM",
                      Colors.yellow,
                      "1929",
                    ),

                    hotlineCard(
                      "assets/images/mental.jpg",
                      "Mental Health Support",
                      "Confidential support & crisis care",
                      "MEDIUM",
                      Colors.yellow,
                      "1926",
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 🔥 CARD
  Widget hotlineCard(
    String imagePath,
    String title,
    String subtitle,
    String level,
    Color levelColor,
    String number,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        children: [
          Stack(
            children: [
              Center(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    color: levelColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    level,
                    style: const TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          Row(
            children: [
              Image.asset(imagePath, height: 50, width: 80),

              const SizedBox(width: 15),

              Expanded(
                child: Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 15,
                    color: Colors.black54,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          GestureDetector(
            onTap: () => _makeCall(number),
            child: Container(
              width: 250,
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFF53EB6A),
                    Color(0xFF026E0D),
                  ],
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.phone, color: Colors.white),
                  const SizedBox(width: 5),
                  Text(
                    "Call $number",
                    style: const TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}