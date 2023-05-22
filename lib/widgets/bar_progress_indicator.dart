import 'package:flutter/material.dart';

// A prototype progress bar widget
class BarProgressIndicator extends StatefulWidget {
  final double progress;
  final Color backgroundColor;
  final Color fillColor;
  final double strokeWidth;

  const BarProgressIndicator({
    required this.progress,
    this.backgroundColor = Colors.grey,
    this.fillColor = Colors.blue,
    this.strokeWidth = 12,
    super.key
  });

  @override
  State<StatefulWidget> createState() => _BarProgressIndicatorState();
}

class _BarProgressIndicatorState extends State<BarProgressIndicator> with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController animController;
  
  @override
  void initState() {
    super.initState();

    animController = AnimationController(duration: const Duration(seconds: 1), vsync: this);
  
    animation = Tween(begin: 0.0, end: 1.0)
      .animate(CurvedAnimation(parent: animController, curve: Curves.easeInOutCubic))
      ..addListener(() {
        setState(() {});
      });
    animController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final maxWidth = constraints.maxWidth;
        final maxHeight = constraints.maxHeight;
        return CustomPaint(
          size: Size(maxWidth, maxHeight),
          painter: ProgressBar(
            progress: widget.progress * animation.value,
            backgroundColor: widget.backgroundColor,
            fillColor: widget.fillColor,
            strokeWidth: widget.strokeWidth,
          )
        );
      }
    );
  }
}

class ProgressBar extends CustomPainter {
  double progress;
  Color backgroundColor;
  Color fillColor;
  double strokeWidth;

  ProgressBar({
    required this.progress,
    required this.backgroundColor,
    required this.fillColor,
    required this.strokeWidth,
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
    final fill = _createPaint();
    fill.color = fillColor;

    final background = _createPaint();
    background.color = backgroundColor;
    
    final shadow = _createPaint();
    shadow.color = Colors.white38;
    shadow.maskFilter = const MaskFilter.blur(BlurStyle.normal, 2);

    canvas.drawLine(Offset.zero, Offset(size.width, 0), shadow);
    canvas.drawLine(Offset.zero, Offset(size.width, 0), background);
    canvas.drawLine(Offset.zero, Offset(size.width, 0), fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}