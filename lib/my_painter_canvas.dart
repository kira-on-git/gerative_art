import 'dart:math';

import 'package:flutter/material.dart';
import 'particle.dart';

Random rgn = Random(DateTime.now().microsecondsSinceEpoch);

Offset polarToCartesian(double speed, double theta) {
  return Offset(speed * cos(theta), speed * sin(theta));
}

class MyPainterCanvas extends CustomPainter {
  List<Particle> particles;
  Random rgn;
  double animValue;
  MyPainterCanvas(this.rgn, this.particles, this.animValue);

  @override
  void paint(Canvas canvas, Size size) {
    //update the objects
    for (var p in particles) {
      var velocity = polarToCartesian(p.speed, p.theta);
      var dx = p.position.dx + velocity.dx;
      var dy = p.position.dy + velocity.dy;
      // if either position falls outside the canvas
      // reinitialize them
      if (p.position.dx < 0 || p.position.dx > size.width) {
        dx = rgn.nextDouble() * size.width;
      }
      if (p.position.dy < 0 || p.position.dy > size.height) {
        dy = rgn.nextDouble() * size.height;
      }
      p.position = Offset(dx, dy);
    }
    //paint the objects
    for (var p in particles) {
      var paint = Paint();
      paint.color = p.color;
      canvas.drawCircle(p.position, p.radius, paint);
    }
    // var dx = size.width / 2;
    // var dy = size.height / 2;
    // var c = Offset(dx, dy);
    // var radius = 100.0;
    // var paint = Paint();
    // paint.color = Colors.red;
    // canvas.drawCircle(c, radius, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
