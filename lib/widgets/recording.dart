import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:ionicons/ionicons.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:major_try/data/globals.dart' as globals;

class Recorder extends StatefulWidget {
  const Recorder({super.key});

  @override
  State<Recorder> createState() => _RecorderState();
}

class _RecorderState extends State<Recorder> {
  bool _isRecording = false;
  final FlutterSoundRecorder _recorder = FlutterSoundRecorder();
  String _audioFilePath = '';

  @override
  void initState() {
    super.initState();
    initRecorder();
  }

  @override
  void dispose() {
    _recorder.closeRecorder();
    super.dispose();
  }

  Future initRecorder() async {
    final status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      throw 'Microphone permission not granted.';
    }
    // await recorder.openRecorder();
    // isRecorderReady = true;
  }

  Future startRecording() async {
    final appDocDir = await getApplicationDocumentsDirectory();
    final appDocPath = '${appDocDir.path}/flutter_sound.mp4';

    await _recorder.openRecorder();

    await _recorder.startRecorder(toFile: appDocPath, codec: Codec.aacMP4);
    setState(() {
      _isRecording = true;
    });
  }

  Future stopRecording() async {
    final path = await _recorder.stopRecorder();
    final audioFile = File(path!);
    _audioFilePath = audioFile.path;
    globals.asrFilePath = _audioFilePath;
    await _recorder.closeRecorder();
    setState(() {
      _isRecording = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onLongPressStart: (details) async {
          startRecording();
        },
        onLongPressEnd: (details) {
          stopRecording();
        },
        child: _isRecording
            ? const Icon(
                Ionicons.mic_circle_outline,
                size: 80.0,
                color: Colors.red,
              )
            : const Icon(
                Ionicons.mic,
                size: 50.0,
                color: Colors.grey,
              ));

    // IconButton(
    //   icon: recorder.isRecording
    //       ? const Icon(
    //           Ionicons.stop_circle_outline,
    //           color: Colors.purple,
    //           size: 70,
    //         )
    //       : const Icon(
    //           Ionicons.mic_circle,
    //           color: Colors.purple,
    //           size: 50,
    //         ),
    //   onPressed: () async {
    //     if (recorder.isRecording) {
    //       await stopRecording();
    //       setState(() {});
    //       await sendData();
    //     } else {
    //       await startRecording();
    //     }
    //     setState(() {});
    //   },
    // );
  }
}
