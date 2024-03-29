import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'mainMenu/homepage.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  List<int> highscores = [0, 0, 0];
  highscores[0] = prefs.getInt('highscore') ?? 0;
  highscores[1] = prefs.getInt('medium') ?? 0;
  highscores[2] = prefs.getInt('hard') ?? 0;
  bool darkMode = prefs.getBool('darkMode') ?? false;
  Color textColor;
  if (darkMode) {
    textColor = Colors.black54;
  } else {
    textColor = Colors.white;
  }
  runApp(
      MyApp(highscores: highscores, darkMode: darkMode, textColor: textColor));
}

class MyApp extends StatelessWidget {
  final List<int> highscores;
  final bool darkMode;
  final Color textColor;
  const MyApp(
      {super.key,
      required this.highscores,
      required this.darkMode,
      required this.textColor});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      title: 'Opticolor',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(
          title: 'Opticolor',
          highscores: highscores,
          darkmode: darkMode,
          textColor: textColor),
      debugShowCheckedModeBanner: false,
    );
  }
}
