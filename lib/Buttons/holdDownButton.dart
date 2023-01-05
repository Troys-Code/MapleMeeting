import 'package:flutter/material.dart';
import 'package:holding_gesture/holding_gesture.dart';

class MyHoldDownButton extends StatelessWidget {
  final text;
  final onHoldFunction;
  final onCancelHoldFunction;
  double leftInset = 0.0;
  double topInset = 0.0;
  double rightInset = 10.0;
  double bottomInset = 10.0;
  MyHoldDownButton({
        required this.text,
        required this.onHoldFunction,
        required this.onCancelHoldFunction,
        required this.leftInset,
        required this.rightInset,
        required this.bottomInset,
        required this.topInset,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding:
        EdgeInsets.fromLTRB(leftInset, topInset, rightInset, bottomInset),
        child:
        HoldDetector(
          onTap: onHoldFunction,
          onHold: onHoldFunction,
          onCancel: onCancelHoldFunction,
          enableHapticFeedback: false,
          child: ElevatedButton(
            onPressed: onHoldFunction,
            child: Text(text, style: const TextStyle(color: Colors.white, fontSize: 12),),
          ),
        )
    );
  }
}
