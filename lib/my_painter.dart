import 'package:flutter/material.dart';

import 'my_painter_canvas.dart';

class MyPainter extends StatefulWidget {
  const MyPainter({super.key});

  @override
  State<MyPainter> createState() => _MyPainterState();
}

class _MyPainterState extends State<MyPainter> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomPaint(
      painter: MyPainterCanvas(),
      child: Container(),
    ));
  }
}
