import 'package:flutter/material.dart';
import 'package:prana_ai/pages/burn_first_aid_page.dart';

class BurnScreen extends StatelessWidget {
  const BurnScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],

      appBar: AppBar(
        title: const Text("Burns First Aid"),
        backgroundColor: Colors.orange,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _infoCard(),

            const SizedBox(height: 15),

            _burnButton(context, "Thermal Burns"),
            _burnButton(context, "Chemical Burns"),
            _burnButton(context, "Radiation Burns"),
            _burnButton(context, "Electrical Burns"),
            _burnButton(context, "Inhalation Burns"),
            _burnButton(context, "Friction Burns"),
            _burnButton(context, "Cold Burns"),

            const SizedBox(height: 20),

            _emergencyBox(),
          ],
        ),
      ),
    );
  }

  Widget _infoCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.orange),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Burns First Aid Guide",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.orange,
            ),
          ),
          SizedBox(height: 10),
          Text(
            "Burns are injuries caused by heat, chemicals, electricity or radiation. Immediate first aid reduces damage and complications.",
          ),
        ],
      ),
    );
  }

  Widget _burnButton(BuildContext context, String type) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red,
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => BurnFirstAidPage(burnType: type)),
          );
        },
        child: Text(
          type,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  // ✅ UPDATED EMERGENCY BOX WITH ICONS
  Widget _emergencyBox() {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.red[100],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.red),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              Icon(Icons.warning, color: Colors.red),
              SizedBox(width: 8),
              Text(
                "Emergency Guidance",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          _emergencyItem(
            Icons.local_hospital,
            "Severe burns require immediate hospital treatment",
          ),
          _emergencyItem(Icons.block, "Do not apply ice, oil, or toothpaste"),
          _emergencyItem(Icons.clean_hands, "Keep area clean and covered"),
          _emergencyItem(Icons.access_time, "Seek medical help immediately"),
        ],
      ),
    );
  }

  Widget _emergencyItem(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Icon(icon, color: Colors.red),
          const SizedBox(width: 10),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }
}
