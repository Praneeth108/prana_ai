import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BurnsScreen(),
    );
  }
}

class BurnsScreen extends StatelessWidget {
  const BurnsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: const Text("Burns"),
        backgroundColor: Colors.orange,
        leading: const Icon(Icons.arrow_back),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            sectionCard(
              title: "First Degree Burn",
              subtitle: "Superficial",
              points: [
                "Pink & painful (still has nerves)",
                "No scarring",
                "Heals: few days",
              ],
            ),
            sectionCard(
              title: "Second Degree Burn",
              subtitle: "Superficial Partial Thickness",
              points: ["Blisters, shiny, moist", "Painful", "Heals: 2–6 weeks"],
            ),
            thirdDegreeCard(),
          ],
        ),
      ),
    );
  }

  Widget sectionCard({
    required String title,
    required String subtitle,
    required List<String> points,
  }) {
    return Container(
      margin: const EdgeInsets.all(12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFEDEBD6),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.red),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Purple header
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.purple,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(subtitle, style: const TextStyle(color: Colors.white)),
              ],
            ),
          ),

          const SizedBox(height: 10),

          // Points
          ...points.map((e) => Text("• $e")),

          const SizedBox(height: 10),

          const Text(
            "Select Burn Type",
            style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
          ),

          const Divider(color: Colors.purple),

          // Buttons
          burnButtons(),
        ],
      ),
    );
  }

  Widget burnButtons() {
    List<String> types = [
      "Thermal Burns",
      "Chemical Burns",
      "Radiation Burns",
      "Electrical Burns",
      "Inhalation Burns",
      "Friction Burns",
      "Cold Burns",
    ];

    return Column(children: types.map((type) => burnButton(type)).toList());
  }

  Widget burnButton(String text) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red,
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        onPressed: () {},
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget thirdDegreeCard() {
    return Container(
      margin: const EdgeInsets.all(12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFEDEBD6),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.red),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.purple,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Third Degree Burn",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text("Full Thickness", style: TextStyle(color: Colors.white)),
              ],
            ),
          ),

          const SizedBox(height: 10),

          const Text("• May look black, yellow, red & wet"),
          const Text("• No pain/limited pain"),
          const Text("• Skin will not heal"),
          const Text("• Dead tissue must be removed"),

          const SizedBox(height: 10),

          // Warning box
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.red[200],
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Row(
              children: [
                Icon(Icons.warning, color: Colors.black),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    "Seek immediate medical attention for serious burns",
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 10),

          const Center(
            child: Text(
              "Immediately call emergency services",
              style: TextStyle(color: Colors.red),
            ),
          ),

          const SizedBox(height: 10),

          Center(
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              onPressed: () {},
              icon: const Icon(Icons.call),
              label: const Text("Call 1990"),
            ),
          ),
        ],
      ),
    );
  }
}
