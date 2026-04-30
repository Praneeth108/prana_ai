import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:prana_ai/pages/road_accident_witness_details.dart';

class WitnessPage extends StatefulWidget {
  const WitnessPage({super.key});

  @override
  State<WitnessPage> createState() => _WitnessPageState();
}

class _WitnessPageState extends State<WitnessPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController statementController = TextEditingController();

  Future<void> saveWitness() async {
    await FirebaseFirestore.instance.collection('road_accident_witnesses').add({
      'name': nameController.text.trim(),
      'phone': phoneController.text.trim(),
      'statement': statementController.text.trim(),
      'createdAt': FieldValue.serverTimestamp(),
    });

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text("Witness information saved")));

    nameController.clear();
    phoneController.clear();
    statementController.clear();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      backgroundColor: Colors.yellow,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.black),
        onPressed: () => Navigator.pop(context),
      ),
      title: const Text(
        "WITNESS INFO",
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      ),
    ),
    body: SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const Icon(Icons.people, size: 80, color: Colors.red),
          const SizedBox(height: 15),

          const Text(
            "Collect witness details calmly and respectfully.",
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 20),

          TextField(
            controller: nameController,
            decoration: const InputDecoration(
              labelText: "Witness Name",
              border: OutlineInputBorder(),
            ),
          ),

          const SizedBox(height: 15),

          TextField(
            controller: phoneController,
            keyboardType: TextInputType.phone,
            decoration: const InputDecoration(
              labelText: "Witness Phone Number",
              border: OutlineInputBorder(),
            ),
          ),

          const SizedBox(height: 15),

          TextField(
            controller: statementController,
            maxLines: 5,
            decoration: const InputDecoration(
              labelText: "What did the witness see?",
              border: OutlineInputBorder(),
            ),
          ),

          const SizedBox(height: 20),

          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: saveWitness,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              child: const Text(
                "SAVE WITNESS DETAILS",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
          const SizedBox(height: 12),

          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton.icon(
              icon: const Icon(Icons.folder),
              label: const Text("VIEW SAVED WITNESSES"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.yellow,
                foregroundColor: Colors.black,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ViewWitnessPage(),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    ),
  );
}
