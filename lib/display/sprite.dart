import 'dart:math';

import 'package:flutter/material.dart';

class MySprite extends StatelessWidget {
  final String imagePath;
  final String spriteDirection;
  const MySprite({
    required this.imagePath, required this.spriteDirection,
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