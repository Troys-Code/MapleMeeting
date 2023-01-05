// import 'package:flutter/material.dart';

// class Player extends StatelessWidget {
  // final int alertSpriteCount; // 4 = alert_0.png, alert_1.png, alert_2.png, alert_3.png
  // final int flySpriteCount; // 3 = fly_0.png, fly_1.png, fly_2.png
  // final int jumpSpriteCount; // 2 = jump_0.png, jump_1.png
  // final int ladderSpriteCount; // 3 = ladder_0.png, ladder_1.png, ladder_2.png
  // final int proneSpriteCount; // 2 = prone_0.png, prone_1.png  // This is Press Down
  // final int proneStabSpriteCount; // 3 = proneStab_0.png, proneStab_1.png, proneStab_2.png
  // final int ropeSpriteCount; // 3 = rope_0.png, rope_1.png, rope_2.png
  // final int shoot1SpriteCount; // 4 = shoot1_0.png, shoot1_1.png, shoot1_2.png, shoot1_3.png
  // final int shoot2SpriteCount; // 6 = shoot2_0.png, shoot2_1.png, shoot2_2.png, shoot2_3.png, shoot2_4.png, shoot2_5.png
  // final int shootFSpriteCount; // 4 = shootF_0.png, shootF_1.png, shootF_2.png, shootF_3.png
  // final int sitSpriteCount; // 2 = sit_0.png, sit_1.png
  // final int stabO1SpriteCount; // 3 = stabO1_0.png, stabO1_1.png, stabO1_2.png
  // final int stabO2SpriteCount; // 3 = stabO2_0.png, stabO2_1.png, stabO2_2.png
  // final int stabOFSpriteCount; // 3 = stabOF_0.png, stabOF_1.png, stabOF_2.png
  // final int stabT1SpriteCount; // 3 = stabT1_0.png, stabT1_1.png, stabT1_2.png
  // final int stabT2SpriteCount; // 3 = stabT2_0.png, stabT2_1.png, stabT2_2.png
  // final int stabTFSpriteCount; // 4 = stabTF_0.png, stabTF_1.png, stabTF_2.png, stabTF_3.png, stabTF_4.png
  // final int stand1SpriteCount; // 4 = stand1_0.png, stand1_1.png, stand1_2.png, stand1_3.png
  // final int stand2SpriteCount; // 4 = stand2_0.png, stand2_1.png, stand2_2.png, stand2_3.png
  // final int swingO1SpriteCount; // 4 = swingO1_0.png, swingO1_1.png, swingO1_2.png, swingO1_3.png
  // final int swingO2SpriteCount; // 4 = swingO2_0.png, swingO2_1.png, swingO2_2.png, swingO2_3.png
  // final int swingO3SpriteCount; // 4 = swingO3_0.png, swingO3_1.png, swingO3_2.png, swingO3_3.png
  // final int swingOFSpriteCount; // 5 = swingOF_0.png, swingOF_1.png, swingOF_2.png, swingOF_3.png, swingOF_4.png,
  // final int swingP1SpriteCount; // 4 = swingP1_0.png, swingO1_1.png, swingO1_2.png, swingO1_3.png
  // final int swingP2SpriteCount; // 4 = swingP2_0.png, swingO2_1.png, swingO2_2.png, swingO2_3.png
  // final int swingPFSpriteCount; // 5 = swingPF_0.png, swingPF_1.png, swingPF_2.png, swingPF_3.png, swingPF_4.png
  // final int swingT1SpriteCount; // 4 = swingT1_0.png, swingT1_1.png, swingT1_2.png, swingT1_3.png
  // final int swingT2SpriteCount; // 4 = swingT2_0.png, swingT2_1.png, swingT2_2.png, swingT2_3.png
  // final int swingT3SpriteCount; // 4 = swingT3_0.png, swingT3_1.png, swingT3_2.png, swingT3_3.png
  // final int swingTFSpriteCount; // 5 = swingTF_0.png, swingTF_1.png, swingTF_2.png, swingTF_3.png, swingTF_4.png,
  // final int walk1SpriteCount; // 5 = walk1_0.png, walk1_1.png, walk1_2.png, walk1_3.png, walk1_4.png,
  // final int walk2SpriteCount; // 5 = walk2_0.png, walk2_1.png, walk2_2.png, walk2_3.png, walk2_4.png,
  // final int walk1SpriteCount;
  // final int jumpSpriteCount;
  // final String facialExpression;
  // final int boySpriteCount;
  // final String boyDirection;

  //final MySprite playerSprite;
  // final String action; // stand1_,walk1_,..
  //
  // Player({
    // required this.alertSpriteCount, // 4 = alert_0.png, alert_1.png, alert_2.png, alert_3.png
    // required this.flySpriteCount, // 3 = fly_0.png, fly_1.png, fly_2.png
    // required this.jumpSpriteCount, // 2 = jump_0.png, jump_1.png
    // required this.ladderSpriteCount, // 3 = ladder_0.png, ladder_1.png, ladder_2.png
    // required this.proneSpriteCount, // 2 = prone_0.png, prone_1.png  // This is Press Down
    // required this.proneStabSpriteCount, // 3 = proneStab_0.png, proneStab_1.png, proneStab_2.png
    // required this.ropeSpriteCount, // 3 = rope_0.png, rope_1.png, rope_2.png
    // required this.shoot1SpriteCount, // 4 = shoot1_0.png, shoot1_1.png, shoot1_2.png, shoot1_3.png
    // required this.shoot2SpriteCount, // 6 = shoot2_0.png, shoot2_1.png, shoot2_2.png, shoot2_3.png, shoot2_4.png, shoot2_5.png
    // required this.shootFSpriteCount, // 4 = shootF_0.png, shootF_1.png, shootF_2.png, shootF_3.png
    // required this.sitSpriteCount, // 2 = sit_0.png, sit_1.png
    // required this.stabO1SpriteCount, // 3 = stabO1_0.png, stabO1_1.png, stabO1_2.png
    // required this.stabO2SpriteCount, // 3 = stabO2_0.png, stabO2_1.png, stabO2_2.png
    // required this.stabOFSpriteCount, // 3 = stabOF_0.png, stabOF_1.png, stabOF_2.png
    // required this.stabT1SpriteCount, // 3 = stabT1_0.png, stabT1_1.png, stabT1_2.png
    // required this.stabT2SpriteCount, // 3 = stabT2_0.png, stabT2_1.png, stabT2_2.png
    // required this.stabTFSpriteCount, // 4 = stabTF_0.png, stabTF_1.png, stabTF_2.png, stabTF_3.png, stabTF_4.png
    // required this.stand1SpriteCount, // 4 = stand1_0.png, stand1_1.png, stand1_2.png, stand1_3.png
    // required this.stand2SpriteCount, // 4 = stand2_0.png, stand2_1.png, stand2_2.png, stand2_3.png
    // required this.swingO1SpriteCount, // 4 = swingO1_0.png, swingO1_1.png, swingO1_2.png, swingO1_3.png
    // required this.swingO2SpriteCount, // 4 = swingO2_0.png, swingO2_1.png, swingO2_2.png, swingO2_3.png
    // required this.swingO3SpriteCount, // 4 = swingO3_0.png, swingO3_1.png, swingO3_2.png, swingO3_3.png
    // required this.swingOFSpriteCount, // 5 = swingOF_0.png, swingOF_1.png, swingOF_2.png, swingOF_3.png, swingOF_4.png,
    // required this.swingP1SpriteCount, // 4 = swingP1_0.png, swingO1_1.png, swingO1_2.png, swingO1_3.png
    // required this.swingP2SpriteCount, // 4 = swingP2_0.png, swingO2_1.png, swingO2_2.png, swingO2_3.png
    // required this.swingPFSpriteCount, // 5 = swingPF_0.png, swingPF_1.png, swingPF_2.png, swingPF_3.png, swingPF_4.png
    // required this.swingT1SpriteCount, // 4 = swingT1_0.png, swingT1_1.png, swingT1_2.png, swingT1_3.png
    // required this.swingT2SpriteCount, // 4 = swingT2_0.png, swingT2_1.png, swingT2_2.png, swingT2_3.png
    // required this.swingT3SpriteCount, // 4 = swingT3_0.png, swingT3_1.png, swingT3_2.png, swingT3_3.png
    // required this.swingTFSpriteCount, // 5 = swingTF_0.png, swingTF_1.png, swingTF_2.png, swingTF_3.png, swingTF_4.png,
    // required this.walk1SpriteCount, // 5 = walk1_0.png, walk1_1.png, walk1_2.png, walk1_3.png, walk1_4.png,
    // required this.walk2SpriteCount, // 5 = walk2_0.png, walk2_1.png, walk2_2.png, walk2_3.png, walk2_4.png,

    // required this.boyDirection,
    // required this.boySpriteCount,
    // required this.facialExpression,
    //required this.playerSprite,
    // required this.action, // stand1_,walk1_,..
//  });
