import 'dart:async';
import 'package:flutter/material.dart';
import 'package:maple_meeting/display/sprite.dart';
import 'Buttons/button.dart';
import 'Buttons/holdDownButton.dart';
import 'package:maple_meeting/player.dart';

main() {
  runApp(MyApp());
}
/// TODO #1 FEATURE IN CHAT /commands to do things
/// ~ like setup a timer race from end to end of screen to settle args
///
/// KEEP IT SIMPLE : DUMMY USER : Requires -> fewest clicks, easiest to understand and find
///
/// UI DESIGN
/// ~ [DIRECTION BUTTONS]  [[ UP : JUMP() ]], [[ LEFT : MOVELEFT() ]], [[ RIGHT : MOVERIGHT() ]]
/// ~ [ICON BUTTON] : Opens a bunch of {EMOTION Icons} possibly in a snackbar
///
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
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
  @override
  void initState() {
    super.initState();
    playNow();
  }

  //MOONLIGHT THIEF
  int moonlightThiefSpriteCount = 0;
  double moonlightThiefPosX = 0.5;
  String moonlightThiefDirection = 'left';

  //BOY CHARACTER
  int charActionCurrentImageNum = 0; // Current image for that action
  int charActionFrameImageCount = 4; // Number of images for that action: stand TODO STAND COUNT
  int movementSpeedMultiplier = 1;
  double boyPosX = -0.5;
  double charPosY = 1.0;
  String boyDirection = 'left';
  String facialExpression = "default";
  String charAction = "stand1_";
  bool inAir = false;

  //LOADING SCREEN
  Color hide = Colors.transparent;
  var loadingScreenColor = Colors.transparent;
  var loadingScreenTextColor = Colors.transparent;
  var tapToPlayColor = Colors.white;

  bool gameHasStarted = false;

  /// Settings Page content
  bool enableHaptic = false;

  Future<void> runForeverAnimateCharacter() async {
    while (true) { // Cycle through each animations frames from 0 - (framecount - 1) using mod trick
      charActionCurrentImageNum++;
      charActionCurrentImageNum %= charActionFrameImageCount;
      if( charActionCurrentImageNum > charActionFrameImageCount) {
        charActionCurrentImageNum = 0;
      }
      await Future.delayed(Duration(milliseconds: 1));
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

  // void moveTeddy() { // Follows you
  //   Timer.periodic(Duration(milliseconds: 100), (timer) {
  //     setState(() {
  //       teddySpriteCount++;
  //
  //       if (teddySpriteCount == 24) {
  //         teddySpriteCount = 0;
  //       }
  //       if ((teddyPosX - boyPosX).abs() > 0.3) {
  //         if (boyDirection == 'right') {
  //           teddyPosX = boyPosX + 0.3;
  //         } else if (boyDirection == 'left') {
  //           teddyPosX = boyPosX - 0.3;
  //         }
  //       }
  //
  //       if (teddyPosX - boyPosX > 0) {
  //         teddyDirection = 'left';
  //       } else {
  //         teddyDirection = 'right';
  //       }
  //     });
  //   });
  // }

  // Changes which from is being displayed of stand1_# from 0 to n-1
  void stand1() {
    inAir = false;
    charActionFrameImageCount = 4;
    charAction = 'stand1_';
    //print('Image Count: $charActionFrameImageCount \t img#: $charActionCurrentImageNum\n');
  }

  void moveLeft() {
      if(!inAir){
        charActionFrameImageCount = 5;
        charAction = "walk1_";
        boyPosX -= 0.001975 * movementSpeedMultiplier;
      }
      else { // Mid air needs higher posX change for smoother movement physics
        boyPosX -= 0.005 * movementSpeedMultiplier;
      }
      //print('Image Count: $charActionFrameImageCount \t img#: $charActionCurrentImageNum\n');
      boyDirection = 'left';
      setState(() {});
  }

  void moveRight() {
    if(!inAir){
      charActionFrameImageCount = 5;
      charAction = "walk1_";
      boyPosX += 0.001975 * movementSpeedMultiplier;
    }
    else { // Mid air needs higher posX change for smoother movement physics
      boyPosX += 0.005 * movementSpeedMultiplier;
    }
    //print('Image Count: $charActionFrameImageCount \t img#: $charActionCurrentImageNum\n');
    boyDirection = 'right';
    setState(() {});
  }

  void jump({double jumpHeight = 5.0}) {
    if(!inAir){
      double time = 0;
      double height = 0;
      double initialHeight = charPosY;
      //print('initial height: $initialHeight\n');
      Timer.periodic(Duration(milliseconds: 70), (timer) {
        time += 0.05;
        height = -4.9 * time * time + jumpHeight * time;
        //print('charPosY: $charPosY\n');
        setState(() {
          if (initialHeight - height > initialHeight) {
            charPosY = 1;
            stand1(); // After Done being in jump position, go back to standing animation
            timer.cancel();
          } else {
            charPosY = initialHeight - height;
            inAir = true;
            charActionFrameImageCount = 1; // TODO hard coded to 1 image for jumping, make this read from the assets jump_* count later
            charActionCurrentImageNum = 0;
            charAction = "jump_"; // While in air, display jump action 1 with 1 frame count currently set above to 1
          }
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if(MediaQuery.of(context).orientation == Orientation.portrait){
      movementSpeedMultiplier = 20;
    }
    else{
      movementSpeedMultiplier = 10;
    }
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 3,
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/kerning.png"),
                  fit: BoxFit.cover,
                ),
              ),
              child: Stack(
                children: [

                  Container( // Moon Thief NPC just stands
                    alignment: Alignment(moonlightThiefPosX, 1),
                    child: MySprite(
                      spriteDirection: moonlightThiefDirection,
                      imagePath:
                          'assets/MoonlightThief/stand_$moonlightThiefSpriteCount.png',
                    ),
                  ),

                  Container(
                      alignment: Alignment(boyPosX, charPosY),
                      child:
                      MapleCharacter(
                        facialExpression: facialExpression,
                        frameSetFolder: "/0",
                        action: charAction,
                        imageNum: charActionCurrentImageNum,
                        playerDirection: boyDirection,
                      )
                  )

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
              child:

              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MyButton(
                        verticalHeight: 10,
                        horizontalWidth: 10,
                        leftInset: 0.0,
                        rightInset: 5,
                        topInset: 0,
                        bottomInset: 0,
                        text: 'Smile',
                        onTapFunction: () { facialExpression = 'smile'; },
                        onDoubleTapFunction: () { facialExpression = 'default'; },
                      ), /// SMILE
                      MyButton(
                        verticalHeight: 10,
                        horizontalWidth: 10,
                        leftInset: 0.0,
                        rightInset: 5,
                        topInset: 0,
                        bottomInset: 0,
                        text: 'Angry',
                        onTapFunction: () { facialExpression = 'angry'; },
                        onDoubleTapFunction: () { facialExpression = 'default'; },
                      ), /// ANGRY
                      MyButton(
                        verticalHeight: 10,
                        horizontalWidth: 10,
                        leftInset: 0.0,
                        rightInset: 0,
                        topInset: 0,
                        bottomInset: 0,
                        text: 'Bewildered',
                        onTapFunction: () { facialExpression = 'bewildered'; },
                        onDoubleTapFunction: () { facialExpression = 'default'; },
                      ), /// Bewildered
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MyHoldDownButton(
                        leftInset: 0.0,
                        rightInset: 10,
                        topInset: 0,
                        bottomInset: 10,
                        text: '   ↑   ',
                        onHoldFunction: () { jump(jumpHeight: 2.0); },
                        onCancelHoldFunction: () { stand1(); },
                      ), /// UP

                      MyHoldDownButton(
                        leftInset: 200.0,
                        rightInset: 0.0,
                        topInset: 0.0,
                        bottomInset: 10.0,
                        text: '←',
                        onHoldFunction: () { moveLeft(); },
                        onCancelHoldFunction: () { stand1(); charActionCurrentImageNum = 0; }, // on cancel button,
                      ), /// LEFT <-
                      MyHoldDownButton(
                        leftInset: 0.0,
                        rightInset: 0,
                        topInset: 0,
                        bottomInset: 10,
                        text: ' →',
                        onHoldFunction: () { moveRight(); },
                        onCancelHoldFunction: () { stand1(); charActionCurrentImageNum = 0; }, // on cancel button,
                      ), /// RIGHT->
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
