import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class Game extends StatefulWidget {
  int highscore;
  Game({Key? key, required this.highscore}) : super(key: key);

  @override
  State<Game> createState() => GameState(highscore);
}

class GameState extends State<Game> {
  //Simple value and RNGs
  int score = 0;
  int highscore;
  int rngFont = Random().nextInt(9) + 1;
  int rngText = Random().nextInt(9) + 1;
  bool ok = true;

  //List of item
  final List<Color> fontColor = [
    Colors.pink,
    Colors.purple,
    Colors.brown,
    Colors.yellow,
    Colors.red,
    Colors.orange,
    Colors.green,
    Colors.blue,
    Colors.grey,
    Colors.black
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

  GameState(this.highscore);

  void _callback(BuildContext context) async {
    ok = false;
    int? newPB = highscore;
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

  Future<void> saveHighscore(int newHighscore) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('highscore', newHighscore);
  }

  void checkColor(int colorValue) {
    if (ok = true) {
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
    if (ok == true) {
      rngFont = Random().nextInt(9) + 1;
      rngText = Random().nextInt(9) + 1;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        style: Theme.of(context).textTheme.headline3,
                      ),
                      Text(
                        'High score: $highscore',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ],
                  ),
                ],
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
                            color: Colors.pink,
                            child: InkWell(
                              //splashColor: Colors.white,
                              onTap: () {
                                setState(() {
                                  checkColor(1);
                                });
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const <Widget>[
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
                            color: Colors.purple,
                            child: InkWell(
                              //splashColor: Colors.white,
                              onTap: () {
                                setState(() {
                                  checkColor(2);
                                });
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const <Widget>[
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
                            color: Colors.brown,
                            child: InkWell(
                              //splashColor: Colors.white,
                              onTap: () {
                                setState(() {
                                  checkColor(3);
                                });
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const <Widget>[
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
                            color: Colors.yellow,
                            child: InkWell(
                              //splashColor: Colors.white,
                              onTap: () {
                                setState(() {
                                  checkColor(4);
                                });
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const <Widget>[
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
                            color: Colors.red,
                            child: InkWell(
                              //splashColor: Colors.white,
                              onTap: () {
                                setState(() {
                                  checkColor(5);
                                });
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const <Widget>[
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
                            color: Colors.orange,
                            child: InkWell(
                              //splashColor: Colors.white,
                              onTap: () {
                                setState(() {
                                  checkColor(6);
                                });
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const <Widget>[
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
                            color: Colors.green,
                            child: InkWell(
                              //splashColor: Colors.white,
                              onTap: () {
                                setState(() {
                                  checkColor(7);
                                });
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const <Widget>[
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
                            color: Colors.blue,
                            child: InkWell(
                              //splashColor: Colors.white,
                              onTap: () {
                                setState(() {
                                  checkColor(8);
                                });
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const <Widget>[
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
                            color: Colors.grey,
                            child: InkWell(
                              //splashColor: Colors.white,
                              onTap: () {
                                setState(() {
                                  checkColor(9);
                                });
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const <Widget>[
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
