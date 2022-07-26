import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:fitness_app/model/model.dart';
import 'package:flutter/material.dart';

class ThirdPage extends StatefulWidget {
  ThirdPage({Key? key, this.excerciesModel, this.second}) : super(key: key);

  ExcerciesModel? excerciesModel;
  int? second;
  @override
  State<ThirdPage> createState() => _ThirdPageState();
}

class _ThirdPageState extends State<ThirdPage> {
  AudioPlayer audioPlayer = AudioPlayer();
  AudioCache audioCache = AudioCache();
  late Timer timer;
  bool isComplete = false;
  bool isPlaying = false;
  String path = "audio.mp3";
  int startSound = 0;

  void playAudio() async {
    await audioCache.play(path);

    print("done");
  }

  @override
  void initState() {
    playAudio();
    // TODO: implement initState
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (timer.tick == widget.second) {
        timer.cancel();
        setState(() {
          isComplete = true;
          playAudio();
          Future.delayed(Duration(seconds: 3), () {
            Navigator.of(context).pop();
          });
        });
      }
      setState(() {
        startSound = timer.tick;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.network(
            "${widget.excerciesModel!.gif}",
            width: double.infinity,
            fit: BoxFit.cover,
            height: double.infinity,
          ),
          Text("${startSound} / ${widget.second}")
        ],
      ),
    );
  }
}
