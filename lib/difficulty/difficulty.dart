import 'package:async/async.dart';

class Difficulty {
  final int id;
  RestartableTimer timer;
  final int countdown;
  final String difficulty;
  final bool tileColor;

  Difficulty(
      this.id, this.timer, this.countdown, this.difficulty, this.tileColor);
}
