import 'dart:math';

final rand = Random();

class GameLogic {
  int rollDice() {
    return rand.nextInt(10) + 1;
  }

  bool isMultipleOfFive(int number) {
    return number % 5 == 0;
  }
}
