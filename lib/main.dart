import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:prana_ai/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:prana_ai/models/user.dart';
import 'package:prana_ai/pages/animal_attack_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return StreamProvider<MyUser?>.value(
      value: AuthService().user,
      initialData: null,
      child: MaterialApp(
        home: const AnimalAttackPage(), // Wrapper(), // animalattackpage()
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
