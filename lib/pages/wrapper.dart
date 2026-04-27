import 'package:flutter/material.dart';
import 'package:prana_ai/pages/authenticate/authenticate.dart';
import 'package:prana_ai/models/user.dart';
import 'package:prana_ai/pages/Home/home.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<MyUser?>(context);

    print(user);

    if (user == null) {
      return const Authenticate();
    } else {
      return const HomePage();
    }
  }
}
