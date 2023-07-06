import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:weather_overview/domain/index.dart';
import 'package:weather_overview/generated/l10n.dart';
import 'package:weather_overview/presentation/index.dart';

class AirQualityIndicator extends StatelessWidget {
  const AirQualityIndicator({
    required this.airConditionPM,
    this.size = 64,
    super.key,
  });

  final AirConditionPM airConditionPM;
  final double size;

  @override
  Widget build(BuildContext context) => SizedBox(
    width: size,
    height: size,
    child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ConstrainedBox(
              constraints: BoxConstraints(maxWidth: size, maxHeight: size),
              child: CustomPaint(
                size: Size(size, size / 2),
                painter: _AirQualityIndicatorCustomPainter(
                    airConditionPM.airQualityIndex,
                    Theme.of(context).colorScheme.onSurface),
              ),
            ),
            Text(
                '${S.of(context).airQualityIndex} - ${airConditionPM.airQualityIndex}'),
          ],
        ),
  );
}

class _AirQualityIndicatorCustomPainter extends CustomPainter {
  _AirQualityIndicatorCustomPainter(this.qualityIndex, this.arrowColor);

  final int qualityIndex;
  final Color arrowColor;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromCenter(
      center: Offset(size.width / 2, size.height),
      width: size.width,
      height: size.height * 2,
    );
    final startAngle = -math.pi;
    final sweepAngle = math.pi;
    final useCenter = false;
    final scalePaint = Paint()
      ..style = PaintingStyle.stroke
      ..shader = ui.Gradient.linear(
        Offset(0, size.height / 2),
        Offset(size.width, size.height / 2),
        [
          Colors.green,
          Colors.yellow,
          Colors.orange,
          Colors.red,
          Colors.deepPurple,
          Colors.black
        ],
        [0, 0.2, 0.4, 0.6, 0.8, 1],
      )
      ..strokeWidth = 4;

    final arrowPaint = Paint()
      ..strokeWidth = 2
      ..color = arrowColor
      ..style = PaintingStyle.stroke;
    canvas.drawArc(rect, startAngle, sweepAngle, useCenter, scalePaint);
    canvas.drawCircle(Offset(size.width / 2, size.height - size.height / 20),
        size.height / 20, arrowPaint);
    canvas.save();
    canvas.translate(size.width / 2, size.height - size.height / 20);
    canvas
        .rotate(math.pi / SpecificationsConstants.AQIUSMaxValue * qualityIndex);
    canvas.drawLine(Offset(0, -size.height / 20),
        Offset(-2 * size.width / 5, 0), arrowPaint);
    canvas.drawLine(Offset(0, size.height / 20), Offset(-2 * size.width / 5, 0),
        arrowPaint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(_AirQualityIndicatorCustomPainter oldDelegate) =>
      oldDelegate.qualityIndex == qualityIndex;
}
