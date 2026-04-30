import 'package:flutter/material.dart';

class ElectricShockPage extends StatelessWidget {
  const ElectricShockPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        title: const Text("Electric Shock"),
        backgroundColor: Colors.blue,
        elevation: 0,
      ),

      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [

          // ⚡ TITLE
          const Text(
            "Electric Shock First Aid",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 10),

          const Text(
            "Electric shock occurs when electricity passes through the body. "
            "It can cause serious injuries including burns, heart problems, or death.",
            style: TextStyle(fontSize: 16),
          ),

          const SizedBox(height: 25),

          // ✅ WHAT TO DO
          _sectionBox(
            title: "What To Do",
            color: Colors.green,
            items: [
              _item(Icons.power, "Turn off the power source if safe"),
              _item(Icons.pan_tool_alt, "Use a dry object to separate the person"),
              _item(Icons.call, "Call emergency services immediately"),
              _item(Icons.favorite, "Check breathing and pulse"),
              _item(Icons.health_and_safety, "Start CPR if necessary"),
              _item(Icons.airline_seat_flat, "Keep the person still and warm"),
            ],
          ),

          const SizedBox(height: 20),

          // ❌ WHAT NOT TO DO
          _sectionBox(
            title: "What NOT To Do",
            color: Colors.red,
            items: [
              _item(Icons.block, "Do not touch if still connected"),
              _item(Icons.water_drop, "Do not use water near electricity"),
              _item(Icons.directions_run, "Do not move unnecessarily"),
              _item(Icons.error, "Do not ignore burns or unconsciousness"),
            ],
          ),

          const SizedBox(height: 20),

          // 🚨 EMERGENCY ALERT
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.red.shade50,
              border: Border.all(color: Colors.red),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: const [
                Icon(Icons.warning, color: Colors.red),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    "This is a medical emergency. Get professional help immediately.",
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // 🚑 EMERGENCY GUIDANCE
          _sectionBox(
            title: "Emergency Guidance",
            color: Colors.blue,
            items: [
              _item(Icons.call, "Call ambulance immediately"),
              _item(Icons.local_hospital, "Go to nearest hospital"),
              _item(Icons.report, "Inform it is an electric shock case"),
              _item(Icons.timer, "Do not delay treatment"),
            ],
          ),
        ],
      ),
    );
  }

  // 🔹 SECTION BOX WITH ICON ITEMS
  Widget _sectionBox({
    required String title,
    required Color color,
    required List<Widget> items,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border(
          left: BorderSide(color: color, width: 5),
        ),
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 10),
          ...items,
        ],
      ),
    );
  }

  // 🔹 ICON ITEM ROW
  Widget _item(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20, color: Colors.blueAccent),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 15),
            ),
          ),
        ],
      ),
    );
  }
}
