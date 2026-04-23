import 'package:flutter/material.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[700],
      body: SafeArea(
        child: Center(
          child: Container(
            width: 350,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(10),
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Back Button
                  Align(
                    alignment: Alignment.topLeft,
                    child: CircleAvatar(
                      backgroundColor: Colors.grey[300],
                      child: Icon(Icons.arrow_back, color: Colors.grey[700]),
                    ),
                  ),

                  const SizedBox(height: 10),

                  // Logo
                  Image.asset(
                    "assets/images/logo.png", // replace with your logo
                    height: 80,
                  ),

                  const SizedBox(height: 10),

                  const Text(
                    "PRANA AID",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueGrey,
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Username
                  buildTextField("User name", Icons.person),

                  const SizedBox(height: 10),

                  // Email
                  buildTextField("Email", Icons.email),

                  const SizedBox(height: 10),

                  // Password
                  buildTextField("Password", Icons.lock, isPassword: true),

                  const SizedBox(height: 10),

                  // Telephone
                  buildTextField("Telephone", Icons.phone, hint: "07X-XXXXXXX"),

                  const SizedBox(height: 20),

                  // Sign Up Button
                  Container(
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

                  const SizedBox(height: 10),

                  const Text(
                    "OR",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),

                  const SizedBox(height: 5),

                  const Text("Sign Up using"),

                  const SizedBox(height: 10),

                  // Social Buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      socialIcon("assets/images/google.png"),
                      socialIcon("assets/images/facebook.png"),
                      socialIcon("assets/images/instagram.png"),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // TextField Widget
  Widget buildTextField(
    String label,
    IconData icon, {
    bool isPassword = false,
    String hint = "",
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        const SizedBox(height: 5),
        TextField(
          obscureText: isPassword,
          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: Icon(icon, size: 20), // smaller icon
            suffixIcon: isPassword
                ? const Icon(Icons.visibility_off, size: 20)
                : null,
            isDense: true, // important
            contentPadding: const EdgeInsets.symmetric(
              vertical: 10, // reduce height
              horizontal: 10,
            ),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
          ),
        ),
      ],
    );
  }

  // Social Icon Widget
  Widget socialIcon(String path) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Image.asset(path, height: 25, width: 25),
    );
  }
}
