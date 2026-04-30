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
      home: CallPage(),
    );
  }
}

class CallPage extends StatelessWidget {
  const CallPage({super.key});

  // Function to call 119
  void _call119() async {
    final Uri phoneUri = Uri.parse("tel:119");

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
          onPressed: _call119,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
          ),
          child: const Text("Call 119", style: TextStyle(fontSize: 20)),
        ),
      ),
    );
  }
}