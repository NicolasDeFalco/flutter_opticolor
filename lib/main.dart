import 'package:flutter/material.dart';
import 'mainMenu/homepage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Opticolor',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const MyHomePage(title: 'Opticolor'),
      debugShowCheckedModeBanner: false,
    );
  }
}
