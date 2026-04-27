import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class EmergencyPage extends StatelessWidget {
  const EmergencyPage({super.key});

  // 📞 CALL FUNCTION
  Future<void> _makeCall(String number) async {
    final Uri phoneUri = Uri.parse("tel:$number");
    try {
      if (await canLaunchUrl(phoneUri)) {
        await launchUrl(phoneUri, mode: LaunchMode.externalApplication);
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
    await launchUrl(url, mode: LaunchMode.externalApplication);
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
                          style: TextStyle(color: Colors.white70, fontSize: 16),
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
                    const Text(
                      "Nearby Hospitals",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 10),

                    // 🗺️ MAP BUTTON
                    GestureDetector(
                      onTap: _openHospitalsMap,
                      child: Container(
                        height: 180,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          gradient: const LinearGradient(
                            colors: [Color(0xFF2196F3), Color(0xFF0D47A1)],
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

                    // FIX: pass _makeCall as onCall callback to each card
                    _hotlineCard(
                      imagePath: "assets/images/emer.jpg",
                      title: "Emergency Services",
                      subtitle: "Police emergency service",
                      level: "CRITICAL",
                      levelColor: const Color.fromARGB(255, 35, 3, 245),
                      number: "119",
                      onCall: _makeCall,
                    ),
                    _hotlineCard(
                      imagePath: "assets/images/ambulance.jpg",
                      title: "Ambulance",
                      subtitle: "Medical emergency ambulance",
                      level: "HIGH",
                      levelColor: Colors.red,
                      number: "1990",
                      onCall: _makeCall,
                    ),
                    _hotlineCard(
                      imagePath: "assets/images/fire.jpg",
                      title: "Fire Services",
                      subtitle: "Fire and rescue services",
                      level: "HIGH",
                      levelColor: Colors.red,
                      number: "110",
                      onCall: _makeCall,
                    ),
                    _hotlineCard(
                      imagePath: "assets/images/poison.jpg",
                      title: "Poison Control",
                      subtitle: "Poison emergencies & guidance",
                      level: "HIGH",
                      levelColor: Colors.red,
                      number: "0112686",
                      onCall: _makeCall,
                    ),
                    _hotlineCard(
                      imagePath: "assets/images/women.jpeg",
                      title: "Women Helpline",
                      subtitle: "Emergency helpline for women",
                      level: "MEDIUM",
                      // FIX: changed from Colors.yellow (white text invisible) to Colors.orange
                      levelColor: Colors.orange,
                      number: "1938",
                      onCall: _makeCall,
                    ),
                    _hotlineCard(
                      imagePath: "assets/images/child.jpg",
                      title: "Child Helpline",
                      subtitle: "Child emergency & protection",
                      level: "MEDIUM",
                      levelColor: Colors.orange,
                      number: "1929",
                      onCall: _makeCall,
                    ),
                    _hotlineCard(
                      imagePath: "assets/images/mental.jpg",
                      title: "Mental Health Support",
                      subtitle: "Confidential support & crisis care",
                      level: "MEDIUM",
                      levelColor: Colors.orange,
                      number: "1926",
                      onCall: _makeCall,
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

  // FIX: onCall is now a required named parameter — no more scope issue
  Widget _hotlineCard({
    required String imagePath,
    required String title,
    required String subtitle,
    required String level,
    required Color levelColor,
    required String number,
    required Future<void> Function(String) onCall,
  }) {
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
                  style: const TextStyle(fontSize: 15, color: Colors.black54),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          GestureDetector(
            onTap: () => onCall(number),
            child: Container(
              width: 250,
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                gradient: const LinearGradient(
                  colors: [Color(0xFF53EB6A), Color(0xFF026E0D)],
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
