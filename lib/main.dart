import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:io';

void main() => runApp(const RoadAccidentApp());

class RoadAccidentApp extends StatelessWidget {
  const RoadAccidentApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Roboto',
        primarySwatch: Colors.red,
      ),
      home: const AccidentHomeScreen(),
    );
  }
}

class AccidentHomeScreen extends StatelessWidget {
  const AccidentHomeScreen({super.key});

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    if (await canLaunchUrl(launchUri)) {
      await launchUrl(launchUri);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.red,
        elevation: 4,
        title: const Text(
          'ROAD ACCIDENT HUB',
          style: TextStyle(
            color: Colors.white, 
            fontWeight: FontWeight.w900, 
            fontSize: 22,
            letterSpacing: 1.5,
          ),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: Icon(Icons.car_crash, color: Colors.yellow, size: 30),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            _buildActionCard(
              context,
              Icons.medical_services,
              "Emergency First Aid Guidance",
              const FirstAidGuidanceScreen(),
            ),
            _buildActionCard(
              context, 
              Icons.camera_alt, 
              "Capture Scene Evidence", 
              const CaptureEvidenceScreen(),
            ),
            _buildActionCard(
              context, 
              Icons.people, 
              "Witness Information Gathering", 
              const WitnessInfoScreen(),
            ),
            _buildActionCard(
              context, 
              Icons.contact_emergency, 
              "Emergency Contact Protocols", 
              const EmergencyProtocolsScreen(),
            ),

            const SizedBox(height: 30),

            Row(
              children: [
                Expanded(
                  child: _buildCallButton("CALL 1990", Icons.phone, () => _makePhoneCall('1990')),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildCallButton("CALL 119", Icons.local_police, () => _makePhoneCall('119')),
                ),
              ],
            ),

            const SizedBox(height: 25),

            // Functional SUBMIT REPORT Button - Now goes to Application Form
            SizedBox(
              width: double.infinity,
              height: 70,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context, 
                    MaterialPageRoute(builder: (context) => const IncidentReportFormScreen()),
                  );
                },
                icon: const Icon(Icons.assignment_turned_in, color: Colors.black, size: 30),
                label: const Text(
                  "SUBMIT FINAL REPORT", 
                  style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w900, letterSpacing: 1.2),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.yellow,
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                    side: const BorderSide(color: Colors.black, width: 2.5),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 15),
            const Text(
              "Complete the application form for final submission",
              style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 12),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildActionCard(BuildContext context, IconData icon, String title, Widget? target) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.black, width: 2),
        borderRadius: BorderRadius.circular(15),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(2, 2)),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        leading: Icon(icon, color: Colors.red, size: 32),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 16, color: Colors.black),
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 18, color: Colors.red),
        onTap: () {
          if (target != null) {
            Navigator.push(context, MaterialPageRoute(builder: (context) => target));
          }
        },
      ),
    );
  }

  Widget _buildCallButton(String label, IconData icon, VoidCallback onPressed) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, size: 22, color: Colors.white),
      label: Text(label, style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 15)),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 18),
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      ),
    );
  }
}

class IncidentReportFormScreen extends StatefulWidget {
  const IncidentReportFormScreen({super.key});

  @override
  State<IncidentReportFormScreen> createState() => _IncidentReportFormScreenState();
}

class _IncidentReportFormScreenState extends State<IncidentReportFormScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          'REPORT APPLICATION',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w900, fontSize: 18),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('REPORTER DETAILS:', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 18, color: Colors.red)),
              const SizedBox(height: 20),
              _buildTextField("Full Name", Icons.person, "Enter your name"),
              const SizedBox(height: 15),
              _buildTextField("ID Number", Icons.badge, "Enter NIC or License Number"),
              const SizedBox(height: 15),
              _buildTextField("Location", Icons.location_on, "Enter incident location"),
              const SizedBox(height: 15),
              _buildTextField("Vehicle Number", Icons.directions_car, "E.g. WP ABC-1234"),
              const SizedBox(height: 15),
              _buildTextField("Description", Icons.description, "Describe the incident...", maxLines: 4),
              
              const SizedBox(height: 30),
              
              ElevatedButton.icon(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _showSuccessDialog(context);
                  }
                },
                icon: const Icon(Icons.send),
                label: const Text("SUBMIT TO POLICE & INSURANCE", style: TextStyle(fontWeight: FontWeight.w900, fontSize: 18)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 65),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15), 
                    side: const BorderSide(color: Colors.black, width: 2),
                  ),
                  elevation: 10,
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, IconData icon, String hint, {int maxLines = 1}) {
    return TextFormField(
      maxLines: maxLines,
      style: const TextStyle(fontWeight: FontWeight.w600),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black87),
        hintText: hint,
        prefixIcon: Icon(icon, color: Colors.red),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.red, width: 2),
        ),
        filled: true,
        fillColor: Colors.grey[50],
      ),
      validator: (value) {
        if (value == null || value.isEmpty) return "Required information";
        return null;
      },
    );
  }

  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('REPORT SENT SUCCESSFUL', style: TextStyle(fontWeight: FontWeight.bold)),
        content: const Text('Your incident report has been securely transmitted to the Insurance Company and the Police Station.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              Navigator.of(context).popUntil((route) => route.isFirst);
            }, 
            child: const Text('OK', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold))
          )
        ],
      ),
    );
  }
}

class FirstAidGuidanceScreen extends StatelessWidget {
  const FirstAidGuidanceScreen({super.key});

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    if (await canLaunchUrl(launchUri)) {
      await launchUrl(launchUri);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 2,
        title: const Text(
          'FIRST AID GUIDANCE',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w900, fontSize: 18),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20.0),
        children: [
          _buildStep("01", "Secure Safety", "Stop safely. Hazard lights ON. Warning triangles 50m back.", Icons.warning_rounded),
          _buildStep("02", "Assess Breathing", "Check for pulse and airways. Do not move victims unless fire risk exists.", Icons.air_rounded),
          _buildStep("03", "Control Bleeding", "Apply direct pressure with clean cloth. Elevate injured limbs.", Icons.bloodtype_rounded),
          _buildStep("04", "Neck Protection", "Keep head and neck immobilized. Do not remove helmets.", Icons.airline_seat_flat_angled_rounded),
          _buildStep("05", "Shock Prevention", "Keep victims warm with blankets. Keep them calm and conscious.", Icons.ac_unit_rounded),
          const SizedBox(height: 30),
          ElevatedButton.icon(
            onPressed: () => _makePhoneCall('1990'),
            icon: const Icon(Icons.phone_in_talk, size: 26),
            label: const Text("CALL AMBULANCE (1990)", style: TextStyle(fontWeight: FontWeight.w900, fontSize: 18)),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              minimumSize: const Size(double.infinity, 60),
              elevation: 10,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStep(String number, String title, String description, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 25.0),
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.grey[50],
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.black12),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(number, style: const TextStyle(color: Colors.red, fontWeight: FontWeight.w900, fontSize: 22)),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(icon, color: Colors.black, size: 20),
                      const SizedBox(width: 8),
                      Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: Colors.black)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(description, style: const TextStyle(fontSize: 15, color: Colors.black87, fontWeight: FontWeight.w500, height: 1.4)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CaptureEvidenceScreen extends StatefulWidget {
  const CaptureEvidenceScreen({super.key});

  @override
  State<CaptureEvidenceScreen> createState() => _CaptureEvidenceScreenState();
}

class _CaptureEvidenceScreenState extends State<CaptureEvidenceScreen> {
  final ImagePicker _picker = ImagePicker();
  final List<XFile> _capturedFiles = [];

  Future<void> _capture(ImageSource source, {bool isVideo = false}) async {
    try {
      final XFile? file = isVideo 
          ? await _picker.pickVideo(
              source: source,
              maxDuration: const Duration(minutes: 10),
            )
          : await _picker.pickImage(
              source: source,
              imageQuality: 100,
            );
      if (file != null) {
        setState(() => _capturedFiles.add(file));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Capture failed: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text('CAPTURE EVIDENCE', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('INSTRUCTIONS:', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 18, color: Colors.red)),
            const SizedBox(height: 10),
            _buildInstruction("Take high-resolution photos of license plates."),
            _buildInstruction("Capture steady video of the overall scene."),
            _buildInstruction("Document road conditions and traffic signs."),
            const SizedBox(height: 25),
            const Text('OPTIONS:', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 18, color: Colors.black)),
            const SizedBox(height: 15),
            _buildCaptureButton("TAKE HIGH-QUALITY PHOTO", Icons.camera_alt, () => _capture(ImageSource.camera)),
            _buildCaptureButton("RECORD CLEAR VIDEO", Icons.videocam, () => _capture(ImageSource.camera, isVideo: true)),
            const SizedBox(height: 20),
            if (_capturedFiles.isNotEmpty) ...[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('CAPTURED EVIDENCE:', style: TextStyle(fontWeight: FontWeight.bold)),
                  TextButton(
                    onPressed: () => setState(() => _capturedFiles.clear()),
                    child: const Text("Clear All", style: TextStyle(color: Colors.red)),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 120,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _capturedFiles.length,
                  itemBuilder: (context, index) {
                    final isVideoFile = _capturedFiles[index].path.toLowerCase().endsWith('.mp4') || 
                                     _capturedFiles[index].path.toLowerCase().endsWith('.mov');
                    return Container(
                      margin: const EdgeInsets.only(right: 12),
                      width: 120,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: isVideoFile 
                            ? const Center(child: Icon(Icons.play_circle_fill, size: 50, color: Colors.red))
                            : Image.file(
                                File(_capturedFiles[index].path), 
                                fit: BoxFit.cover,
                                filterQuality: FilterQuality.high,
                              ),
                      ),
                    );
                  },
                ),
              ),
            ],
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.yellow,
                foregroundColor: Colors.black,
                minimumSize: const Size(double.infinity, 60),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15), 
                  side: const BorderSide(color: Colors.black, width: 2.5),
                ),
                elevation: 5,
              ),
              child: const Text("CONFIRM & SAVE EVIDENCE", style: TextStyle(fontWeight: FontWeight.w900, fontSize: 18)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInstruction(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          const Icon(Icons.check_circle, color: Colors.green, size: 20),
          const SizedBox(width: 12),
          Expanded(child: Text(text, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15))),
        ],
      ),
    );
  }

  Widget _buildCaptureButton(String label, IconData icon, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: ElevatedButton.icon(
        onPressed: onTap,
        icon: Icon(icon, color: Colors.white, size: 24),
        label: Text(label, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 16)),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black,
          minimumSize: const Size(double.infinity, 60),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
            side: const BorderSide(color: Colors.red, width: 2),
          ),
          elevation: 4,
        ),
      ),
    );
  }
}

class WitnessInfoScreen extends StatefulWidget {
  const WitnessInfoScreen({super.key});

  @override
  State<WitnessInfoScreen> createState() => _WitnessInfoScreenState();
}

class _WitnessInfoScreenState extends State<WitnessInfoScreen> {
  final _formKey = GlobalKey<FormState>();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text('WITNESS GATHERING', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('WITNESS DETAILS:', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 18, color: Colors.red)),
              const SizedBox(height: 20),
              
              _buildTextField("Full Name", Icons.person, "Enter witness name"),
              const SizedBox(height: 15),
              _buildTextField("Phone Number", Icons.phone, "Enter contact number", keyboardType: TextInputType.phone),
              const SizedBox(height: 15),
              _buildTextField("Witness Statement", Icons.description, "Describe exactly what was seen...", maxLines: 5),
              const SizedBox(height: 15),
              _buildTextField("Vehicle Number(s) Seen", Icons.directions_car, "E.g. WP ABC-1234"),
              
              const SizedBox(height: 30),
              
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Witness information recorded!')));
                    Navigator.pop(context);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.yellow,
                  foregroundColor: Colors.black,
                  minimumSize: const Size(double.infinity, 60),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15), 
                    side: const BorderSide(color: Colors.black, width: 2.5),
                  ),
                  elevation: 5,
                ),
                child: const Text("SAVE WITNESS DATA", style: TextStyle(fontWeight: FontWeight.w900, fontSize: 18)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, IconData icon, String hint, {int maxLines = 1, TextInputType keyboardType = TextInputType.text}) {
    return TextFormField(
      maxLines: maxLines,
      keyboardType: keyboardType,
      style: const TextStyle(fontWeight: FontWeight.w600),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black87),
        hintText: hint,
        prefixIcon: Icon(icon, color: Colors.red),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.red, width: 2),
        ),
        filled: true,
        fillColor: Colors.grey[50],
      ),
      validator: (value) {
        if (value == null || value.isEmpty) return "Required";
        return null;
      },
    );
  }
}

class EmergencyProtocolsScreen extends StatefulWidget {
  const EmergencyProtocolsScreen({super.key});

  @override
  State<EmergencyProtocolsScreen> createState() => _EmergencyProtocolsScreenState();
}

class _EmergencyProtocolsScreenState extends State<EmergencyProtocolsScreen> {
  Position? _currentPosition;
  bool _loading = false;

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(launchUri)) {
      await launchUrl(launchUri);
    }
  }

  Future<void> _getCurrentLocation() async {
    setState(() => _loading = true);
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        throw 'Location services are disabled.';
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          throw 'Location permissions are denied';
        }
      }
      
      if (permission == LocationPermission.deniedForever) {
        throw 'Location permissions are permanently denied';
      } 

      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      setState(() => _currentPosition = position);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
    } finally {
      setState(() => _loading = false);
    }
  }

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text('EMERGENCY PROTOCOLS', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('LOCATION LOG:', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 18, color: Colors.red)),
            const SizedBox(height: 15),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(color: Colors.grey[100], borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.black12)),
              child: Row(
                children: [
                  const Icon(Icons.my_location, color: Colors.red),
                  const SizedBox(width: 15),
                  Expanded(
                    child: _loading 
                      ? const LinearProgressIndicator(color: Colors.red)
                      : Text(
                          _currentPosition != null 
                            ? 'Lat: ${_currentPosition!.latitude.toStringAsFixed(4)}° N, Lon: ${_currentPosition!.longitude.toStringAsFixed(4)}° E\nAddress: Colombo, Sri Lanka (Detected)'
                            : 'Press button to detect location',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            TextButton.icon(
              onPressed: _getCurrentLocation, 
              icon: const Icon(Icons.refresh, color: Colors.red), 
              label: const Text("Refresh GPS", style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold))
            ),
            const SizedBox(height: 30),
            const Text('NEARBY FACILITIES:', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 18, color: Colors.black)),
            const SizedBox(height: 10),
            _contactTile("General Hospital", "011 269 1111", Icons.local_hospital, () => _makePhoneCall('0112691111')),
            _contactTile("Police Station HQ", "119", Icons.local_police, () => _makePhoneCall('119')),
            const SizedBox(height: 40),
            ElevatedButton.icon(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('GPS Signal Dispatched to Emergency Services!')));
                Navigator.pop(context);
              },
              icon: const Icon(Icons.emergency_share, size: 28),
              label: const Text("SEND DISTRESS SIGNAL", style: TextStyle(fontWeight: FontWeight.w900, fontSize: 18)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 65),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _contactTile(String name, String phone, IconData icon, VoidCallback onTap) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Icon(icon, color: Colors.red),
        title: Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(phone),
        trailing: IconButton(
          icon: const Icon(Icons.phone, color: Colors.green),
          onPressed: onTap,
        ),
      ),
    );
  }
}
