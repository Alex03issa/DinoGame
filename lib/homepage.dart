import 'dart:async';
import 'package:dinogame/taptoplay.dart';
import 'package:dinogame/barrier.dart';
import 'package:flutter/material.dart';
import 'dino.dart';
import 'gameover.dart';
import 'scorescreen.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Dino variables
  double dinoX = -0.5;
  double dinoY = 1;
  double dinoWidth = 0.6;
  double dinoHeight = 0.3;

  // Barrier variables
  double barrierX = 3;
  double barrierY = 1;
  double barrierWidth = 0.6;
  double barrierHeight = 0.3;

  // Jump variables
  double time = 0;
  double height = 0;
  double gravity = 9.8; // gravity in real life is 9.8
  double velocity = 4; // how strong the jump is

  // Game settings
  bool gameHasStarted = false;
  bool midJump = false; // prevents double jump and stops user from spamming jump
  bool gameOver = false;
  int score = 0;
  int highscore = 0;
  bool dinoPassedBarrier = false;

// This will make the map start moving, i.e., barriers will start to move
  void startGame() {
    setState(() {
      gameHasStarted = true;
    });

    Timer.periodic(Duration(milliseconds: 10), (timer) {
      if (detectCollision()) {
        gameOver = true;
        timer.cancel();
        setState(() {
          if (score > highscore) {
            highscore = score;
          }
        });
      }

      loopBarriers();
      updateScore();

      setState(() {
        barrierX -= 0.01;
      });
    });
  }


// Update score logic
  void updateScore() {
    setState(() {
      if (barrierX < dinoX && !dinoPassedBarrier) {
        score++;
        dinoPassedBarrier = true;
      }
    });
  }

// Loop barriers for the endless runner effect
  void loopBarriers() {
    setState(() {
      if (barrierX <= -2.2) {
        barrierX = 2.2;
        dinoPassedBarrier = false;
      } else {
        barrierX -= 0.01;
      }
    });
  }


// Barrier collision detection
  bool detectCollision() {
    if (barrierX <= dinoX + dinoWidth &&
        barrierX + barrierWidth >= dinoX &&
        dinoY >= barrierY - barrierHeight) {
      return true; // Collision detected
    }
    return false; // No collision
  }


// Dino jump logic
  void jump() {
    midJump = true;
    Timer.periodic(Duration(milliseconds: 10), (timer) {
      height = -gravity / 2 * time * time + velocity * time;

      setState(() {
        if (1 - height > 1) {
          resetJump();
          dinoY = 1;
          timer.cancel();
        } else {
          dinoY = 1 - height;
        }

        if (gameOver) {
          timer.cancel();
        }

        time += 0.01;
      });
    });
  }


// Reset jump logic
  void resetJump() {
    setState(() {
      midJump = false;
      time = 0;  // Reset time for next jump
    });
  }


// Play again logic for restarting the game
  void playAgain() {
    setState(() {
      gameOver = false;
      gameHasStarted = false;
      dinoX = -0.5;
      dinoY = 1;
      barrierX = 3;
      score = 0;
      dinoPassedBarrier = false;
      midJump = false;
      time = 0; // Reset jump time for the new game
    });
  }


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: gameOver
          ? playAgain
          : (gameHasStarted ? (midJump ? null : jump) : startGame),
      child: Scaffold(
        backgroundColor: Colors.grey[300],
        body: Column(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                child: Center(
                  child: Stack(
                    children: [
                      // Ground layer with darker gray
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          color: Colors.grey[800],  // Darker gray for the ground
                          height: 200.0,  // Adjust the height of the ground
                          width: MediaQuery.of(context).size.width,
                        ),
                      ),

                      // Tap to play
                      TapToPlay(gameHasStarted: gameHasStarted),

                      // Game over screen
                      GameOverScreen(gameOver: gameOver),

                      // Score display
                      ScoreScreen(score: score, highscore: highscore),

                      // Dino widget
                      MyDino(
                        dinoX: dinoX,
                        dinoY: dinoY - 0.05,  // Adjust this to position dino properly
                        dinoWidth: dinoWidth,
                        dinoHeight: dinoHeight,
                      ),

                      // Barrier (cactus)
                      MyBarrier(
                        barrierX: barrierX -0.1,
                        barrierY: barrierY - 0.05,  // Adjust this to position the barrier
                        barrierWidth: barrierWidth,
                        barrierHeight: barrierHeight,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


}
