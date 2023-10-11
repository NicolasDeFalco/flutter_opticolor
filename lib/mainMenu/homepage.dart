import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../coreGame/game.dart';
import 'package:opticolor/difficulty/difficulty.dart';
import 'package:async/async.dart';
//import 'score.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage(
      {Key? key,
      required this.title,
      required this.highscore,
      required this.darkmode,
      required this.textColor})
      : super(key: key);

  final String title;
  final int highscore;
  final bool darkmode;
  final Color textColor;

  @override
  State<MyHomePage> createState() =>
      MyHomePageState(highscore, darkmode, textColor);
}

class MyHomePageState extends State<MyHomePage> {
  //Variable declaration

  int highscore;
  bool darkMode;
  Color textColor;
  int index = 0;
  Object _dropdownvalue = 'Easy';

  final List<Difficulty> difficulty = [
    Difficulty(
        RestartableTimer(Duration(seconds: 5), () => null), 5, "Easy", true),
    Difficulty(
        RestartableTimer(Duration(seconds: 3), () => null), 3, "Medium", true),
    Difficulty(
        RestartableTimer(Duration(seconds: 2), () => null), 2, "Hard", false)
  ];

  MyHomePageState(this.highscore, this.darkMode, this.textColor);

  void waitForCallback(BuildContext context) async {
    final newBest = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: ((context) => Game(
                  highscore: highscore,
                  darkMode: darkMode,
                  textColor: textColor,
                  difficulty: difficulty[index],
                ))));
    setState(() {
      highscore = newBest ?? highscore;
    });
  }

  Color uiTheme() {
    if (darkMode) {
      themeSwitch(darkMode);
      textColor = Colors.white;
      return Colors.grey.shade900;
    }
    themeSwitch(darkMode);
    textColor = Colors.black54;
    return Colors.white;
  }

  void themeSwitch(bool themeData) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('darkMode', themeData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: uiTheme(),
        body: SafeArea(
            child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  SizedBox.fromSize(
                    size: const Size(50, 50),
                    child: ClipOval(
                      child: Material(
                        color: Colors.grey.shade100,
                        child: InkWell(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                      backgroundColor: uiTheme(),
                                      title: Text(
                                        "Rules",
                                        style: TextStyle(
                                            color: textColor, fontSize: 25),
                                      ),
                                      content: Text(
                                        "This game is really simple: \n \nA colour will be written on the screen in a certain color(the word red will be colored in blue for example).\n\nYour objective is to press the button corresponding with the color of the word.\n\nDifficulty:\nEasy: 5 seconds between each response;\nMedium: 3 seconds between each response;\nHard: 2 seconds between each response + no color on buttons.\n\nThis game is inspired by the Stroop effect.",
                                        style: TextStyle(
                                            color: textColor, fontSize: 15),
                                      ),
                                      actions: [
                                        TextButton(
                                            onPressed: () =>
                                                Navigator.pop(context),
                                            child: Text("Ok",
                                                style: TextStyle(
                                                    color: Colors.grey.shade400,
                                                    fontSize: 15)))
                                      ],
                                    ));
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const <Widget>[
                              Icon(Icons.book),
                              Text("Rules"),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Switch(
                        value: darkMode,
                        onChanged: (bool value) {
                          setState(() {
                            darkMode = value;
                          });
                        },
                        activeColor: Colors.grey.shade600,
                      ),
                      Text("Dark mode ", style: TextStyle(color: textColor))
                    ],
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'OPTICOLOR',
                    style: TextStyle(color: textColor, fontSize: 50),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'High score: $highscore',
                    style: TextStyle(color: textColor, fontSize: 30),
                  ),
                ],
              ),
              DropdownButton(
                value: _dropdownvalue,
                items: const <DropdownMenuItem<String>>[
                  DropdownMenuItem(
                      value: "Easy",
                      child: Text("Easy",
                          style: TextStyle(color: Colors.green, fontSize: 20))),
                  DropdownMenuItem(
                      value: "Medium",
                      child: Text("Medium",
                          style:
                              TextStyle(color: Colors.orange, fontSize: 20))),
                  DropdownMenuItem(
                      value: "Hard",
                      child: Text("Hard",
                          style: TextStyle(color: Colors.red, fontSize: 20)))
                ],
                onChanged: (value) {
                  // This is called when the user selects an item.
                  setState(() {
                    _dropdownvalue = value!;
                    switch (value) {
                      case "Easy":
                        index = 0;
                        break;
                      case "Medium":
                        index = 1;
                        break;
                      case "Hard":
                        index = 2;
                        break;
                      default:
                        break;
                    }
                  });
                },
              ),
              SizedBox.fromSize(
                size: const Size(80, 80),
                child: ClipOval(
                  child: Material(
                    color: Colors.pink,
                    child: InkWell(
                      //splashColor: Colors.white,
                      onTap: () {
                        waitForCallback(context);
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          const Icon(Icons.play_arrow),
                          Text(
                            "Play !",
                            style: TextStyle(color: textColor),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[],
              ),
            ],
          ),
        )));
  }
}
