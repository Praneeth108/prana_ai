import 'package:flutter/material.dart';

// ✅ Import your real pages
import 'package:prana_ai/pages/settings_page.dart';
import 'package:prana_ai/pages/emergency_service_page.dart';
import 'package:prana_ai/pages/animal_attack_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[100],

      body: Column(
        children: [
          // 🔝 HEADER
          Container(
            padding: const EdgeInsets.only(top: 40, left: 16, right: 16),
            decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [Colors.teal, Colors.purple]),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Image.asset("assets/images/logo.jpeg", height: 40),
                    const SizedBox(width: 10),
                    const Expanded(
                      child: Text(
                        "PRANA AID\nEmergency support system",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),

                    // ⚙ SETTINGS
                    IconButton(
                      icon: const Icon(Icons.settings, color: Colors.white),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SettingsPage(),
                          ),
                        );
                      },
                    ),
                  ],
                ),

                const SizedBox(height: 10),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: const [
                    FeatureIcon("Safe and\nVerified"),
                    FeatureIcon("Hybrid\nCare"),
                    FeatureIcon("AI\nPowered"),
                  ],
                ),

                const SizedBox(height: 15),
              ],
            ),
          ),

          // 🚨 EMERGENCY BUTTON
          Padding(
            padding: const EdgeInsets.all(12),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const EmergencyPage(),
                  ),
                );
              },
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Center(
                  child: Text(
                    "EMERGENCY CALL\nTap for immediate help",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ),

          const Text(
            "Quick Access",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 5),

          const Text("Select Emergency Type"),

          const SizedBox(height: 10),

          // 🟧 GRID
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              padding: const EdgeInsets.all(12),
              childAspectRatio: 1,
              children: [
                emergencyCard(context, "Animal Attack", Icons.pets),
                emergencyCard(context, "Burns", Icons.local_fire_department),
                emergencyCard(context, "Electric Shock", Icons.flash_on),
                emergencyCard(context, "Heavy Bleeding", Icons.water_drop),
                emergencyCard(context, "Road Accident", Icons.car_crash),
                emergencyCard(context, "Fainting", Icons.sick),
              ],
            ),
          ),

          // 🔻 QUICK ACTIONS
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                const Text(
                  "Quick Actions",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 10),

                actionBox("Plant Recognition", Colors.green),
                const SizedBox(height: 10),
                actionBox("Learning Mode", Colors.blueGrey),
                const SizedBox(height: 10),
                actionBox("Safety First", Colors.yellow),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // 🔹 Emergency Card with navigation
  Widget emergencyCard(BuildContext context, String title, IconData icon) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => getPage(title)),
        );
      },
      child: Container(
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.orange),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: Colors.orange),
            const SizedBox(height: 10),
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
            const Text("Tap for guidance", style: TextStyle(fontSize: 12)),
          ],
        ),
      ),
    );
  }

  // 🔹 Navigation switch (VERY IMPORTANT)
  Widget getPage(String title) {
    switch (title) {
      case "Animal Attack":
        return const AnimalAttackPage();
      case "Burns":
      //   return const BurnsPage();
      case "Electric Shock":
      //   return const ElectricShockPage();
      case "Heavy Bleeding":
      //   return const HeavyBleedingPage();
      case "Road Accident":
      //   return const RoadAccidentPage();
      case "Fainting":
      //  return const FaintingPage();
      default:
        return const EmergencyPage();
    }
  }

  // 🔹 Action Box
  Widget actionBox(String text, Color color) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: color.withOpacity(0.3),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(child: Text(text)),
    );
  }
}

// 🔹 Feature Icon Widget
class FeatureIcon extends StatelessWidget {
  final String text;
  const FeatureIcon(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Icon(Icons.check_circle, color: Colors.white),
        const SizedBox(height: 5),
        Text(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.white, fontSize: 12),
        ),
      ],
    );
  }
}
