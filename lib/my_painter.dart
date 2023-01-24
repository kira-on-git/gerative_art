import 'package:flutter/material.dart';
import 'dart:math';

import 'particle.dart';
import 'my_painter_canvas.dart';

class MyPainter extends StatefulWidget {
  const MyPainter({super.key});

  @override
  State<MyPainter> createState() => _MyPainterState();
}

double maxRadius = 6;
double maxSpeed = 0.2;
double maxTheta = 2.0 * pi;

class _MyPainterState extends State<MyPainter> {
  List<Particle> particles = List.filled(0, Particle());

  @override
  void initState() {
    super.initState();

    particles = List.generate(10, (p) {
      var p = Particle();
      p.color = getRandomColor(rgn);
      p.position = Offset(-1, -1);
      p.speed = rgn.nextDouble() * maxSpeed; // 0 -> 0.2
      p.theta = rgn.nextDouble() * maxTheta; // 0 -> 2pi radians
      p.radius = rgn.nextDouble() * maxRadius;
      return p;
      print(rgn);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomPaint(
      painter: MyPainterCanvas(particles),
      child: Container(
        color: Colors.yellow.withAlpha(1),
      ),
    ));
  }
}
