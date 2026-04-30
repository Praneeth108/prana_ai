import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ViewEvidencePage extends StatelessWidget {
  const ViewEvidencePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Saved Evidence"),
        backgroundColor: Colors.yellow,
        foregroundColor: Colors.black,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('road_accident_evidence')
            .orderBy('createdAt', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text("Something went wrong"));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final evidenceDocs = snapshot.data!.docs;

          if (evidenceDocs.isEmpty) {
            return const Center(child: Text("No evidence saved yet"));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: evidenceDocs.length,
            itemBuilder: (context, index) {
              final data = evidenceDocs[index].data() as Map<String, dynamic>;

              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                child: ListTile(
                  leading: const Icon(Icons.folder, color: Colors.red),
                  title: Text(
                    data['vehicleNumber'] ?? 'No vehicle number',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    "Location: ${data['location'] ?? ''}\n"
                    "Notes: ${data['notes'] ?? ''}",
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
