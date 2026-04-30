import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:image/image.dart' as img;
import 'package:flutter/services.dart';

class AnimalAttackPage extends StatefulWidget {
  const AnimalAttackPage({super.key});

  @override
  State<AnimalAttackPage> createState() => _AnimalAttackPageState();
}

class _AnimalAttackPageState extends State<AnimalAttackPage> {
  final ImagePicker _picker = ImagePicker();
  File? _image;

  Interpreter? _interpreter;
  List<String> _labels = [];

  String result = "No result";

  @override
  void initState() {
    super.initState();
    loadModel();
    loadLabels(); // ✅ FIXED
  }

  // ✅ LOAD MODEL
  Future<void> loadModel() async {
    _interpreter = await Interpreter.fromAsset(
      'assets/model/model_unquant.tflite',
    );
  }

  // ✅ LOAD LABELS (FIXED with safety)
  Future<void> loadLabels() async {
    final data = await rootBundle.loadString('assets/model/labels.txt');

    // Split karala, empty lines ain karanna
    _labels = data
        .split('\n')
        .map((e) => e.trim()) // isaraha pitipassa thiyana his than makanna
        .where((e) => e.isNotEmpty) // his peli ain karanna
        .toList();

    print("Labels loaded: ${_labels.length}"); // Debug karanna lesi wenna
  }

  // 📸 OPEN CAMERA
  Future<void> openCamera() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      _image = File(pickedFile.path);

      await runModel();

      setState(() {});
    }
  }

  // 🤖 RUN MODEL (FULL FIXED VERSION)
  Future<void> runModel() async {
    if (_image == null || _interpreter == null) return;

    // 🔹 read image
    final bytes = await _image!.readAsBytes();
    img.Image? originalImage = img.decodeImage(bytes);

    if (originalImage == null) return;

    // 🔹 resize (VERY IMPORTANT)
    img.Image resizedImage = img.copyResize(
      originalImage,
      width: 224,
      height: 224,
    );

    // 🔹 convert to tensor
    var input = List.generate(
      1,
      (_) => List.generate(
        224,
        (_) => List.generate(224, (_) => List.filled(3, 0.0)),
      ),
    );

    for (int y = 0; y < 224; y++) {
      for (int x = 0; x < 224; x++) {
        final pixel = resizedImage.getPixel(x, y);

        input[0][y][x][0] = pixel.r / 255.0;
        input[0][y][x][1] = pixel.g / 255.0;
        input[0][y][x][2] = pixel.b / 255.0;
      }
    }

    // 🔹 output
    var output = List.generate(1, (_) => List.filled(_labels.length, 0.0));

    _interpreter!.run(input, output);

    // 🔹 output
    // labels.length wenuwata, 16 kiyala direct danna ho safety check ekak danna.
    // Hondama de thamai 16 (model eke size eka) use karana eka:
    output = List.generate(1, (_) => List.filled(16, 0.0));

    _interpreter!.run(input, output);

    // 🔹 find result
    double maxScore = output[0][0];
    int maxIndex = 0;

    // Methana _labels.length noda output eke size eka danna.
    for (int i = 0; i < 16; i++) {
      if (output[0][i] > maxScore) {
        maxScore = output[0][i];
        maxIndex = i;
      }
    }

    setState(() {
      // Index eka labels.length ekata wada wedinm kiyala check karanawa.
      if (maxIndex < _labels.length) {
        result =
            "${_labels[maxIndex]} (${(maxScore * 100).toStringAsFixed(2)}%)";
      } else {
        result = "Unknown (Index $maxIndex)";
      }
    });
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
                        style: TextStyle(fontWeight: FontWeight.bold),
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

            // 📸 IMAGE BOX
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(horizontal: 40),
                  height: 220,
                  decoration: BoxDecoration(
                    color: Colors.black87,
                    borderRadius: BorderRadius.circular(15),
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

            const SizedBox(height: 20),

            // 🤖 RESULT
            Text(
              "Result: $result",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
