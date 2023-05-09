import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'dart:ui' as ui;

class ArcProgressIndicator extends StatefulWidget {
  final double minArc;
  final double maxArc;
  final double progress;
  final Color backgroundColor;
  final Color fillColor;
  final String label;
  final double strokeWidth;
  final IndicatorGradient? gradient;

  const ArcProgressIndicator(this.progress,
      {this.minArc = 180,
      this.maxArc = 360,
      this.backgroundColor = Colors.grey,
      this.fillColor = Colors.blue,
      this.label = "",
      this.strokeWidth = 12,
      this.gradient,
      super.key});

  @override
  State<StatefulWidget> createState() => _ArcProgressIndicatorState();
}

class _ArcProgressIndicatorState extends State<ArcProgressIndicator> with SingleTickerProviderStateMixin {
  
  late Animation<double> animation;
  late AnimationController animController;
  
  @override
  void initState() {
    super.initState();

    animController = AnimationController(duration: const Duration(seconds: 1), vsync: this);
  
    animation = Tween(begin: 0.0, end: 1.0)
      .animate(CurvedAnimation(parent: animController, curve: Curves.easeInOutCubic))
      ..addListener(() {
        setState(() {
          
        });
      });
    animController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final maxWidth = constraints.maxWidth;
        final maxHeight = constraints.maxHeight;
        final minDim = math.min(maxWidth, maxHeight);
        return Stack(
          alignment: Alignment.center,
          children: [
            Center(
              child: CustomPaint(
                size: Size(maxWidth, maxHeight),
                painter: ProgressArc(
                  minArc: widget.minArc,
                  maxArc: widget.maxArc,
                  progress: widget.progress * animation.value,
                  backgroundColor: widget.backgroundColor,
                  fillColor: widget.fillColor,
                  strokeWidth: widget.strokeWidth,
                  gradient: widget.gradient
                )
              )
            ),
            Text(widget.label, textAlign: TextAlign.center, style: TextStyle(fontSize: minDim / 3, fontFamily: 'Nunito'))
          ],
        );
      }
    );
  }
}

const deg2rad = math.pi / 180;

class ProgressArc extends CustomPainter {
  double minArc;
  double maxArc;
  double progress;
  Color backgroundColor;
  Color fillColor;
  IndicatorGradient? gradient;
  double strokeWidth;

  ProgressArc({
    required this.minArc,
    required this.maxArc,
    required this.progress,
    required this.backgroundColor,
    required this.fillColor,
    required this.strokeWidth,
    this.gradient
  });

  Paint _createPaint() {
    final paint = Paint();
    paint.strokeCap = StrokeCap.round;
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = strokeWidth;
    return paint;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final startAngle = minArc * deg2rad;
    final endAngle = maxArc * deg2rad;
    final fillAngle = startAngle * (1 - progress) + endAngle * progress;
    final centreAngle = (endAngle + startAngle) / 2 + math.pi;

    final fill = _createPaint();
    fill.color = fillColor;
    if (gradient != null) {
      fill.shader = ui.Gradient.sweep(Offset(size.width / 2, size.height / 2), gradient!.colours, gradient!.stops);
    }

    final background = _createPaint();
    background.color = backgroundColor;
    
    final shadow = _createPaint();
    shadow.color = Colors.white38;
    shadow.maskFilter = MaskFilter.blur(BlurStyle.normal, 2);
    
    canvas.translate(size.width / 2, size.height / 2);
    canvas.rotate(centreAngle);
    canvas.translate(-size.width / 2, -size.height / 2);

    canvas.drawArc(rect, startAngle-centreAngle, endAngle - startAngle, false, shadow); // Shadow
    canvas.drawArc(rect, startAngle-centreAngle, endAngle - startAngle, false, background); // Background
    canvas.drawArc(rect, startAngle-centreAngle, fillAngle - startAngle, false, fill); // Fill
    canvas.drawCircle(Offset.fromDirection(fillAngle - centreAngle, size.width / 2).translate(size.width / 2, size.height / 2), strokeWidth / 4, fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class IndicatorGradient {
  final List<Color> colours;
  final List<double> stops;

  const IndicatorGradient({required this.colours, required this.stops});
}