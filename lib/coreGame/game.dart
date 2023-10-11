// ignore_for_file: use_build_context_synchronously

import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:async/async.dart';
import 'dart:math';
import '../difficulty/difficulty.dart';
import 'package:timer_count_down/timer_count_down.dart';
import 'package:timer_count_down/timer_controller.dart';

class Game extends StatefulWidget {
  final int highscore;
  final bool darkMode;
  final Color textColor;
  final Difficulty difficulty;

  const Game(
      {Key? key,
      required this.highscore,
      required this.darkMode,
      required this.textColor,
      required this.difficulty})
      : super(key: key);

  @override
  State<Game> createState() =>
      GameState(highscore, darkMode, textColor, difficulty);
}

class GameState extends State<Game> {
  //Simple value and RNGs
  int score = 0;
  final int highscore;
  int rngFont = Random().nextInt(9);
  int rngText = Random().nextInt(9);
  bool ok = true;
  bool passed = false;
  int countdown = 0;

  Difficulty difficulty;

  bool darkMode;
  Color textColor;

  final CountdownController _controller = CountdownController(autoStart: true);

  //List of item
  final List<Color> fontColor = [
    Colors.pink.shade200,
    Colors.purple,
    Colors.brown,
    Colors.yellow,
    Colors.red,
    Colors.orange.shade600,
    Colors.green,
    Colors.blue,
    Colors.grey,
    Colors.grey.shade600
  ];

  final List<String> writtenText = [
    "PINK",
    "PURPLE",
    "BROWN",
    "YELLOW",
    "RED",
    "ORANGE",
    "GREEN",
    "BLUE",
    "GREY",
    "Game over",
    "New highscore!"
  ];

  GameState(this.highscore, this.darkMode, this.textColor, this.difficulty);

  Color uiTheme() {
    if (darkMode) {
      return Colors.grey.shade900;
    }
    return Colors.white;
  }

  Widget rowButton(int start) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[for (int i = start; i < start + 3; i++) button(i)]);
  }

  Widget button(int button) {
    return SizedBox.fromSize(
      size: const Size(120, 90),
      child: ClipRRect(
        child: Material(
          color: buttonOutline(button),
          child: InkWell(
            onTap: () {
              setState(() {
                checkColor(button);
              });
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(writtenText[button]),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _callback(BuildContext context) async {
    ok = false;
    passed = true;
    int? newPB = highscore;
    countdown = 0;
    difficulty.timer.cancel;
    setState(() {
      rngText = 9;
      rngFont = 9;
    });
    await Future.delayed(const Duration(seconds: 3));
    if (score > highscore) {
      newPB = score;
      setState(() {
        rngText = 10;
      });
      await saveHighscore(score);
      await Future.delayed(const Duration(seconds: 3));
    }
    Navigator.pop(context, newPB);
  }

  Future<void> saveHighscore(int newHighscore) async {
    final prefs = await SharedPreferences.getInstance();
    switch (difficulty.id) {
      case 0:
        await prefs.setInt('highscore', newHighscore);
        break;
      case 1:
        await prefs.setInt('medium', newHighscore);
        break;
      case 2:
        await prefs.setInt('hard', newHighscore);
        break;
      default:
        break;
    }
  }

  void checkColor(int colorValue) {
    if (ok) {
      if (colorValue == rngFont) {
        setState(() {
          score++;
          rerollFontColor();
        });
      } else {
        _callback(context);
      }
    }
  }

  void rerollFontColor() {
    difficulty.timer.reset();
    _controller.restart();
    setState(() {
      countdown = difficulty.countdown;
    });
    if (ok) {
      rngFont = Random().nextInt(9);
      rngText = Random().nextInt(9);
    }
  }

  Color buttonOutline(int id) {
    if (!difficulty.tileColor) {
      return textColor;
    }
    return fontColor[id];
  }

  @override
  void initState() {
    super.initState();
    countdown = difficulty.countdown;
    difficulty.timer =
        RestartableTimer(Duration(seconds: difficulty.countdown), () {
      if (!passed) _callback(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: uiTheme(),
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Score: $score',
                        style: TextStyle(color: textColor, fontSize: 40),
                      ),
                      Text(
                        'High score: $highscore',
                        style: TextStyle(color: textColor, fontSize: 25),
                      ),
                    ],
                  ),
                ],
              ),
              Countdown(
                controller: _controller,
                seconds: countdown,
                build: (BuildContext context, double time) => Text(
                    time.toString(),
                    style: TextStyle(color: textColor, fontSize: 25)),
                interval: const Duration(milliseconds: 100),
              ),
              Text(
                writtenText[rngText],
                style: TextStyle(color: fontColor[rngFont], fontSize: 50),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  for (int i = 0; i < 9; i = i + 3) rowButton(i)
                ],
              ),
            ]),
      ),
    );
  }
}
