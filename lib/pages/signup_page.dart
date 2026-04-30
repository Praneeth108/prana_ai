import 'package:flutter/material.dart';
import 'package:prana_ai/services/auth.dart';

class SignUpPage extends StatefulWidget {
  final Function toggleView;

  const SignUpPage({super.key, required this.toggleView});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final AuthService _auth = AuthService();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  String error = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: SafeArea(
        top: false,
        bottom: false,
        child: Container(
          width: double.infinity,
          height: double.infinity,
          padding: const EdgeInsets.all(20),
          color: Colors.grey[10],
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 20),

                Image.asset("assets/images/logo.jpeg", height: 150),

                const SizedBox(height: 30),

                _input(nameController, "User name", Icons.person),
                _input(emailController, "Email", Icons.email),
                _input(passwordController, "Password", Icons.lock, true),
                _input(phoneController, "Telephone", Icons.phone),

                const SizedBox(height: 10),

                Text(error, style: const TextStyle(color: Colors.red)),

                const SizedBox(height: 10),

                // ✅ SIGN UP BUTTON
                GestureDetector(
                  onTap: () async {
                    String email = emailController.text.trim();
                    String password = passwordController.text.trim();

                    if (email.isEmpty || password.length < 6) {
                      setState(() {
                        error = "Enter valid email & password (6+ chars)";
                      });
                      return;
                    }

                    final result = await _auth.register(email, password);

                    if (result == null) {
                      setState(() {
                        error = "Signup failed";
                      });
                    }
                  },
                  child: Container(
                    width: 250,
                    height: 50,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Colors.green, Colors.blue],
                      ),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: const Center(
                      child: Text(
                        "Sign Up",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                // 🔁 SWITCH TO LOGIN
                TextButton(
                  onPressed: () {
                    widget.toggleView();
                  },
                  child: const Text(
                    "Already have an account?   Sign In",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _input(
    TextEditingController controller,
    String label,
    IconData icon, [
    bool isPassword = false,
  ]) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: TextField(
        controller: controller,
        obscureText: isPassword,
        decoration: InputDecoration(
          prefixIcon: Icon(icon),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
          labelText: label,
        ),
      ),
    );
  }
}
