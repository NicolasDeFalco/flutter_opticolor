import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../coreGame/game.dart';
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

  MyHomePageState(this.highscore, this.darkMode, this.textColor);

  void waitForCallback(BuildContext context) async {
    final newBest = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: ((context) => Game(
                  highscore: highscore,
                  darkMode: darkMode,
                  textColor: textColor,
                ))));
    setState(() {
      highscore = newBest;
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
                                        "This game is really simple: \n \nA colour will be written on the screen in a certain color(the word red will be colored in blue for example).\n\nYour objective is to press the button corresponding with the color of the word.\n\n This game is inspired by the stroop effect.",
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
