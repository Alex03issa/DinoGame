import 'package:flutter/material.dart';

class MyBarrier extends StatelessWidget {
  final double barrierX;
  final double barrierY;
  final double barrierWidth;
  final double barrierHeight;

  MyBarrier({
    required this.barrierX,
    required this.barrierY,
    required this.barrierWidth,
    required this.barrierHeight,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment(
        (2 * barrierX + barrierWidth) / (2 - barrierWidth),
        barrierY - 0.5,  // Adjust barrierY to lower it closer to the ground
      ),
      child: Container(
        width: MediaQuery.of(context).size.width * barrierWidth / 2,
        height: MediaQuery.of(context).size.height * barrierHeight / 2,
        child: Image.asset(
          'lib/images/cactus.png',
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
