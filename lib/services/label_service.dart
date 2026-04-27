import 'package:flutter/services.dart';

Future<List<String>> loadLabels() async {
  final data = await rootBundle.loadString('assets/model/labels.txt');
  final labels = data.split('\n');
  return labels;
}
