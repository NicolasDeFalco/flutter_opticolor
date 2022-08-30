class ScoreBoard {
  int _score = 0;
  int _highscore = 0;

  ScoreBoard(this._score, this._highscore);

  void setScore(score) {
    _score = score;
  }

  int getScore() {
    return _score;
  }

  void setHighscore(highscore) {
    _highscore = highscore;
  }

  int getHighscore() {
    return _highscore;
  }
}
