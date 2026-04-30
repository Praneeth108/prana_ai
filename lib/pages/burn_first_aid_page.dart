import 'package:flutter/material.dart';

class BurnFirstAidPage extends StatelessWidget {
  final String burnType;

  const BurnFirstAidPage({super.key, required this.burnType});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(burnType),
        backgroundColor: Colors.red,
      ),
      backgroundColor: Colors.grey[200],
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            // 🔷 Title
            Text(
              "First Aid Instructions",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.red[800],
              ),
            ),

            const SizedBox(height: 15),

            // ✅ DO SECTION
            const Text(
              "✅ What To Do",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            ..._getDos(burnType).map(
              (item) => Card(
                child: ListTile(
                  leading: const Icon(Icons.check_circle, color: Colors.green),
                  title: Text(item),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // ❌ DON'T SECTION
            const Text(
              "❌ What NOT To Do",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            ..._getDonts(burnType).map(
              (item) => Card(
                child: ListTile(
                  leading: const Icon(Icons.cancel, color: Colors.red),
                  title: Text(item),
                ),
              ),
            ),

            const SizedBox(height: 30),

            // ⚠️ Emergency Warning
            Container(
              padding: const EdgeInsets.all(15),
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
                      "Seek immediate medical help if the burn is severe, large, or on face/hands.",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ✅ DO's
  List<String> _getDos(String type) {
    switch (type) {
      case "Thermal Burns":
        return [
          "Cool under running water for 10–20 minutes",
          "Remove tight items (rings, clothes)",
          "Cover with clean cloth or sterile dressing",
          "Drink water to stay hydrated",
        ];

      case "Chemical Burns":
        return [
          "Rinse immediately with plenty of clean water",
          "Remove contaminated clothing carefully",
          "Continue flushing for at least 20 minutes",
          "Seek medical help quickly",
        ];

      case "Electrical Burns":
        return [
          "Turn off power source before touching victim",
          "Check breathing and pulse",
          "Call emergency services immediately",
          "Keep victim still and warm",
        ];

      case "Radiation Burns":
        return [
          "Avoid further sun/radiation exposure",
          "Apply soothing lotion (like aloe vera)",
          "Drink plenty of fluids",
          "Keep area clean",
        ];

      case "Friction Burns":
        return [
          "Clean wound gently with water",
          "Apply antiseptic cream",
          "Cover with sterile bandage",
        ];

      case "Cold Burns":
        return [
          "Warm slowly using lukewarm water",
          "Protect area from further cold",
          "Use dry, clean cloth",
        ];

      case "Inhalation Burns":
        return [
          "Move person to fresh air immediately",
          "Loosen tight clothing",
          "Monitor breathing closely",
          "Seek urgent medical help",
        ];

      default:
        return ["Provide basic first aid"];
    }
  }

  // ❌ DON'Ts
  List<String> _getDonts(String type) {
    switch (type) {
      case "Thermal Burns":
        return [
          "Do NOT use ice directly",
          "Do NOT apply butter, oil, or toothpaste",
          "Do NOT break blisters",
        ];

      case "Chemical Burns":
        return [
          "Do NOT touch chemical with bare hands",
          "Do NOT apply creams before washing",
        ];

      case "Electrical Burns":
        return [
          "Do NOT touch victim before power is OFF",
        ];

      case "Radiation Burns":
        return [
          "Do NOT expose skin to sunlight",
        ];

      case "Friction Burns":
        return [
          "Do NOT ignore cleaning the wound",
        ];

      case "Cold Burns":
        return [
          "Do NOT rub the area",
          "Do NOT use direct heat (fire/heater)",
        ];

      case "Inhalation Burns":
        return [
          "Do NOT ignore breathing difficulty",
        ];

      default:
        return ["Avoid unsafe actions"];
    }
  }
}
