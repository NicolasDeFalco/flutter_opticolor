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
  int rngFont = Random().nextInt(9) + 1;
  int rngText = Random().nextInt(9) + 1;
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
    Colors.orange.shade500,
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

  void _callback(BuildContext context) async {
    ok = false;
    passed = true;
    int? newPB = highscore;
    countdown = 0;
    difficulty.timer.cancel;
    setState(() {
      rngText = 10;
      rngFont = 10;
    });
    await Future.delayed(const Duration(seconds: 3));
    if (score > highscore) {
      newPB = score;
      setState(() {
        rngText = 11;
      });
      await saveHighscore(score);
      await Future.delayed(const Duration(seconds: 3));
    }
    Navigator.pop(context, newPB);
  }

  // Cette fonction va sauvegarder notre nouveau meilleur score
  Future<void> saveHighscore(int newHighscore) async {
    // On va d'abord créer une instance de SharePreferences
    // pour pouvoir modifier la valeur que l'on a stockée
    final prefs = await SharedPreferences.getInstance();

    // Puis on va sauvegarder notre nouveau meilleur score
    await prefs.setInt('highscore', newHighscore);
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
      rngFont = Random().nextInt(9) + 1;
      rngText = Random().nextInt(9) + 1;
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
      /*appBar: AppBar(
        title: Text("Opticolor"),
        // The widget bellow allow you to turn your appbar
        // into a gradient.
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: <Color>[Colors.purple, Colors.pink]),
          ),
        ),
      ),*/
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
                writtenText[rngText - 1],
                style: TextStyle(color: fontColor[rngFont - 1], fontSize: 50),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      SizedBox.fromSize(
                        size: const Size(120, 90),
                        child: ClipRRect(
                          child: Material(
                            color: buttonOutline(0),
                            child: InkWell(
                              //splashColor: Colors.white,
                              onTap: () {
                                setState(() {
                                  checkColor(1);
                                });
                              },
                              child: const Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text("PINK"),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox.fromSize(
                        size: const Size(120, 90),
                        child: ClipRRect(
                          child: Material(
                            color: buttonOutline(1),
                            child: InkWell(
                              //splashColor: Colors.white,
                              onTap: () {
                                setState(() {
                                  checkColor(2);
                                });
                              },
                              child: const Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text("PURPLE"),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox.fromSize(
                        size: const Size(120, 90),
                        child: ClipRRect(
                          child: Material(
                            color: buttonOutline(2),
                            child: InkWell(
                              //splashColor: Colors.white,
                              onTap: () {
                                setState(() {
                                  checkColor(3);
                                });
                              },
                              child: const Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text("BROWN"),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      SizedBox.fromSize(
                        size: const Size(120, 90),
                        child: ClipRRect(
                          child: Material(
                            color: buttonOutline(3),
                            child: InkWell(
                              //splashColor: Colors.white,
                              onTap: () {
                                setState(() {
                                  checkColor(4);
                                });
                              },
                              child: const Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text("YELLOW"),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox.fromSize(
                        size: const Size(120, 90),
                        child: ClipRRect(
                          child: Material(
                            color: buttonOutline(4),
                            child: InkWell(
                              //splashColor: Colors.white,
                              onTap: () {
                                setState(() {
                                  checkColor(5);
                                });
                              },
                              child: const Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text("RED"),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox.fromSize(
                        size: const Size(120, 90),
                        child: ClipRRect(
                          child: Material(
                            color: buttonOutline(5),
                            child: InkWell(
                              //splashColor: Colors.white,
                              onTap: () {
                                setState(() {
                                  checkColor(6);
                                });
                              },
                              child: const Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text("ORANGE"),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      SizedBox.fromSize(
                        size: const Size(120, 90),
                        child: ClipRRect(
                          child: Material(
                            color: buttonOutline(6),
                            child: InkWell(
                              //splashColor: Colors.white,
                              onTap: () {
                                setState(() {
                                  checkColor(7);
                                });
                              },
                              child: const Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text("GREEN"),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox.fromSize(
                        size: const Size(120, 90),
                        child: ClipRRect(
                          child: Material(
                            color: buttonOutline(7),
                            child: InkWell(
                              //splashColor: Colors.white,
                              onTap: () {
                                setState(() {
                                  checkColor(8);
                                });
                              },
                              child: const Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text("BLUE"),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox.fromSize(
                        size: const Size(120, 90),
                        child: ClipRRect(
                          child: Material(
                            color: buttonOutline(8),
                            child: InkWell(
                              //splashColor: Colors.white,
                              onTap: () {
                                setState(() {
                                  checkColor(9);
                                });
                              },
                              child: const Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text("GREY"),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ]),
      ),
    );
  }
}
