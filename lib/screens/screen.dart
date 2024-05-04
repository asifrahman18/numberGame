import 'package:dice_game/widgets/action.dart';
import 'package:flutter/material.dart';

class Screen extends StatefulWidget {
  const Screen({super.key});

  @override
  State<Screen> createState() => _ScreenState();
}

class _ScreenState extends State<Screen> {
  void _showGameRulesDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('How to Play'),
          content: const Text(
            '1. Roll the dice by tapping the number.\n'
            '2. If you roll a number that is a multiple of 5, your turn ends, and the other player takes over.\n'
            '3. Hold your score by tapping the "Hold Score" button to add your current turn\'s score to your total score.\n'
            '4. The first player to reach 100 points wins.\n'
            '5. Tap "Restart Game" to start a new game.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/bg.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          Column(
            children: [
              AppBar(
                backgroundColor: Colors.transparent,
                title: const Text('Number Game'),
                actions: [
                  IconButton(
                    icon: const Icon(Icons.help_outline),
                    onPressed: () => _showGameRulesDialog(),
                  ),
                ],
                elevation: 0,
              ),
              const Flexible(
                child: GameAction(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
