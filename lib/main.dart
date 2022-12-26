import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'mainMenu/homepage.dart';

void main() async {
  int highscore = await getHighscore();
  runApp(MyApp(highscore: highscore));
}

// Cette fonction va aller chercher la valeur highscore
// qu'on a stockée et va nous la retourné
Future<int> getHighscore() async {
  // Ceci est nécessaire si on veut executer du code avant d'utiliser runApp()
  WidgetsFlutterBinding.ensureInitialized();

  // Va créer une instance de SharedPreferences pour que l'on puisse
  // prendre nos valeurs stockées
  final prefs = await SharedPreferences.getInstance();

  // Va chercher la valeur que l'on souhaite récupérer.
  // Elle nous retournera 0 si elle ne trouve rien.
  final savedHighscore = prefs.getInt('highscore') ?? 0;

  return savedHighscore;
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
