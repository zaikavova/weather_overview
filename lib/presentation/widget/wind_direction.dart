import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:weather_overview/presentation/index.dart';

class WindDirectionIndicator extends StatelessWidget {
  const WindDirectionIndicator({
    super.key,
    required this.weatherPM,
    this.size = 64,
    this.color,
  });

  final double size;
  final WeatherPM weatherPM;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    var iconRotationOffset = 90;
    return SizedBox(
      width: size,
      height: size,
      child: Column(
        children: [
          Expanded(
            child: AspectRatio(
              aspectRatio: 1,
              child: CustomPaint(
                painter: _WindDirectionPainter(
                  weatherPM.windDirection,
                  color ??
                      Theme.of(context).textTheme.bodyLarge?.color ??
                      Colors.black,
                ),
                child: Transform.rotate(
                  angle: _calculateRotation(iconRotationOffset),
                  child: SizedBox(
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Icon(Icons.arrow_right_alt_sharp),
                    ),
                    height: size,
                    width: size,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 4,
          ),
          Text(weatherPM.localizedWindDirectionString),
        ],
      ),
    );
  }

  double _calculateRotation(int iconRotationOffset) =>
      (weatherPM.windDirection - iconRotationOffset) * math.pi / 180;
}

class _WindDirectionPainter extends CustomPainter {
  _WindDirectionPainter(this.azimut, this.color);

  final double azimut;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint iconPaint = Paint()
      ..color = color
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;
    var widthCenterOffset = size.width / 2;
    var heightCenterOffset = size.height / 2;
    canvas.drawCircle(Offset(widthCenterOffset, heightCenterOffset),
        widthCenterOffset, iconPaint);
    canvas.save();
    for (var i = 1; i <= 4; i++) {
      canvas.drawLine(Offset(widthCenterOffset, size.height / 8),
          Offset(widthCenterOffset, 0), iconPaint);
      canvas.rotate(math.pi / 2);
      canvas.translate(0, -size.width);
    }
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant _WindDirectionPainter oldDelegate) =>
      oldDelegate.azimut != azimut || oldDelegate.color != color;
}
