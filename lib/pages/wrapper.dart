import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:prana_ai/pages/authenticate/authenticate.dart';
import 'package:prana_ai/pages/Home/home.dart';
import 'package:prana_ai/pages/Doctor/doctor_home.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final user = snapshot.data;

        if (user == null) {
          return const Authenticate();
        }

        if (user.email == "doctor@gmail.com") {
          return const DoctorHomePage();
        }

        return const HomePage();
      },
    );
  }
}
