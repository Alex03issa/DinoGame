import 'package:flutter/material.dart';

class ScoreScreen extends StatelessWidget {
  final int score;
  final int highscore;

  ScoreScreen({required this.score, required this.highscore});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Text(
              'SCORE: $score',
              style: TextStyle(fontSize: 24, color: Colors.black),
            ),
            SizedBox(height: 10),
            Text(
              'HIGHSCORE: $highscore',
              style: TextStyle(fontSize: 24, color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}
