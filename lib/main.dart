import 'dart:async';
import 'package:flutter/material.dart';
import 'package:maple_meeting/display/sprite.dart';
import 'MapleCharacter.dart';
import 'button.dart';

main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //TEDDY BEAK
  int teddySpriteCount = 0;
  double teddyPosX = 0;
  String teddyDirection = 'right';

  //MOONLIGHT THIEF
  int moonlightThiefSpriteCount = 0;
  double moonlightThiefPosX = 0.5;
  String moonlightThiefDirection = 'left';

  //BOY CHARACTER
  int boySpriteCount = 0;
  double boyPosX = -0.5;
  double charPosY = 1.0;
  String boyDirection = 'left';

  int action_stand1_SpriteCount = 0;
  int action_walk1_SpriteCount = 0;
  int action_jump_SpriteCount = 0;

  String facialExpression = "default";

  //LOADING SCREEN
  Color hide = Colors.transparent;
  var loadingScreenColor = Colors.transparent;
  var loadingScreenTextColor = Colors.transparent;
  var tapToPlayColor = Colors.white;

  bool gameHasStarted = false;

  String charAction = "stand1_";
  Future<void> runForeverAnimateCharacter() async {
    while (true) {
      switch(charAction){
        case "stand1_":
          stand1_(facialExpression: 'default');
          break;
        case "walk_":
          walk1_(facialExpression: 'default');
          break;
        case "jump_":
          jump();
          break;
        default:
          stand1_(facialExpression: 'default');
          break;
      }
      // Pause the function for less than a second
      //print('charAction: $charAction\n');
      await Future.delayed(Duration(milliseconds: 369));
    }
  }

  void playNow() {
    //moveTeddy();
    moveMoonLightThief();
    runForeverAnimateCharacter();
  }

  void moveMoonLightThief() {
    Timer.periodic(Duration(milliseconds: 150), (timer) {
      setState(() {
        moonlightThiefSpriteCount++;

        if (moonlightThiefDirection == 'left') {
          moonlightThiefPosX -= 0.01;
        } else {
          moonlightThiefPosX += 0.01;
        }

        if (moonlightThiefPosX < 0.3) {
          moonlightThiefDirection = 'right';
        } else if (moonlightThiefPosX > 0.6) {
          moonlightThiefDirection = 'left';
        }

        if (moonlightThiefSpriteCount == 4) {
          moonlightThiefSpriteCount = 0;
        }
      });
    });
  }
  void moveTeddy() {
    Timer.periodic(Duration(milliseconds: 100), (timer) {
      setState(() {
        teddySpriteCount++;

        if (teddySpriteCount == 24) {
          teddySpriteCount = 0;
        }
        if ((teddyPosX - boyPosX).abs() > 0.3) {
          if (boyDirection == 'right') {
            teddyPosX = boyPosX + 0.3;
          } else if (boyDirection == 'left') {
            teddyPosX = boyPosX - 0.3;
          }
        }

        if (teddyPosX - boyPosX > 0) {
          teddyDirection = 'left';
        } else {
          teddyDirection = 'right';
        }
      });
    });
  }

  // Changes which from is being displayed of stand1_# from 0 to n-1
  void stand1_({String facialExpression = "default"}){
    Timer.periodic(Duration(milliseconds: 100), (timer) {
      setState(() {
        charAction = "stand1_";
        action_stand1_SpriteCount++;
      });
      if (action_stand1_SpriteCount >= 3) {
        action_stand1_SpriteCount = -1;
      }
      timer.cancel();
    });
  }
  void walk1_({String facialExpression = "default"}){
    Timer.periodic(Duration(milliseconds: 100), (timer) {

      setState(() {
        charAction = "walk1_";
        action_walk1_SpriteCount++;
      });
      if (action_walk1_SpriteCount >= 4) {
        action_walk1_SpriteCount = -1;
      }

      timer.cancel();
    });
  }
  void walkLeft({String facialExpression = "default"}) {
    setState(() {
      charAction = "walk1_";
      boyPosX -= 0.0175;
      boyDirection = 'left';
    });
  }
  void walkRight({String facialExpression = "default"}) {
    setState(() {
      charAction = "walk1_";
      boyPosX += 0.0175;
      boyDirection = 'right';
    });
  }

  void jump({double jumpHeight = 3.5}) {
    double time = 0;
    double height = 0;
    double initialHeight = charPosY;
    print('initial height: $initialHeight\n');
    Timer.periodic(Duration(milliseconds: 60), (timer) {
      time += 0.05;
      height = -4.9 * time * time + jumpHeight * time;
      print('charPosY: $charPosY\n');

      setState(() {
        if (initialHeight - height > 1) {
          charPosY = 1;
          timer.cancel();
          moonlightThiefSpriteCount = 0;
        } else {
          charPosY = initialHeight - height;
          moonlightThiefSpriteCount = 1;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 5,
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/kerning.png"),
                  fit: BoxFit.cover,
                ),
              ),
              child: Stack(
                children: [
                  Container(
                    alignment: Alignment(moonlightThiefPosX, 1),
                    child: MySprite(
                      frameImgNumber: moonlightThiefSpriteCount % 4, // 4 images 0-3
                      spriteDirection: moonlightThiefDirection,
                      imagePath: 'assets/MoonlightThief/stand_$moonlightThiefSpriteCount.png',
                      spriteImgHeight: 50,
                      spriteImgWidth: 50,
                    ),
                  ),

                  // Container( // Create a Teddy Bear on Screen
                  //   alignment: Alignment(teddyPosX, 1),
                  //   child: MySprite(
                  //     frameImgNumber: teddySpriteCount,
                  //     spriteDirection: teddyDirection,
                  //       imagePath: 'assets/teddy/teddy$teddySpriteCount.png',
                  //     spriteImgHeight: 50,
                  //     spriteImgWidth: 50,
                  //   )
                  //   ),

                  Container(
                    alignment: Alignment(boyPosX, charPosY),
                    child: Player(
                      stand1SpriteCount: action_stand1_SpriteCount % 4, // 4 images 0-3 TODO Make a function to count number of stand1_* in folder
                      walk1SpriteCount: action_walk1_SpriteCount % 5, // 5 images 0-4
                      jumpSpriteCount: action_jump_SpriteCount, // 2 images 0-1
                      facialExpression: facialExpression, // default, wink,
                      boyDirection: boyDirection,
                      action: charAction,
                      boySpriteCount: boySpriteCount % 2 + 1,
                      // playerSprite: MySprite(
                      //     imagePath: 'assets/CharacterSpriteSheet/$facialExpression/0/$charAction$action_stand1_SpriteCount.png',
                      //     spriteDirection: boyDirection,
                      //     frameImgNumber: action_stand1_SpriteCount,
                      //     spriteImgHeight: 100, spriteImgWidth: 100)
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: 1,
            color: Colors.black,
          ),
          Expanded(
            child: Container(
              color: Colors.grey[500],
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MyButton(
                        text: '↑',
                        function: () {
                          jump();
                          },
                      ),
                      // MyButton(
                      //   text: 'ATTACK',
                      //   function: () {
                      //     attack();
                      //   },
                      // ),
                      MyButton(
                        text: 'PLAY',
                        function: () { playNow(); },
                      ),
                      MyButton(
                        text: '←',
                        function: () { walkLeft(); },
                      ),
                      MyButton(
                        text: ' →',
                        function: () { walkRight(); },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}