import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AvatarPainter extends CustomPainter {
  final DrawableRoot svg;
  final double length;

  AvatarPainter(this.svg, this.length);

  @override
  void paint(Canvas canvas, Size size) {
    svg.scaleCanvasToViewBox(canvas, Size(this.length, this.length));
    svg.clipCanvasToViewBox(canvas);
    svg.draw(canvas, Rect.zero);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
