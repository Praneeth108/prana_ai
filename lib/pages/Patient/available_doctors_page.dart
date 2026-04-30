import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:prana_ai/pages/callpages/videoCall_page.dart';

class AvailableDoctorsPage extends StatelessWidget {
  const AvailableDoctorsPage({super.key});

  Future<void> callDoctor(BuildContext context, String doctorId) async {
    String callId = FirebaseFirestore.instance.collection('calls').doc().id;

    await FirebaseFirestore.instance.collection('calls').doc(callId).set({
      'patientId': 'patient1', // later replace with real logged user id
      'doctorId': doctorId,
      'channelId': callId,
      'status': 'waiting',
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Call request sent to doctor...")),
    );

    // ✅ Listen for doctor response
    FirebaseFirestore.instance
        .collection('calls')
        .doc(callId)
        .snapshots()
        .listen((doc) {
          if (doc.exists && doc['status'] == 'accepted') {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => VideoCallPage(channelName: doc['channelId']),
              ),
            );
          }

          if (doc.exists && doc['status'] == 'rejected') {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Doctor rejected the call")),
            );
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Available Doctors")),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('doctors')
            .where('isOnline', isEqualTo: true)
            .where('inCall', isEqualTo: false)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          var doctors = snapshot.data!.docs;

          if (doctors.isEmpty) {
            return const Center(child: Text("No doctors available"));
          }

          return ListView.builder(
            itemCount: doctors.length,
            itemBuilder: (context, index) {
              var doc = doctors[index];

              return Card(
                margin: const EdgeInsets.all(10),
                child: ListTile(
                  title: Text(doc['name']),
                  subtitle: const Text("Online Doctor"),
                  trailing: ElevatedButton(
                    child: const Text("Call"),
                    onPressed: () async {
                      await callDoctor(context, doc.id);

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              VideoCallPage(channelName: "test_channel"),
                        ),
                      );
                    },
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
