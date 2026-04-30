import 'package:flutter/material.dart';
import 'package:prana_ai/services/auth.dart';
import 'package:prana_ai/services/google_sign_in.dart';

class LoginPage extends StatefulWidget {
  final Function toggleView;

  const LoginPage({super.key, required this.toggleView});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final AuthService _auth = AuthService();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  String error = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "PRANA   AID",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 36,
            color: Color.fromARGB(255, 2, 161, 185),
          ),
        ),
      ),
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(156, 229, 229, 229),
              Color.fromARGB(156, 250, 249, 246),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 60),

              const CircleAvatar(
                radius: 80,
                backgroundImage: AssetImage("assets/images/profile1.jpg"),
              ),

              const SizedBox(height: 50),

              // EMAIL
              _inputField(
                controller: emailController,
                label: "Email",
                icon: Icons.email,
                obscure: false,
              ),

              const SizedBox(height: 20),

              // PASSWORD
              _inputField(
                controller: passwordController,
                label: "Password",
                icon: Icons.lock,
                obscure: true,
              ),

              const SizedBox(height: 20),

              Text(error, style: const TextStyle(color: Colors.red)),

              const SizedBox(height: 40),

              // ✅ LOGIN BUTTON
              GestureDetector(
                onTap: () async {
                  final email = emailController.text.trim();
                  final password = passwordController.text.trim();

                  final result = await _auth.signIn(email, password);

                  if (result == null) {
                    setState(() {
                      error = "Invalid email or password";
                    });
                  }
                },
                child: Container(
                  width: 250,
                  height: 50,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        Color.fromARGB(255, 98, 255, 111),
                        Color.fromARGB(255, 50, 165, 157),
                        Color.fromARGB(255, 1, 9, 147),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: const Center(
                    child: Text(
                      "Login",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // 🔁 SWITCH TO REGISTER
              TextButton(
                onPressed: () {
                  widget.toggleView();
                },
                child: const Text(
                  "Don't have an account?   Register",
                  style: TextStyle(fontSize: 16),
                ),
              ),

              const SizedBox(height: 30),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  socialIcon(
                    'assets/images/google.png',
                    onTap: () async {
                      await signInWithGoogle();
                    },
                  ),
                  const SizedBox(width: 20),
                  socialIcon('assets/images/facebook.png'),
                  const SizedBox(width: 20),
                  socialIcon('assets/images/instagram.png'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _inputField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    required bool obscure,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: TextField(
        controller: controller,
        obscureText: obscure,
        decoration: InputDecoration(
          prefixIcon: Icon(icon),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
          labelText: label,
        ),
      ),
    );
  }

  static Widget socialIcon(String asset, {VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Image.asset(asset),
        ),
      ),
    );
  }
}
