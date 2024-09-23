import 'package:flutter/material.dart';

class MyDino extends StatelessWidget {
  final double dinoX;
  final double dinoY;
  final double dinoWidth;
  final double dinoHeight;

  MyDino({
    required this.dinoX,
    required this.dinoY,
    required this.dinoWidth,
    required this.dinoHeight,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment(
        (2 * dinoX + dinoWidth) / (2 - dinoWidth),
        dinoY - 0.5,  // Adjust dinoY to lift the dino higher above the ground
      ),
      child: Container(
        height: MediaQuery.of(context).size.height * 2 / 3 * dinoHeight,
        width: MediaQuery.of(context).size.width * dinoWidth / 2,
        child: Image.asset(
          'lib/images/dino.png',
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
