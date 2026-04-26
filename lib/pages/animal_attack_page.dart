import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class AnimalAttackPage extends StatefulWidget {
  const AnimalAttackPage({super.key});

  @override
  State<AnimalAttackPage> createState() => _AnimalAttackPageState();
}

class _AnimalAttackPageState extends State<AnimalAttackPage> {
  final ImagePicker _picker = ImagePicker();
  File? _image;

  // 📸 OPEN CAMERA
  Future<void> openCamera() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],

      body: SafeArea(
        child: Column(
          children: [
            // 🔝 HEADER
            Container(
              padding: const EdgeInsets.all(12),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.orange, Colors.yellow],
                ),
              ),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Animal Attack",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        "Select Specific Type",
                        style: TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),

            // 📸 QUICK IDENTIFY BOX
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(horizontal: 40),
                  height: 220, // ✅ SAME SIZE LIKE IMAGE
                  decoration: BoxDecoration(
                    color: Colors.black87,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Colors.grey),
                  ),
                  child: _image == null
                      ? const Center(
                          child: Text(
                            "Quick Identify",
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        )
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image.file(_image!, fit: BoxFit.cover),
                        ),
                ),

                // 🔴 CAMERA BUTTON
                Positioned(
                  bottom: 0,
                  child: GestureDetector(
                    onTap: openCamera,
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 3),
                      ),
                      child: const Icon(
                        Icons.camera_alt,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 30),

            // 📘 HOW TO SCAN
            Container(
              margin: const EdgeInsets.all(12),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.blue[100],
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "How to Scan",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 5),
                  Text("1. Position the animal within the camera frame"),
                  Text("2. Ensure good lighting"),
                  Text("3. Tap capture button"),
                ],
              ),
            ),

            const SizedBox(height: 5),

            // 🟧 LIST
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(10),
                children: [
                  emergencyTile("Snake Bite", "CRITICAL", Colors.red),
                  emergencyTile("Insect Sting / Bite", "LOW", Colors.green),
                  emergencyTile("Dogs , Cats Bite", "HIGH", Colors.orange),
                  emergencyTile("Other Wild Animal", "HIGH", Colors.purple),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 🔹 TILE
  Widget emergencyTile(String title, String level, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Text(
              level,
              style: const TextStyle(color: Colors.white, fontSize: 10),
            ),
          ),
        ],
      ),
    );
  }
}
