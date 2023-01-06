import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:maple_meeting/display/sprite.dart';
import 'Buttons/button.dart';
import 'Buttons/holdDownButton.dart';
import 'package:maple_meeting/player.dart';

/// TODO want my avatar to be able to step on the screen lol.

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

  /// KERNING MAP FLOOR POSITION

  ///TODO FUNNY LET USER DRAW A LINE AND PUT THERE CHARACTER ON THE LINE, AND THATS NEW BASE FLOOR
  ///THEN IF THEY WANT THEY CAN JUMP AND FALL OFF THE BASE FLOOR TO ABYSE OR RESET APP BECAUSE A GHOST POPS UP.
  /// LOOKING FOR THE BODY LIKE BROOK IN ONE PIECE

  // Might delete///////////////////////////////////////////
  // var GameMap = {
  //   'kerning.png' : {'LandScape' : 0.93, 'Portrait' : 1}
  // };
  // Might be deleted for a better method //////////////////

  double MAP_Ground_Y_axis = 0.75;
  ///
  //MOONLIGHT THIEF
  int moonlightThiefSpriteCount = 0;
  double moonlightThiefPosX = 0.5;
  String moonlightThiefDirection = 'left';

  //BOY CHARACTER
  int charActionCurrentImageNum = 0; // Current image for that action
  int charActionFrameImageCount = 4; // Number of images for that action: stand TODO STAND COUNT
  int movementSpeedMultiplier = 1;
  int jumpHeightMultiplier = 1;
  double boyPosX = -0.5;
  double charPosY = 0.75;

  String boyDirection = 'left';
  String facialExpression = "default";
  String charAction = "stand1_";
  bool inAir = false;
  bool moveBtnDown = false;

  //LOADING SCREEN
  Color hide = Colors.transparent;
  var loadingScreenColor = Colors.transparent;
  var loadingScreenTextColor = Colors.transparent;
  var tapToPlayColor = Colors.white;

  bool gameHasStarted = false;

  /// FUTURE Settings Page content
  bool enableHaptic = false;

  Future<void> runForeverAnimateCharacter() async {
    while (true) { // Cycle through each animations frames from 0 - (framecount - 1) using mod trick
      charActionCurrentImageNum++;
      charActionCurrentImageNum %= charActionFrameImageCount;
      if( charActionCurrentImageNum > charActionFrameImageCount) {
        charActionCurrentImageNum = 0;
      }
      await Future.delayed(Duration(milliseconds: 240));
    }
  }

  Future<void> runForeverGravity() async {

  }


  void playNow() {
    //moveTeddy();
    moveMoonLightThief();
    runForeverAnimateCharacter();
    exit(0); // Everything terminated correctly
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
    charActionFrameImageCount = 4;
    charAction = 'stand1_';
    //print('Image Count: $charActionFrameImageCount \t img#: $charActionCurrentImageNum\n');
  }
  void moveCharacter(String direction){
    boyDirection = direction;
    moveBtnDown = true;
    if(!inAir && moveBtnDown) {
      charAction = "walk1_";         /// BUG :  When these two lines order are swapped we go out of bounds on stand animation frame number
      charActionFrameImageCount = 5; /// TODO if BUG RETURNS of accessing out of bounds images, check type if this ordering matters for which has a larger collection of frames
      boyDirection == 'left' ? boyPosX -= 0.0001975 * movementSpeedMultiplier : boyPosX += 0.0001975 * movementSpeedMultiplier;
      setState(() {});
    }
    // else // In air NOTE : THIS CONDITION IS HANDLED IN JUMP FUNCTION BELOW for air movement
    //print('Image Count: $charActionFrameImageCount \t img#: $charActionCurrentImageNum\n');
  }
  void toggleButton() {
    if(MediaQuery.of(context).orientation == Orientation.portrait){
      movementSpeedMultiplier = 22;
      MAP_Ground_Y_axis = 0.75; // If its Kerning these are hard coded ground coordinates for floor
      if(!inAir) {charPosY = MAP_Ground_Y_axis;} /// TODO if we are not in the air and charPosY on higher platform
    }
    else{
      movementSpeedMultiplier = 12;
      // If its Kerning these are hard coded ground coordinates for floor
      MAP_Ground_Y_axis = 0.93;
      if(!inAir) {charPosY = MAP_Ground_Y_axis;}
    }
    moveBtnDown = !moveBtnDown;
  } /// Needed for setting up automation tests to be able to easily script movement

  void jump({double jumpHeight = 2.0}) {
    if(!inAir){
      //charActionFrameImageCount = 4; /// TODO dont hardcode 4, read folder to get count later
      double time = 0;
      double heightJumped = 0;

      /// NOTE Negative means in the air for CharPosY so if the value is lower than that means the position is in the air above
      /// think opposite so if mapground is >= charPosY that means that charPosY is higher up

      double priorToJumpYPosition = charPosY;
      //print('initial height: $initialHeight\n');
      Timer.periodic(Duration(milliseconds: 60), (timer) {
        time += 0.05;
        heightJumped = jumpHeightMultiplier * (-4.9 * time * time + jumpHeight * time);
        //print('charPosY: $charPosY\n');
        setState(() {
          if (priorToJumpYPosition - heightJumped > priorToJumpYPosition) { /// TODO This will be where i also check if im over an x-axis that has no footholds and can i fall down to base floor code ????
            charPosY = priorToJumpYPosition;
            inAir = false;
            stand1(); // After Done being in jump position, go back to standing animation
            timer.cancel();
          } else {
            charPosY = priorToJumpYPosition - heightJumped;
            inAir = true;
            charActionFrameImageCount = 1; // TODO hard coded to 1 image for jumping, make this read from the assets jump_* count later
            charActionCurrentImageNum = 0;
            charAction = "jump_"; // While in air, display jump action 1 with 1 frame count currently set above to 1
            // condition ? expressionOne : expressionTwo;
            if(moveBtnDown) {
              boyDirection == 'left' ? boyPosX -= 0.0005 * movementSpeedMultiplier : boyPosX += 0.0005 * movementSpeedMultiplier;
            }
          }
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 10,
            child:
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/kerning.png"),
                  fit: BoxFit.cover
                ),
              ), /// Background image for this section of the screen
              child: Stack(
                children: [
                  Container(
                    alignment: Alignment(moonlightThiefPosX, 1),
                    child: MySprite(
                      spriteDirection: moonlightThiefDirection,
                      imagePath:
                          'assets/MoonlightThief/stand_$moonlightThiefSpriteCount.png',
                    ),
                  ), /// MoonThief NPC just stands

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
                  ) /// Character Sprite animated on redraw
                ],
              ), /// [Top section of screen] : {All Sprites on that section}
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
                        leftInset: 0.0,
                        rightInset: 5,
                        topInset: 0,
                        bottomInset: 0,
                        text: 'Smile',
                        onTapFunction: () { facialExpression = 'smile'; },
                        onDoubleTapFunction: () { facialExpression = 'default'; },
                      ), /// SMILE
                      MyButton(
                        leftInset: 0.0,
                        rightInset: 5,
                        topInset: 0,
                        bottomInset: 0,
                        text: 'Angry',
                        onTapFunction: () { facialExpression = 'angry'; },
                        onDoubleTapFunction: () { facialExpression = 'default'; },
                      ), /// ANGRY
                      MyButton(
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
                      //MyButton(
                        leftInset: 0.0,
                        rightInset: MediaQuery.of(context).orientation == Orientation.landscape ? 400 : 400 - 270, /// TODO NOTE: 239 is the number od pixels it went over on the small screen of an iphone X Fix this later
                        topInset: 0,
                        bottomInset: 1,
                        text: '   ↑   ',
                        //onTapFunction: () { jump(jumpHeight: 2.0); }, /// TODO for MYBUTTON in control settings
                        //onDoubleTapFunction: () { jump(jumpHeight: 2.0); }, /// TODO
                        onHoldFunction: () { jump(jumpHeight: 2.0); }, /// TODO For myHoldDownButton in control settings
                        onCancelHoldFunction: () { }, //stand1(); },   /// TODO
                      ), /// UP
                      MyHoldDownButton(
                        leftInset: 1.0,
                        rightInset: 20.0,
                        topInset: 0.0,
                        bottomInset: 1.0,
                        text: '←',
                        onHoldFunction: () { moveCharacter('left'); },
                        onCancelHoldFunction: () { stand1(); charActionCurrentImageNum = 0; toggleButton();}, // on cancel button,
                      ), /// LEFT <-
                      MyHoldDownButton(
                        leftInset: 0.0,
                        rightInset: 1,
                        topInset: 0,
                        bottomInset: 1,
                        text: ' →',
                        onHoldFunction: () { moveCharacter('right'); },
                        onCancelHoldFunction: () { stand1(); toggleButton();}, //charActionCurrentImageNum = 0; }, // on cancel button,
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
