// This is a minimal example demonstrating a play/pause button and a seek bar.
// More advanced examples demonstrating other features can be found in the same
// directory as this example in the GitHub repository.

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:audio_session/audio_session.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ionicons/ionicons.dart';
import 'package:just_audio/just_audio.dart';
import 'package:major_try/widgets/recording.dart';
import 'package:major_try/widgets/seekbar.dart';
import 'package:rxdart/rxdart.dart';
import 'package:velocity_x/velocity_x.dart';
import '../utils/routes.dart';
import 'package:major_try/data/globals.dart' as globals;

import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class MyPlayer extends StatefulWidget {
  String _sentence = "";

  MyPlayer(String sentence, {super.key}) {
    _sentence = sentence.trim();
  }

  @override
  _MyPlayerState createState() => _MyPlayerState(_sentence);
}

class _MyPlayerState extends State<MyPlayer> with WidgetsBindingObserver {
  // final recorder = FlutterSoundRecorder();

  String _sentence = "";

  _MyPlayerState(String sentence) {
    _sentence = sentence;
  }

  final _player = AudioPlayer();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    // initRecorder();
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.black,
    ));
    _init();
  }

  // Future initRecorder() async {
  //   final status = await Permission.microphone.request();
  //   if (status != PermissionStatus.granted) {
  //     throw 'Microphone permission not granted.';
  //   }
  //   await recorder.openRecorder();
  // }

  Future<void> _init() async {
    // Inform the operating system of our app's audio attributes etc.
    // We pick a reasonable default for an app that plays speech.
    final session = await AudioSession.instance;
    await session.configure(const AudioSessionConfiguration.speech());
    // Listen to errors during playback.
    _player.playbackEventStream
        .listen((event) {}, onError: (Object e, StackTrace stackTrace) {});

    // Try to load audio from a source and catch any errors.

    //bypassing the ngrok warning with header
    await _player.setAudioSource(
        AudioSource.uri(Uri.parse('${globals.url}/api?query=$_sentence')));
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);

    // recorder.closeRecorder();
    // Release decoders and buffers back to the operating system making them
    // available for other apps to use.
    _player.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      // Release the player's resources when not in use. We use "stop" so that
      // if the app resumes later, it will still remember what position to
      // resume from.
      _player.stop();
    }
  }

  /// Collects the data useful for displaying in a seek bar, using a handy
  /// feature of rx_dart to combine the 3 streams of interest into one.
  Stream<PositionData> get _positionDataStream =>
      Rx.combineLatest3<Duration, Duration, Duration?, PositionData>(
          _player.positionStream,
          _player.bufferedPositionStream,
          _player.durationStream,
          (position, bufferedPosition, duration) => PositionData(
              position, bufferedPosition, duration ?? Duration.zero));

  String responseText = "";
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        SizedBox(
          height: height / 3.5,
          child: Column(
            children: [
              ControlButtons(_player),
              Text(
                _sentence,
                style: context.textTheme.bodyLarge
                    ?.copyWith(color: context.primaryColor),
              ).py12(),
              StreamBuilder<PositionData>(
                stream: _positionDataStream,
                builder: (context, snapshot) {
                  final positionData = snapshot.data;
                  return SeekBar(
                    duration: positionData?.duration ?? Duration.zero,
                    position: positionData?.position ?? Duration.zero,
                    bufferedPosition:
                        positionData?.bufferedPosition ?? Duration.zero,
                    onChangeEnd: _player.seek,
                  );
                },
              ),
            ],
          ),
        ).px12().py12(),
        const Divider(
          thickness: 3,
          // color: context.primaryColor,
        ),
        SizedBox(
          height: height / 3.5,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Text(
                  responseText,
                  style: context.textTheme.bodyLarge
                      ?.copyWith(color: context.primaryColor),
                ).py12(),
              ),
              responseText.isNotEmpty
                  ? IconButton(
                      onPressed: () {
                        setState(() {
                          responseText = "";
                        });
                      },
                      icon: const Icon(Icons.clear),
                    )
                  : Container(),
              const Recorder(),
              ElevatedButton(
                onPressed: () async {
                  var audioFile = File(globals.asrFilePath);
                  var url = Uri.parse("${globals.url}/asr");
                  var request = http.MultipartRequest("POST", url);

                  request.files.add(http.MultipartFile(
                    'file',
                    audioFile.readAsBytes().asStream(),
                    audioFile.lengthSync(),
                    filename: "audio.mp4",
                    contentType: MediaType.parse("audio/mp4"),
                  ));
                  final response = await request.send();
                  http.Response res = await http.Response.fromStream(response);

                  final resJson = jsonDecode(res.body);
                  var message = resJson["message"];

                  setState(() {
                    responseText = message;
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: context.primaryColor,
                ),
                child: Text(
                  'Transcribe !',
                  style: TextStyle(
                    color: context.canvasColor,
                    fontSize: 25,
                  ),
                ).py12(),
              ),
            ],
          ),
        ).px12().py12(),
        const Divider(
          thickness: 3,
          // color: context.primaryColor,
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, MyRoutes.handsRoute);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: context.primaryColor,
          ),
          child: Text(
            'Speak Again !',
            style: TextStyle(
              color: context.canvasColor,
              fontSize: 25,
            ),
          ).py12(),
        ),
      ],
    );
  }
}

/// Displays the play/pause button and volume/speed sliders.
class ControlButtons extends StatelessWidget {
  final AudioPlayer player;
  const ControlButtons(this.player, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        /// This StreamBuilder rebuilds whenever the player state changes, which
        /// includes the playing/paused state and also the
        /// loading/buffering/ready state. Depending on the state we show the
        /// appropriate button or loading indicator.

        StreamBuilder<PlayerState>(
          stream: player.playerStateStream,
          builder: (context, snapshot) {
            final playerState = snapshot.data;
            final processingState = playerState?.processingState;
            final playing = playerState?.playing;
            if (processingState == ProcessingState.loading ||
                processingState == ProcessingState.buffering) {
              return Container(
                margin: const EdgeInsets.all(8.0),
                width: 55.0,
                height: 55.0,
                child: CircularProgressIndicator(
                  color: context.primaryColor,
                ),
              );
            } else if (playing != true) {
              return IconButton(
                color: context.primaryColor,
                icon: const Icon(Ionicons.play_outline),
                iconSize: 55.0,
                onPressed: player.play,
              );
            } else if (processingState != ProcessingState.completed) {
              return IconButton(
                color: context.primaryColor,
                icon: const Icon(Ionicons.pause),
                iconSize: 55.0,
                onPressed: player.pause,
              );
            } else {
              return IconButton(
                color: context.primaryColor,
                icon: const Icon(Ionicons.arrow_redo_outline),
                iconSize: 55.0,
                onPressed: () => player.seek(Duration.zero),
              );
            }
          },
        ),
        // Opens speed slider dialog
      ],
    );
  }
}
