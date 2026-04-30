import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CallPage1926(),
    );
  }
}

class CallPage1926 extends StatelessWidget {
  const CallPage1926({super.key});

  // Function to call 119
  void _call1926() async {
    final Uri phoneUri = Uri.parse("tel:1926");

    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri, mode: LaunchMode.externalApplication);
    } else {
      debugPrint("Cannot launch dialer");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Emergency Call"),
        backgroundColor: Colors.red,
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: _call1926,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
          ),
          child: const Text("Call 1926", style: TextStyle(fontSize: 20)),
        ),
      ),
    );
  }
}