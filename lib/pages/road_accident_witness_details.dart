import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:prana_ai/pages/road_accident_witness.dart';
import 'package:prana_ai/pages/road_accident_firstaid.dart';
import 'package:prana_ai/pages/road_accident_evidence.dart';
import 'package:prana_ai/pages/road_accident_protocol.dart';

class RoadAccident extends StatelessWidget {
  const RoadAccident({super.key});

  @override
  Widget build(BuildContext context) {
    return const AccidentHomeScreen();
  }
}

class AccidentHomeScreen extends StatelessWidget {
  const AccidentHomeScreen({super.key});

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(launchUri)) {
      await launchUrl(launchUri);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.red,
        elevation: 4,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'ROAD ACCIDENT HUB',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w900,
            fontSize: 22,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            _buildActionCard(
              context,
              Icons.medical_services,
              "Emergency First Aid Guidance",
              const FirstAidPage(),
            ),
            _buildActionCard(
              context,
              Icons.camera_alt,
              "Capture Scene Evidence",
              const EvidencePage(),
            ),
            _buildActionCard(
              context,
              Icons.people,
              "Witness Information Gathering",
              const WitnessPage(),
            ),
            _buildActionCard(
              context,
              Icons.contact_emergency,
              "Emergency Contact Protocols",
              const ProtocolsPage(),
            ),

            const SizedBox(height: 30),

            Row(
              children: [
                Expanded(
                  child: _buildCallButton(
                    "CALL 1990",
                    Icons.phone,
                    () => _makePhoneCall('1990'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildCallButton(
                    "CALL 119",
                    Icons.local_police,
                    () => _makePhoneCall('119'),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 25),
          ],
        ),
      ),
    );
  }

  Widget _buildActionCard(
    BuildContext context,
    IconData icon,
    String title,
    Widget page,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.black, width: 2),
        borderRadius: BorderRadius.circular(15),
      ),
      child: ListTile(
        leading: Icon(icon, color: Colors.red, size: 30),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 16),
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          size: 18,
          color: Colors.red,
        ),
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => page),
        ),
      ),
    );
  }

  Widget _buildCallButton(String label, IconData icon, VoidCallback onPressed) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, color: Colors.white),
      label: Text(
        label,
        style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 15),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 18),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      ),
    );
  }
}
