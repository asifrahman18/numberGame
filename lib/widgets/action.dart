import 'package:flutter/material.dart';
import 'package:dice_game/widgets/game_logic.dart';

class GameAction extends StatefulWidget {
  const GameAction({super.key});

  @override
  State<GameAction> createState() {
    return _GameActionState();
  }
}

class _GameActionState extends State<GameAction> {
  final GameLogic _gameLogic = GameLogic();
  int _num = 0;
  int _score = 0;
  int _score1 = 0;
  int _tempScore = 0;
  int _activePlayer = 1;
  Widget _playerTitle = Container(
    decoration: BoxDecoration(border: Border.all()),
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
    color: Color(Colors.amber.value),
    child: const Text('Player 1'),
  );
  Widget _playerTitle1 = const Text('Player 2');

  void _rollHandler() {
    setState(() {
      _num = _gameLogic.rollDice();
      if (_gameLogic.isMultipleOfFive(_num)) {
        _tempScore = 0;
        if (_activePlayer == 1) {
          _activePlayer = 2;
          _updatePlayerTitles();
        } else {
          _activePlayer = 1;
          _updatePlayerTitles();
        }
      } else {
        _tempScore += _num;
      }
    });
  }

  void _holdScoreHandler() {
    setState(() {
      if (_activePlayer == 1) {
        _score += _tempScore;
        _checkWinCondition(1, _score);
        _activePlayer = 2;
        _tempScore = 0;
        _num = 0;
        _updatePlayerTitles();
      } else {
        _score1 += _tempScore;
        _checkWinCondition(2, _score1);
        _activePlayer = 1;
        _tempScore = 0;
        _num = 0;
        _updatePlayerTitles();
      }
    });
  }

  void _resetScoreHandler() {
    setState(() {
      _activePlayer = 1;
      _score = 0;
      _score1 = 0;
      _tempScore = 0;
      _num = 0;
      _playerTitle = Container(
        decoration: BoxDecoration(
          border: Border.all(),
          color: Color(Colors.amber.value),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
        child: const Text('Player 1'),
      );
      _playerTitle1 = const Text('Player 2');
    });
  }

  void _updatePlayerTitles() {
    setState(() {
      if (_activePlayer == 1) {
        _playerTitle = Container(
          decoration: BoxDecoration(
            border: Border.all(),
            color: Color(Colors.amber.value),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
          child: const Text('Player 1'),
        );
        _playerTitle1 = const Text('Player 2');
      } else {
        _playerTitle = const Text('Player 1');
        _playerTitle1 = Container(
          decoration: BoxDecoration(
            border: Border.all(),
            color: Color(Colors.amber.value),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
          child: const Text('Player 2'),
        );
      }
    });
  }

  void _checkWinCondition(int playerNumber, int score) {
    if (score >= 100) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Player $playerNumber won!'),
            actions: [
              TextButton(
                onPressed: () {
                  _resetScoreHandler();
                  Navigator.of(context).pop();
                },
                child: const Text('Play Again'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _playerTitle,
            const SizedBox(
              width: 50,
            ),
            _playerTitle1,
          ],
        ),
        const SizedBox(
          height: 50,
        ),
        TextButton(
          onPressed: _rollHandler,
          child: Text(
            _num.toString(),
            style: const TextStyle(fontSize: 70),
          ),
        ),
        const SizedBox(
          height: 50,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 5),
              decoration: BoxDecoration(
                border: Border.all(),
                color: Color(const Color.fromARGB(255, 215, 255, 216).value),
              ),
              child: Text(_score.toString()),
            ),
            const SizedBox(
              width: 50,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 5),
              decoration: BoxDecoration(
                border: Border.all(),
                color: Color(const Color.fromARGB(255, 215, 255, 216).value),
              ),
              child: Text(_score1.toString()),
            ),
          ],
        ),
        const SizedBox(
          height: 50,
        ),
        ElevatedButton(
          onPressed: _holdScoreHandler,
          child: const Text('Hold Score'),
        ),
        const SizedBox(
          height: 30,
        ),
        TextButton(
          onPressed: _resetScoreHandler,
          child: const Text('Restart Game'),
        ),
      ],
    );
  }
}
