import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'mainMenu/homepage.dart';

void main() async {
  int highscore = await getHighscore();
  runApp(MyApp(highscore: highscore));
}

Future<int> getHighscore() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final savedHighscore = prefs.getInt('highscore') ?? 0;
  return savedHighscore as int;
}

class MyApp extends StatelessWidget {
  final int highscore;
  const MyApp({super.key, required this.highscore});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page', highscore: highscore),
      debugShowCheckedModeBanner: false,
    );
  }
}
