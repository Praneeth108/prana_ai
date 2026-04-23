import 'package:flutter/material.dart';
import 'package:prana_ai/pages/authenticate/welcome_page.dart';

class Authenticate extends StatefulWidget {
  const Authenticate({super.key});

  @override
  State<Authenticate> createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  @override
  Widget build(BuildContext context) {
    return WelcomePage();
  }
}
