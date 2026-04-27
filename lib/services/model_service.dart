import 'package:tflite_flutter/tflite_flutter.dart';

class ModelService {
  Interpreter? _interpreter;

  Future<void> loadModel() async {
    try {
      // Ensure the path matches your pubspec.yaml exactly
      _interpreter = await Interpreter.fromAsset(
        'assets/model/model_unquant.tflite',
      );
      print("Model loaded successfully!");
    } catch (e) {
      print("Failed to load model: $e");
    }
  }

  Interpreter? get interpreter => _interpreter;
}
