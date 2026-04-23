import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Column(
          children: [
            // HEADER
            Container(
              padding: const EdgeInsets.all(16),
              color: Colors.blueGrey,
              child: Row(
                children: const [
                  Icon(Icons.arrow_back, color: Colors.white),
                  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Settings",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "App preferences & information",
                        style: TextStyle(color: Colors.white70, fontSize: 12),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 🔹 NORMAL CONTENT WITH PADDING
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          sectionTitle("Account"),

                          settingCard([
                            settingTile(
                              Icons.person,
                              "Personal Profile",
                              "Name, age, blood group",
                            ),
                            settingTile(
                              Icons.medical_services,
                              "Medical Information",
                              "Allergies, conditions...",
                              tag: "Important",
                            ),
                            settingTile(
                              Icons.phone,
                              "Emergency Contacts",
                              "Family & close...",
                              trailing: "2 contacts",
                            ),
                          ]),

                          sectionTitle("App Settings"),

                          settingCard([
                            settingTile(
                              Icons.notifications,
                              "Notifications",
                              "Emergency alerts &...",
                              trailing: "On",
                            ),
                            settingTile(
                              Icons.language,
                              "Language",
                              "App language...",
                              trailing: "English",
                            ),
                          ]),

                          sectionTitle("Information"),

                          settingCard([
                            settingTile(
                              Icons.info,
                              "About PRANA AID",
                              "Version & app...",
                              trailing: "v1.0.0",
                            ),
                            settingTile(
                              Icons.description,
                              "Disclaimers",
                              "Medical & Ayurvedic...",
                              tag: "Read",
                            ),
                            settingTile(
                              Icons.lock,
                              "Privacy Policy",
                              "How we handle your data",
                            ),
                            settingTile(
                              Icons.help,
                              "Help & Support",
                              "FAQs and contact support",
                            ),
                          ]),
                        ],
                      ),
                    ),

                    // ✅ GREEN BOX (NOW ALIGNED)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: infoBox(
                        color: Colors.green[100]!,
                        borderColor: Colors.green,
                        title: "PRANA AID",
                        content:
                            "AI-Assisted Emergency First Aid & Ayurvedic Support\n\n"
                            "Key Features:\n"
                            "• Modern Evidence-Based First Aid\n"
                            "• Safe Ayurvedic Support for Minor Injuries\n"
                            "• AI Plant Recognition\n"
                            "• Emergency Services Integration\n"
                            "• Educational Learning Modules",
                      ),
                    ),

                    const SizedBox(height: 10),

                    // ✅ RED BOX (NOW ALIGNED)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: infoBox(
                        color: Colors.red[100]!,
                        borderColor: Colors.red,
                        title: "Safety Reminder",
                        content:
                            "This app is a decision-support tool, NOT a replacement for professional medical care.\n"
                            "• Always call emergency services\n"
                            "• Severe injuries need real doctors\n"
                            "• Seek immediate hospital care",
                      ),
                    ),

                    const SizedBox(height: 10),

                    const Padding(
                      padding: EdgeInsets.all(8),
                      child: Center(
                        child: Text(
                          "PRANA AID – Smart Hybrid Emergency First Aid Assistant\nModern Medicine + Ayurvedic Support\n© 2026",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 11),
                        ),
                      ),
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

  // SECTION TITLE
  Widget sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
    );
  }

  // CARD
  Widget settingCard(List<Widget> children) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(children: children),
    );
  }

  // TILE
  Widget settingTile(
    IconData icon,
    String title,
    String subtitle, {
    String? trailing,
    String? tag,
  }) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.blue[100],
        child: Icon(icon, color: Colors.blue),
      ),
      title: Row(
        children: [
          Text(title),
          if (tag != null) ...[
            const SizedBox(width: 5),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.orange,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text(
                tag,
                style: const TextStyle(fontSize: 10, color: Colors.white),
              ),
            ),
          ],
        ],
      ),
      subtitle: Text(subtitle),
      trailing: trailing != null
          ? Text(trailing, style: const TextStyle(fontSize: 12))
          : const Icon(Icons.arrow_forward_ios, size: 16),
    );
  }

  // INFO BOX
  Widget infoBox({
    required Color color,
    required Color borderColor,
    required String title,
    required String content,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
          const SizedBox(height: 8),
          Text(content, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }
}
