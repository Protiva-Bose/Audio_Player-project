import 'dart:ui';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

import 'main.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MusicPlayer(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MusicPlayer extends StatefulWidget {
  const MusicPlayer({super.key});

  @override
  State<MusicPlayer> createState() => _MusicPlayerState();
}

class _MusicPlayerState extends State<MusicPlayer> {
  bool isPlaying = false;
  double value = 0;

  final player = AudioPlayer();
  Duration? duration = Duration(seconds: 0);

  void initPlayer() async {
    await player.setSource(AssetSource('music.mp3'));
    duration = await player.getDuration();
  }

  @override
  void initState() {
    super.initState();
    initPlayer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.black,
        toolbarHeight: 120,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(top: 12.0, bottom: 12.0),
          child: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const EbookHome()),
              );
            },
          ),
        ),
        title: const Text(
          "Music Streaming",
          style: TextStyle(color: Colors.white),
        ),
      ),







      body: Stack(
        children: [
          Container(
            constraints: const BoxConstraints.expand(),
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/cover.jpg"),
                fit: BoxFit.fill,
              ),
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 48, sigmaY: 48),
              child: Container(
                color: Colors.black12,
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Image.asset("assets/first.jpg", width: 250.0),
              ),
              const SizedBox(height: 20),
              const Text(
                "Matt Ridley",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 35.0,
                  letterSpacing: 6,
                ),
              ),
              Text('18 June,2025',style: TextStyle(color: Colors.white),),
              SizedBox(height: 50.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "${(value / 60).floor().toString().padLeft(2, '0')}:${(value % 60).floor().toString().padLeft(2, '0')}",
                    style: const TextStyle(color: Colors.white),
                  ),
                  Expanded(
                    child: Slider.adaptive(
                      onChanged: (v) {
                        setState(() {
                          value = v;
                        });
                      },
                      min: 0.0,
                      max: duration!.inSeconds.toDouble(),
                      value: value,
                      onChangeEnd: (newValue) async {
                        setState(() {
                          value = newValue;
                        });
                        await player.pause();
                        await player.seek(Duration(seconds: newValue.toInt()));
                        await player.resume();
                      },
                      activeColor: Colors.white,
                    ),
                  ),
                  Text(
                    "${duration!.inMinutes}:${(duration!.inSeconds % 60).toString().padLeft(2, '0')}",
                    style: const TextStyle(color: Colors.white),
                  ),
                ],
              ),
              const SizedBox(height: 30),

              // ▶️ Rewind 10s – Play/Pause – Forward 10s
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: const Icon(Icons.replay_10, color: Colors.white),
                    iconSize: 36,
                    onPressed: () async {
                      final newPos = (value - 10).clamp(0, duration!.inSeconds.toDouble());
                      await player.seek(Duration(seconds: newPos.toInt()));
                    },
                  ),
                  const SizedBox(width: 20),
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(60),
                      color: Colors.black87,
                      border: Border.all(color: Colors.blueAccent),
                    ),
                    child: InkWell(
                      onTap: () async {
                        if (isPlaying) {
                          await player.pause();
                          setState(() {
                            isPlaying = false;
                          });
                        } else {
                          await player.resume();
                          setState(() {
                            isPlaying = true;
                          });
                          player.onPositionChanged.listen((position) {
                            setState(() {
                              value = position.inSeconds.toDouble();
                            });
                          });
                        }
                      },
                      child: Icon(
                        isPlaying ? Icons.pause : Icons.play_arrow,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  IconButton(
                    icon: const Icon(Icons.forward_10, color: Colors.white),
                    iconSize: 36,
                    onPressed: () async {
                      final newPos = (value + 10).clamp(0, duration!.inSeconds.toDouble());
                      await player.seek(Duration(seconds: newPos.toInt()));
                    },
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}