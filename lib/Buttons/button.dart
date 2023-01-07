import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final text;
  final onTapFunction;
  final onDoubleTapFunction;
  double leftInset = 0.0;
  double topInset = 0.0;
  double rightInset = 10.0;
  double bottomInset = 10.0;
  MyButton(
      {
        required this.text,
        required this.onTapFunction,
        required this.onDoubleTapFunction,
        required this.leftInset,
        required this.rightInset,
        required this.bottomInset,
        required this.topInset,
      });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: //EdgeInsets.all(1),
      EdgeInsets.fromLTRB(leftInset, topInset, rightInset, bottomInset),
      child:
        GestureDetector(
          onTap: onTapFunction,
          onDoubleTap: onDoubleTapFunction,
          onHorizontalDragCancel: onTapFunction,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 6, horizontal: 10),
              color: Colors.blue,
              child: Center(
                child: Text(
                  text,
                  style: TextStyle(color: Colors.white, fontSize: 6),
                ),
              ),
            ),
          ),
        ),
    );
  }
}
