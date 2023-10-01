import 'package:async/async.dart';

class Difficulty {
  int id;
  RestartableTimer timer;
  int countdown;
  String difficulty;
  bool tileColor;

  Difficulty(
      this.id, this.timer, this.countdown, this.difficulty, this.tileColor);
}
