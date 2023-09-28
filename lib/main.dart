import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'mainMenu/homepage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  int highscore = prefs.getInt('highscore') ?? 0;
  bool darkMode = prefs.getBool('darkMode') ?? false;
  Color textColor;
  if (darkMode) {
    textColor = Colors.black54;
  } else {
    textColor = Colors.white;
  }
  runApp(MyApp(highscore: highscore, darkMode: darkMode, textColor: textColor));
}

class MyApp extends StatelessWidget {
  final int highscore;
  final bool darkMode;
  final Color textColor;
  const MyApp(
      {super.key,
      required this.highscore,
      required this.darkMode,
      required this.textColor});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(
          title: 'Flutter Demo Home Page',
          highscore: highscore,
          darkmode: darkMode,
          textColor: textColor),
      debugShowCheckedModeBanner: false,
    );
  }
}
