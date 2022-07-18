import 'package:flutter/material.dart';
import 'package:super_todo/styles/colors.dart';

enum BubbleType { sender, receiver }

class Bubble extends StatelessWidget {
  final BubbleType type;
  final String msg;

  const Bubble({Key? key, required this.msg, required this.type})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bgColor = this.type == BubbleType.receiver ? cPrimary : cMute;
    final alignment = this.type == BubbleType.receiver
        ? Alignment.centerLeft
        : Alignment.centerRight;
    final border = this.type == BubbleType.receiver
        ? BorderRadius.only(
            topLeft: Radius.circular(40),
            topRight: Radius.circular(40),
            bottomLeft: Radius.circular(0),
            bottomRight: Radius.circular(40))
        : BorderRadius.only(
            topLeft: Radius.circular(40),
            topRight: Radius.circular(40),
            bottomLeft: Radius.circular(40),
            bottomRight: Radius.circular(0));

    return Align(
      alignment: alignment,
      child: Container(
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: border,
        ),
        padding: EdgeInsets.all(15),
        child: Text(
          this.msg,

          style: TextStyle(color: cLight, fontSize: msg.length < 3 ? 60 : 14),
        ),
      ),
    );
  }
}
