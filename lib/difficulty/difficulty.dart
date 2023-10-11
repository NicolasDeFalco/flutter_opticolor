import 'package:async/async.dart';

class Difficulty {
  RestartableTimer timer;
  final int countdown;
  final String difficulty;
  final bool tileColor;

  Difficulty(this.timer, this.countdown, this.difficulty, this.tileColor);
}
