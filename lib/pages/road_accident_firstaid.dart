import 'package:flutter/material.dart';

class FirstAidPage extends StatelessWidget {
  const FirstAidPage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: Colors.white,
    appBar: AppBar(
      backgroundColor: Colors.yellow,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.black),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      title: const Text(
        "ROAD ACCIDENT FIRST AID",
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      ),
    ),
    body: SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          _firstAidStep(
            icon: Icons.warning_amber_rounded,
            title: "1. Check Safety First",
            text:
                "Do not rush into traffic. Make sure the area is safe before helping the injured person.",
          ),
          _firstAidStep(
            icon: Icons.phone_in_talk,
            title: "2. Call Emergency Services",
            text:
                "Call 1990 or 119 immediately. Give location, number of injured people, and accident details.",
          ),
          _firstAidStep(
            icon: Icons.airline_seat_flat,
            title: "3. Do Not Move the Person",
            text:
                "If you suspect neck, back, or head injury, do not move the patient unless there is danger.",
          ),
          _firstAidStep(
            icon: Icons.bloodtype,
            title: "4. Stop Heavy Bleeding",
            text:
                "Use clean cloth or bandage and apply firm pressure on the bleeding area.",
          ),
          _firstAidStep(
            icon: Icons.air,
            title: "5. Check Breathing",
            text:
                "Check if the person is breathing. Keep airway open and stay with them until help arrives.",
          ),
          _firstAidStep(
            icon: Icons.health_and_safety,
            title: "6. Keep Patient Calm",
            text:
                "Talk gently, keep them warm, and do not give food or drink until medical help arrives.",
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.red[50],
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.red),
            ),
            child: const Row(
              children: [
                Icon(Icons.info, color: Colors.red),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    "This is only basic guidance. Always seek professional medical help for road accidents.",
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

  Widget _firstAidStep({
    required IconData icon,
    required String title,
    required String text,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.yellow[50],
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.black12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundColor: Colors.red,
            child: Icon(icon, color: Colors.white),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 6),
                Text(text, style: const TextStyle(fontSize: 15, height: 1.4)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
