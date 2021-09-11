// ignore: avoid_web_libraries_in_flutter

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class HomeModel extends ChangeNotifier {
  AudioCache player = AudioCache();
  bool sounds = false;

  late AudioPlayer changeTakibi;

  Future startSound() async {
    AudioPlayer audioSourceTakibi = await player.loop('fire.mp3');

    sounds = !sounds;
    changeTakibi = audioSourceTakibi;
    notifyListeners();
  }

  Future stopSound() async {
    await changeTakibi.stop();

    sounds = !sounds;
    notifyListeners();
  }
}
