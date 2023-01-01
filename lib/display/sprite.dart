import 'dart:math';

import 'package:flutter/material.dart';

class MySprite extends StatelessWidget {
  final int frameImgNumber;
  final int spriteImgHeight, spriteImgWidth;
  final String spriteDirection;
  final String imagePath;
  const MySprite({
        required this.imagePath,
        required this.spriteDirection, required this.frameImgNumber,
        required this.spriteImgHeight, required this.spriteImgWidth,
      });
  // imagePath = example('assets/teddy/teddy$frameImgNumber.png')
  @override
  Widget build(BuildContext context) {
    if (spriteDirection == 'left') {
      return Container(
        alignment: Alignment.bottomCenter,
        height: 50,
        width: 50,
        child: Image.asset(imagePath),
      );
    } else {
      return Transform(
        transform: Matrix4.rotationY(pi),
        alignment: Alignment.center,
        child: Container(
          alignment: Alignment.bottomCenter,
          height: 50,
          width: 50,
          child: Image.asset(imagePath),
        ),
      );
    }
  }
}