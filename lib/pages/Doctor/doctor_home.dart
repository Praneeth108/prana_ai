import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:prana_ai/pages/login_page.dart';
import 'package:prana_ai/services/auth.dart';

class DoctorHomePage extends StatefulWidget {
  const DoctorHomePage({super.key});

  @override
  State<DoctorHomePage> createState() => _DoctorHomePageState();
}

class _DoctorHomePageState extends State<DoctorHomePage> {
  final String uid = "doctor1";
  final AuthService _auth = AuthService();
  bool isDialogShowing = false;

  // Doctor Online
  Future<void> goOnline() async {
    await FirebaseFirestore.instance.collection('doctors').doc(uid).set({
      'name': 'Dr Silva',
      'isOnline': true,
      'inCall': false,
    }, SetOptions(merge: true));
  }

  // Doctor Offline
  Future<void> goOffline() async {
    await FirebaseFirestore.instance.collection('doctors').doc(uid).update({
      'isOnline': false,
    });
  }

  // Accept Call
  Future<void> acceptCall(String callId) async {
    await FirebaseFirestore.instance.collection('calls').doc(callId).update({
      'status': 'accepted',
    });

    await FirebaseFirestore.instance.collection('doctors').doc(uid).update({
      'inCall': true,
    });
  }

  // Reject Call
  Future<void> rejectCall(String callId) async {
    await FirebaseFirestore.instance.collection('calls').doc(callId).update({
      'status': 'rejected',
    });
  }

  // Listen Incoming Calls
  void listenIncomingCalls() {
    FirebaseFirestore.instance
        .collection('calls')
        .where('doctorId', isEqualTo: uid)
        .where('status', isEqualTo: 'waiting')
        .snapshots()
        .listen((snapshot) {
          if (snapshot.docs.isNotEmpty && mounted) {
            var call = snapshot.docs.first;

            if (!isDialogShowing) {
              showIncomingCallDialog(call.id);
            }
          }
        });
  }

  // Popup Dialog
  void showIncomingCallDialog(String callId) {
    isDialogShowing = true;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        title: const Text("Incoming Call"),
        content: const Text("A patient is calling you."),
        actions: [
          TextButton(
            onPressed: () async {
              Navigator.pop(context);

              // reject status
              await FirebaseFirestore.instance
                  .collection('calls')
                  .doc(callId)
                  .update({'status': 'rejected'});

              isDialogShowing = false;
            },
            child: const Text("Reject"),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.pop(context);

              // accept status
              await FirebaseFirestore.instance
                  .collection('calls')
                  .doc(callId)
                  .update({'status': 'accepted'});

              await FirebaseFirestore.instance
                  .collection('doctors')
                  .doc(uid)
                  .update({'inCall': true});

              isDialogShowing = false;
            },
            child: const Text("Accept"),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await goOnline();
      listenIncomingCalls();
    });
  }

  @override
  void dispose() {
    goOffline();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 1, 31, 56),
      appBar: AppBar(
        title: Row(
          children: [
            SizedBox(width: 10),
            Text(
              "Doctor Dashboard",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        actions: [
          Text(
            "Logout",
            style: TextStyle(
              fontSize: 16,
              color: const Color.fromARGB(255, 0, 0, 0),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.logout, color: Color.fromARGB(255, 3, 3, 3)),
            onPressed: () async {
              await _auth.signOut();
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(onPressed: goOnline, child: const Text("Go Online")),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: goOffline,
              child: const Text("Go Offline"),
            ),
            const SizedBox(height: 30),
            const Text("Waiting for patient calls..."),
          ],
        ),
      ),
    );
  }
}
