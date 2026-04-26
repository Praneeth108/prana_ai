import 'package:flutter/material.dart';
import 'package:prana_ai/pages/ayurvedic_page.dart';

class FirstAidPage extends StatelessWidget {
  const FirstAidPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],

      body: SafeArea(
        child: Column(
          children: [
            //  HEADER
            Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.orange, Colors.yellow],
                ),
              ),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),

                  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "First Aid Guide",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Cuts & Wounds",
                        style: TextStyle(color: Colors.white70, fontSize: 16),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Step-by-Step Instructions",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),

                    const SizedBox(height: 20),

                    stepCard(
                      "Ensure Scene Safety",
                      "Check the area is safe for you and the victim before approaching",
                      "CRITICAL",
                      Colors.red,
                      1,
                    ),

                    stepCard(
                      "Check Responsiveness",
                      "Gently tap the person and ask Are you okay? in a loud voice.",
                      "CRITICAL",
                      Colors.red,
                      2,
                    ),

                    stepCard(
                      "Call Emergency Services",
                      "Call 911 or local emergency number immediately if unconscious or severe injury.",
                      "",
                      Colors.blue,
                      3,
                    ),

                    stepCard(
                      "Apply Direct Pressure",
                      "If bleeding, apply firm, direct pressure to the wound with clean cloth.",
                      "",
                      Colors.blue,
                      4,
                    ),

                    stepCard(
                      "Keep Person Comfortable",
                      "Reassure the person, keep them warm, and position comfortably.",
                      "",
                      Colors.blue,
                      5,
                    ),

                    const SizedBox(height: 15),

                    // ✅ DO SECTION
                    infoBox("DO - Important Actions", Colors.green, [
                      "Stay calm and reassure the victim",
                      "Apply steady pressure",
                      "Keep the person warm",
                      "Monitor vital signs",
                      "Document what happened",
                    ]),

                    const SizedBox(height: 10),

                    // ❌ DON'T SECTION
                    infoBox("DON'T - Avoid These", Colors.red, [
                      "Don't move  person if spine injury suspected",
                      "Don't give anything to eat or drink",
                      "Don't remove deeply embedded objects",
                      "Don't apply ice directly to skin",
                      "Don't leave victim alone",
                    ]),

                    const SizedBox(height: 10),

                    // 🌿 AYURVEDIC
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.green[100],
                        borderRadius: BorderRadius.circular(20),
                      ),

                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Ayurvedic First-Aid Support",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 10),

                          const Text(
                            "• Complementary herbal remedies \n    available for this type of injury.",
                            style: TextStyle(
                              fontSize: 14,
                              color: Color.fromARGB(255, 4, 154, 39),
                            ),
                          ),

                          const SizedBox(height: 12),
                          Container(
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [
                                  Color.fromARGB(255, 41, 237, 54),
                                  Color.fromARGB(255, 0, 41, 10),
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(30),
                            ),

                            child: Center(
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.transparent,
                                  shadowColor: Colors.transparent,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const AyurvedicPage(),
                                    ),
                                  );
                                },
                                child: const Text(
                                  "View Ayurvedic Support Options",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 10),

                    //  WARNING
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.orange[100],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Seek Immediate Medical Help If:",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "• Bleeding doesn't stop after 10 minutes of pressure",
                          ),
                          Text("• Person becomes unconscious or confused"),
                          Text("• Symptoms worsen or new symptoms appear"),
                          Text(
                            "• Signs of infection develop (fever, increased pain,redness)",
                          ),
                          Text("• You're unsure about the severity"),
                        ],
                      ),
                    ),

                    const SizedBox(height: 25),

                    //  BUTTON
                    Center(
                      child: Container(
                        width: 200,
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: const Text(
                          "Find Nearby Hospitals",
                          textAlign: TextAlign.center, // 🔥 center text inside
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 🔹 STEP CARD
  Widget stepCard(
    String title,
    String subtitle,
    String tag,
    Color color,
    int step,
  ) {
    return Container(
      height: 180, // 🔥 SAME HEIGHT FOR ALL
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color.fromARGB(255, 164, 162, 162)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundColor: color.withOpacity(0.2),
            child: Text("$step"),
          ),
          const SizedBox(width: 12),

          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center, // 🔥 center text
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(width: 5),
                    if (tag.isNotEmpty)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: color,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text(
                          tag,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Color.fromARGB(255, 73, 72, 72),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // 🔹 INFO BOX
  Widget infoBox(String title, Color color, List<String> items) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, color: color),
          ),
          const SizedBox(height: 10),
          ...items.map((e) => Text("• $e")),
        ],
      ),
    );
  }
}
