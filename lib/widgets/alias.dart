import 'package:fanorona/variable.dart';
import 'package:flutter/material.dart';

class Alias extends StatelessWidget {
  double dx;
  double dy;
  bool isForAlias;
  void Function()? onTapped;
  Alias({ Key? key , required this.dx, required this.dy, required this.isForAlias, this.onTapped}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: dx,
      top: dy,
      child: GestureDetector(
        onTap:(){
          newBallSelected[0] = dx.toInt();
          newBallSelected[1] = dy.toInt();
          play = false;
          onTapped!();
        },
        child: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: isForAlias ? const Color.fromRGBO(0, 0, 0, 0.08) : Colors.transparent
          ),
        ),
      ),
    );
  }
}