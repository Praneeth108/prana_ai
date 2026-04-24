import 'package:flutter/material.dart';

class EmergencyPage extends StatelessWidget {
  const EmergencyPage({super.key});

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
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  SizedBox(width: 10),
                  Expanded(
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
                  Icon(Icons.phone, color: Colors.white),
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Nearby Hospitals",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Text(
                            "GPS Active",
                            style: TextStyle(color: Colors.white, fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),

                    Container(
                      height: 200,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey[300],
                      ),
                      child: const Center(child: Text("Map View")),
                    ),

                    const SizedBox(height: 15),
                    // 🔥 IMAGE CARDS
                    hotlineCard(
                      "assets/images/emer.jpg",
                      Colors.white,
                      "Emergency Services",
                      "Police",
                      "CRITICAL",
                      const Color.fromARGB(255, 35, 3, 245),
                      "119",
                    ),

                    hotlineCard(
                      "assets/images/ambulance.jpg",
                      Colors.white,
                      "Ambulance",
                      "Medical emergency ambulance",
                      "HIGH",
                      const Color.fromARGB(255, 215, 4, 4),
                      "1990",
                    ),

                    hotlineCard(
                      "assets/images/fire.jpg",
                      Colors.white,
                      "Fire Services",
                      "Fire and rescue services",
                      "HIGH",
                      const Color.fromARGB(255, 215, 4, 4),
                      "110",
                    ),

                    hotlineCard(
                      "assets/images/poison.jpg",
                      Colors.white,
                      "Poison Control",
                      "Poison emergencies & guidance",
                      "HIGH",
                      const Color.fromARGB(255, 215, 4, 4),
                      "0112686",
                    ),

                    hotlineCard(
                      "assets/images/women.jpeg",
                      Colors.white,
                      "Women Helpline",
                      "Emergency helpline for women",
                      "MEDIUM",
                      Colors.yellow,
                      "1938",
                    ),

                    hotlineCard(
                      "assets/images/child.jpg",
                      Colors.white,
                      "Child Helpline",
                      "Child emergency & protection",
                      "MEDIUM",
                      Colors.yellow,
                      "1929",
                    ),

                    hotlineCard(
                      "assets/images/mental.jpg",
                      Colors.white,
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

  // 🔥 CARD WITH IMAGE
  Widget hotlineCard(
    String imagePath,
    Color bgColor,
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
          // TITLE + LABEL
          Stack(
            children: [
              Align(
                alignment: Alignment.center,
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

          // 🔹 IMAGE + TEXT
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: bgColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Image.asset(
                  imagePath,
                  height: 50,
                  width: 100,
                  fit: BoxFit.contain,
                ),
              ),

              const SizedBox(width: 20),

              Expanded(
                child: Text(
                  subtitle,
                  style: const TextStyle(fontSize: 15, color: Colors.black54),
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          // 🔥 BUTTON
          Align(
            alignment: Alignment.bottomRight,
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
                  const Icon(Icons.phone, color: Colors.white, size: 20),
                  const SizedBox(width: 5),
                  Text(
                    number,
                    style: const TextStyle(color: Colors.white, fontSize: 14),
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
