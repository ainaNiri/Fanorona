import 'package:flutter/material.dart';

class Fanorona extends StatelessWidget {
  const Fanorona({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: RectanglePainter(),
      child: Container(),
    );
  }
}

class RectanglePainter extends CustomPainter{
  @override
  void paint(Canvas canvas, Size size){
    var rectanglePaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    Offset center = Offset(size.width / 11.5, size.height / 3.5);

    canvas.drawRect(center & Size(size.width / 1.2, size.height / 2.2), rectanglePaint);
    canvas.drawLine(Offset(size.width / 11.5, size.height / 3.5), Offset(size.width / 1.088, size.height / 1.353), rectanglePaint);
    canvas.drawLine(Offset(size.width / 1.088, size.height / 3.5), Offset(size.width / 11.5, size.height / 1.351), rectanglePaint);
    canvas.drawLine(Offset(size.width / 11.5, size.height / 1.95), Offset(size.width / 1.088, size.height / 1.95), rectanglePaint);
    canvas.drawLine(Offset(size.width / 1.985, size.height / 3.5), Offset(size.width / 1.985, size.height / 1.353), rectanglePaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}