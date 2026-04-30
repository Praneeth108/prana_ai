import 'package:flutter/material.dart';

class HeavyBleedingPage extends StatelessWidget {
  const HeavyBleedingPage({super.key});

  Widget stepCard(String title, String description, IconData icon) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.red.shade100,
          child: Icon(icon, color: Colors.red),
        ),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(description),
      ),
    );
  }

  Widget warningBox(String text) {
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: Colors.orange.shade100,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          const Icon(Icons.warning, color: Colors.orange),
          const SizedBox(width: 10),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Heavy Bleeding"),
        backgroundColor: Colors.red,
      ),
      body: Container(
        color: Colors.grey.shade100,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: ListView(
            children: [
              const Text(
                "First Aid for Heavy Bleeding",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),

              const SizedBox(height: 10),

              const Text(
                "Follow these steps immediately to control bleeding and save life:",
                style: TextStyle(fontSize: 16),
              ),

              const SizedBox(height: 15),

              // Steps
              stepCard(
                "1. Stay Calm & Ensure Safety",
                "Make sure the area is safe before helping the injured person.",
                Icons.security,
              ),

              stepCard(
                "2. Apply Direct Pressure",
                "Use a clean cloth or bandage and press firmly on the wound to stop bleeding.",
                Icons.pan_tool,
              ),

              stepCard(
                "3. Elevate the Wound",
                "Raise the injured area above heart level if possible.",
                Icons.trending_up,
              ),

              stepCard(
                "4. Do NOT Remove Cloth",
                "If blood soaks through, add more cloth. Do NOT remove the first one.",
                Icons.block,
              ),

              stepCard(
                "5. Apply Bandage",
                "Secure the cloth with a bandage to maintain pressure.",
                Icons.healing,
              ),

              stepCard(
                "6. Seek Medical Help",
                "Call emergency services or take the person to hospital immediately.",
                Icons.local_hospital,
              ),

              // Warning
              warningBox(
                "⚠️ Severe bleeding can be life-threatening. Act quickly!",
              ),

              warningBox(
                "⚠️ If bleeding does not stop, continue pressure and seek urgent help.",
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}