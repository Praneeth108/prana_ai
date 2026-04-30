import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:prana_ai/pages/road_accident_details.dart';

class EvidencePage extends StatefulWidget {
  const EvidencePage({super.key});

  @override
  State<EvidencePage> createState() => _EvidencePageState();
}

class _EvidencePageState extends State<EvidencePage> {
  final TextEditingController locationController = TextEditingController();
  final TextEditingController vehicleController = TextEditingController();
  final TextEditingController noteController = TextEditingController();

  String? imagePath;

  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.camera);

    if (image != null) {
      setState(() {
        imagePath = image.path;
      });
    }
  }

  Future<void> saveEvidence() async {
    await FirebaseFirestore.instance.collection('road_accident_evidence').add({
      'location': locationController.text.trim(),
      'vehicleNumber': vehicleController.text.trim(),
      'notes': noteController.text.trim(),
      'imagePath': imagePath ?? '',
      'createdAt': FieldValue.serverTimestamp(),
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Evidence saved successfully")),
    );

    locationController.clear();
    vehicleController.clear();
    noteController.clear();

    setState(() {
      imagePath = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "CAPTURE EVIDENCE",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton.icon(
              onPressed: pickImage,
              icon: const Icon(Icons.camera_alt),
              label: const Text("Take Scene Photo"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
            ),

            const SizedBox(height: 12),

            TextField(
              controller: locationController,
              decoration: const InputDecoration(
                labelText: "Accident Location",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 10),

            TextField(
              controller: vehicleController,
              decoration: const InputDecoration(
                labelText: "Vehicle Number",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 10),

            TextField(
              controller: noteController,
              maxLines: 2,
              decoration: const InputDecoration(
                labelText: "Scene Notes",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 12),

            if (imagePath != null)
              Image.file(File(imagePath!), height: 200, fit: BoxFit.cover)
            else
              const Text(
                "No photo captured yet",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              ),

            const SizedBox(height: 12),

            SizedBox(
              height: 50,
              child: ElevatedButton(
                onPressed: saveEvidence,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.yellow,
                  foregroundColor: Colors.black,
                ),
                child: const Text(
                  "SAVE EVIDENCE",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),

            const SizedBox(height: 10),

            SizedBox(
              height: 50,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.folder),
                label: const Text("VIEW SAVED EVIDENCE"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ViewEvidencePage(),
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
}
