import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(156, 229, 229, 229),
              Color.fromARGB(156, 250, 249, 246),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Top Icons
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    CircleAvatar(
                      backgroundColor: Color.fromARGB(255, 255, 255, 255),
                      child: Icon(Icons.arrow_back, color: Colors.black),
                    ),
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.edit,
                        color: Color.fromARGB(255, 255, 77, 0),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 40),

              // Avatar Image
              const CircleAvatar(
                radius: 80,
                backgroundImage: AssetImage("assets/images/doctor.png"),
              ),

              const SizedBox(height: 80),

              // Username
              _inputField(
                label: "User name",
                icon: Icons.person,
                obscure: false,
              ),

              const SizedBox(height: 30),

              // Password
              _inputField(label: "Password", icon: Icons.lock, obscure: true),

              const SizedBox(height: 5),

              // Forgot password
              const Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: EdgeInsets.only(right: 50),
                  child: Text(
                    "Forgot Password",
                    style: TextStyle(fontSize: 12),
                  ),
                ),
              ),

              const SizedBox(height: 100),

              // Login Button
              Container(
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

              const Spacer(),

              // Bottom Icons
              Container(
                padding: const EdgeInsets.symmetric(vertical: 15),
                decoration: const BoxDecoration(color: Colors.white24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: const [
                    Icon(Icons.calendar_month, size: 40),
                    Icon(Icons.person, size: 40),
                    Icon(Icons.medical_services, size: 40),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Reusable input field
  Widget _inputField({
    required String label,
    required IconData icon,
    required bool obscure,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: TextField(
        obscureText: obscure,
        decoration: InputDecoration(
          isDense: true,
          contentPadding: const EdgeInsets.symmetric(
            vertical: 8,
            horizontal: 10,
          ),
          prefixIcon: Icon(icon),
          suffixIcon: obscure ? const Icon(Icons.visibility_off) : null,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
          labelText: label,
        ),
      ),
    );
  }
}
