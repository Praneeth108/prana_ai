import 'package:flutter/material.dart';
import 'package:prana_ai/pages/firstaid_page.dart';

//  Import your real pages
import 'package:prana_ai/pages/settings_page.dart';
import 'package:prana_ai/pages/emergency_service_page.dart';
import 'package:prana_ai/pages/animal_attack_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[100],

      body: SingleChildScrollView(
        child: Column(
          children: [
            //  HEADER
            Container(
              padding: const EdgeInsets.only(top: 40, left: 16, right: 16),
              decoration: const BoxDecoration(
                gradient: LinearGradient(colors: [Colors.teal, Colors.purple]),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset(
                            "assets/images/logo.jpeg",
                            height: 60,
                            width: 60,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Expanded(
                        child: Text(
                          "PRANA AID\nEmergency support system",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      //  SETTINGS
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

                  const SizedBox(height: 10),
                ],
              ),
            ),

            const SizedBox(height: 20),

            //  EMERGENCY BUTTON
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
                      "EMERGENCY CALL",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            const Text(
              "Quick Access",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),

            const SizedBox(height: 5),

            const Text("Select Emergency Type"),

            const SizedBox(height: 12),

            //  GRID
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
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

            //  QUICK ACTIONS
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  const Text(
                    "Quick Actions",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),

                  const SizedBox(height: 10),

                  // First Aid Button
                  GestureDetector(
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
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.blueGrey,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Center(
                        child: Text(
                          "First Aid Guide",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 15),

                  // Safety Box
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.orange[100],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Safety First",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text("• This app provides guidance only."),
                        Text(
                          "• Always call emergency services for serious injuries.",
                        ),
                        Text("• Seek professional medical care."),
                      ],
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

  //  Emergency Card
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
            Icon(icon, size: 50, color: Colors.orange),
            const SizedBox(height: 10),
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
            const Text("Tap for guidance", style: TextStyle(fontSize: 14)),
          ],
        ),
      ),
    );
  }

  //  Navigation switch
  Widget getPage(String title) {
    switch (title) {
      case "Animal Attack":
        return const AnimalAttackPage();
      default:
        return const EmergencyPage();
    }
  }
}

//  Feature Icon
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
          style: const TextStyle(color: Colors.white, fontSize: 16),
        ),
      ],
    );
  }
}
