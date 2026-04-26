import 'package:flutter/material.dart';
import 'package:prana_ai/pages/firstaid_page.dart';

class AyurvedicPage extends StatelessWidget {
  const AyurvedicPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[50],

      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // 🔹 HEADER
              Container(
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(
                  color: Color(0xFF2E9E5B),
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(20),
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

                    const SizedBox(width: 10),

                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Ayurvedic Support",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "Complementary herbal remedies",
                            style: TextStyle(color: Colors.white70),
                          ),
                        ],
                      ),
                    ),

                    const Icon(Icons.eco, color: Colors.white),
                  ],
                ),
              ),

              // 🔹 INFO BOX
              Padding(
                padding: const EdgeInsets.all(12),
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.green[700],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Text(
                    "Important: These are first-aid support remedies only. Always prioritize modern medical treatment.",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),

              // 🔹 SCAN CARD
              Padding(
                padding: const EdgeInsets.all(12),
                child: Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.green[200],
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.green),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Icon(
                              Icons.camera_alt,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(width: 10),
                          const Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Identify Medicinal Plants",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "Use AI to recognize Ayurvedic plants",
                                  style: TextStyle(fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.green[700],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Center(
                          child: Text(
                            "Scan plant with camera",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // 🔹 REMEDY CARD 1
              remedyCard(
                title: "Aloe Vera Gel Application",
                subtitle: "Aloe Vera (Ghritkumari)",
                purpose: "Soothe minor burns and skin irritation",
                preparation: "Extract fresh gel from aloe leaf",
                application: "Apply directly to affected area",
                frequency: "Every 2-3 hours for 2-3 days",
                chips: ["Anti-inflammatory", "Cooling", "Healing"],
              ),

              // 🔹 REMEDY CARD 2
              remedyCard(
                title: "Neem Leaf Wash",
                subtitle: "Neem (Nimba)",
                purpose: "Cleanse and prevent infection",
                preparation: "Boil neem leaves in water, cool and strain",
                application: "Wash affected area with solution",
                frequency: "Once daily for 5-7 days",
                chips: ["Antimicrobial", "Purifying", "Healing"],
              ),

              // 🔹 SAFETY BOX
              Padding(
                padding: const EdgeInsets.all(12),
                child: Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.red[50],
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.red),
                  ),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "⚠ Safety Guidelines",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text("• These remedies are supplementary support only"),
                      Text("• Always perform modern first aid first"),
                      Text("• Test for allergies before full application"),
                      Text("• Discontinue if irritation occurs"),
                      Text("• Seek medical care if symptoms persist"),
                    ],
                  ),
                ),
              ),

              // 🔹 INFO FOOTER
              Padding(
                padding: const EdgeInsets.all(12),
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.blue[100],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Text(
                    "Ayurvedic remedies are based on traditional knowledge. Modern medical treatment takes priority.",
                  ),
                ),
              ),

              // 🔹 BUTTON
              Padding(
                padding: const EdgeInsets.all(16),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const FirstAidPage(),
                      ),
                    );
                  },
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.green),
                    ),
                    child: const Center(
                      child: Text(
                        "Back to First Aid Instructions",
                        style: TextStyle(color: Colors.green),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 🔹 REUSABLE REMEDY CARD
  Widget remedyCard({
    required String title,
    required String subtitle,
    required String purpose,
    required String preparation,
    required String application,
    required String frequency,
    required List<String> chips,
  }) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.green[100],
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.green),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // title
            Row(
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    "First Aid",
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
              ],
            ),

            Text(subtitle, style: const TextStyle(fontSize: 12)),
            const SizedBox(height: 10),

            // purpose
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.green[200],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text("Purpose: $purpose"),
            ),

            const SizedBox(height: 10),

            const Text("Ayurvedic Properties:"),
            Wrap(
              spacing: 8,
              children: chips
                  .map(
                    (e) => Chip(
                      label: Text(e),
                      backgroundColor: Colors.green[200],
                    ),
                  )
                  .toList(),
            ),

            const SizedBox(height: 10),

            Text("💧 Preparation: $preparation"),
            Text("☀ Application: $application"),
            Text("⏱ Frequency: $frequency"),

            const SizedBox(height: 10),

            // caution
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.orange[100],
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Text(
                "⚠ Cautions:\n• Test for allergies first\n• Use fresh gel only\n• Avoid on deep wounds",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
