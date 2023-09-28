import 'package:flutter/material.dart';
import '../coreGame/game.dart';
//import 'score.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title, required this.highscore})
      : super(key: key);

  final String title;
  final int highscore;

  @override
  State<MyHomePage> createState() => MyHomePageState(highscore);
}

class MyHomePageState extends State<MyHomePage> {
  //Variable declaration
  int highscore;

  MyHomePageState(this.highscore);

  void waitForCallback(BuildContext context) async {
    final newBest = await Navigator.push(context,
        MaterialPageRoute(builder: ((context) => Game(highscore: highscore))));
    setState(() {
      highscore = newBest;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'OPTICOLOR',
                style: Theme.of(context).textTheme.headline3,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'High score: $highscore',
                style: Theme.of(context).textTheme.headline4,
              ),
            ],
          ),
          // The widget bellow is an icon button with, of course, an icon,
          // but this button also contain text, which is really useful.
          // BTW, this button is to reset all the value to zero
          /*SizedBox.fromSize(
                size: const Size(56, 56),
                child: ClipOval(
                  child: Material(
                    color: Colors.pink,
                    child: InkWell(
                      //splashColor: Colors.white,
                      onTap: _reset,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const <Widget>[
                          Icon(Icons.question_mark),
                          Text("Reset"),
                        ],
                      ),
                    ),
                  ),
                ),
              ),*/
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
                    children: const <Widget>[
                      Icon(Icons.play_arrow),
                      Text("Play !"),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
