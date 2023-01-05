import 'dart:ffi';

import 'package:maple_meeting/display/sprite.dart';

// MapleCharacter is a Sprite, so we extend sprite class to allow maple character to have a sprite rendered
// [Note] : Sprite returns a container to that image paths asset, meaning a character/image on the screen one frame
class MapleCharacter extends MySprite {
  // fullFrameImagePath = 'assets/CharacterSpriteSheet/$facialExpression/0/$charAction$charActionCurrentImageNum.png',
  String facialExpression;  // 'default', 'smile', 'bewildered', etc..
  String frameSetFolder;         // '/0' is the usual folder
  String action;
  int imageNum;

  //final String fullFrameImagePath;
  final String playerDirection;

  // Player constructor Requires all parameters it needs to Provide to sprite's required parameters
  // This is so Maple Character will always have a returned image to display on screen
  MapleCharacter({
    required this.facialExpression,
    required this.frameSetFolder,
    required this.action,
    required this.imageNum,
    //required this.fullFrameImagePath,
    required this.playerDirection,
  }) : super (
          imagePath: 'assets/CharacterSpriteSheet/$facialExpression/0/$action$imageNum.png',
          spriteDirection: playerDirection
        ); // Call constructor of base class
}