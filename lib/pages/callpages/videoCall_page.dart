import 'package:flutter/material.dart';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:permission_handler/permission_handler.dart';

class VideoCallPage extends StatefulWidget {
  final String channelName;

  const VideoCallPage({super.key, required this.channelName});

  @override
  State<VideoCallPage> createState() => _VideoCallPageState();
}

class _VideoCallPageState extends State<VideoCallPage> {
  final String appId = "1694e08ccac64ad58ca2027348c3a2bc";

  int? _remoteUid;
  bool _localUserJoined = false;
  bool isMuted = false;
  bool isVideoOff = false;

  late RtcEngine _engine;

  @override
  void initState() {
    super.initState();
    initAgora();
  }

  Future<void> initAgora() async {
    await [Permission.microphone, Permission.camera].request();

    _engine = createAgoraRtcEngine();
    await _engine.initialize(RtcEngineContext(appId: appId));

    _engine.registerEventHandler(
      RtcEngineEventHandler(
        onJoinChannelSuccess: (connection, elapsed) {
          setState(() => _localUserJoined = true);
        },
        onUserJoined: (connection, remoteUid, elapsed) {
          setState(() => _remoteUid = remoteUid);
        },
        onUserOffline: (connection, remoteUid, reason) {
          setState(() => _remoteUid = null);
        },
      ),
    );

    await _engine.enableVideo();
    await _engine.startPreview();

    await _engine.joinChannel(
      token: "",
      channelId: widget.channelName,
      uid: 0,
      options: const ChannelMediaOptions(
        clientRoleType: ClientRoleType.clientRoleBroadcaster,
        channelProfile: ChannelProfileType.channelProfileCommunication,
      ),
    );
  }

  @override
  void dispose() {
    _engine.leaveChannel();
    _engine.release();
    super.dispose();
  }

  Widget _remoteVideo() {
    if (_remoteUid != null) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: AgoraVideoView(
          controller: VideoViewController.remote(
            rtcEngine: _engine,
            canvas: VideoCanvas(uid: _remoteUid),
            connection: RtcConnection(channelId: widget.channelName),
          ),
        ),
      );
    } else {
      return Container(
        decoration: BoxDecoration(
          color: Colors.white24,
          borderRadius: BorderRadius.circular(20),
        ),
        child: const Center(
          child: Text(
            "Waiting for doctor...",
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
        ),
      );
    }
  }

  Widget _localVideo() {
    if (_localUserJoined) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: AgoraVideoView(
          controller: VideoViewController(
            rtcEngine: _engine,
            canvas: const VideoCanvas(uid: 0),
          ),
        ),
      );
    } else {
      return const Center(child: CircularProgressIndicator());
    }
  }

  Widget controlButton(IconData icon, Color color, VoidCallback onPressed) {
    return CircleAvatar(
      radius: 28,
      backgroundColor: color,
      child: IconButton(
        icon: Icon(icon, color: Colors.white),
        onPressed: onPressed,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0A2647), Color(0xFF144272)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    const Text(
                      "Doctor Video Call",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Expanded(child: _remoteVideo()),
                    const SizedBox(height: 10),
                    const Text(
                      "Dr. Connected",
                      style: TextStyle(color: Colors.white70),
                    ),
                  ],
                ),
              ),

              Positioned(
                top: 80,
                right: 20,
                child: SizedBox(width: 120, height: 160, child: _localVideo()),
              ),

              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      controlButton(
                        isMuted ? Icons.mic_off : Icons.mic,
                        Colors.grey,
                        () {
                          setState(() => isMuted = !isMuted);
                          _engine.muteLocalAudioStream(isMuted);
                        },
                      ),
                      controlButton(Icons.call_end, Colors.red, () {
                        Navigator.pop(context);
                      }),
                      controlButton(
                        isVideoOff ? Icons.videocam_off : Icons.videocam,
                        Colors.grey,
                        () {
                          setState(() => isVideoOff = !isVideoOff);
                          _engine.muteLocalVideoStream(isVideoOff);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}