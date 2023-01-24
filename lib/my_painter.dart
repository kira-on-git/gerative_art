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

class _MyPainterState extends State<MyPainter>
    with SingleTickerProviderStateMixin {
  List<Particle> particles = List.filled(0, Particle());
  late Animation<double> animation;
  late AnimationController controller;

  Color getRandomColor(Random rgn) {
    var a = rgn.nextInt(255);
    var r = rgn.nextInt(255);
    var g = rgn.nextInt(255);
    var b = rgn.nextInt(255);
    return Color.fromARGB(a, r, g, b);
  }

  @override
  void initState() {
    super.initState();
    controller = controller =
        AnimationController(duration: const Duration(seconds: 10), vsync: this);
    animation = Tween<double>(begin: 0, end: 300).animate(controller)
      ..addListener(() {
        setState(() {
          // The state that has changed here is the animation object’s value.
        });
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller.repeat();
        } else if (status == AnimationStatus.dismissed) {
          controller.forward();
        }
      });

    controller.forward();

//initialize particles
    particles = List.generate(300, (p) {
      var p = Particle();
      p.color = getRandomColor(rgn);
      p.position = const Offset(-1, -1);
      p.speed = rgn.nextDouble() * maxSpeed; // 0 -> 0.2
      p.theta = rgn.nextDouble() * maxTheta; // 0 -> 2pi radians
      p.radius = rgn.nextDouble() * maxRadius;
      return p;
      print(rgn);
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomPaint(
      painter: MyPainterCanvas(rgn, particles, animation.value),
      child: Container(
        color: Colors.yellow.withAlpha(1),
      ),
    ));
  }
}
