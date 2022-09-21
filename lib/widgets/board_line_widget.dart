import 'package:flutter/material.dart';

class BoardLineWidget extends StatelessWidget {
  const BoardLineWidget.left({required width, required height, Key? key})
      : _width = width,
        _height = height,
        alignment = const Alignment(-1 / 3, -1 / 3),
        super(key: key);

  const BoardLineWidget.right({required width, required height, Key? key})
      : _width = width,
        _height = height,
        alignment = const Alignment(1 / 3, 1 / 3),
        super(key: key);

  const BoardLineWidget.top({required width, required height, Key? key})
      : _width = height,
        _height = width,
        alignment = const Alignment(-1 / 3, -1 / 3),
        super(key: key);

  const BoardLineWidget.bottom({required width, required height, Key? key})
      : _width = height,
        _height = width,
        alignment = const Alignment(1 / 3, 1 / 3),
        super(key: key);

  final double _width;
  final double _height;
  final Alignment alignment;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: SizedBox(
        width: _width,
        height: _height,
        child: CustomPaint(
          painter: LinePainter(),
        ),
      ),
    );
  }
}

class LinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..strokeWidth = size.width
      ..style = PaintingStyle.fill;

    canvas.drawLine(Offset(0 + size.width / 2, 0),
        Offset(0 + size.width / 2, size.height), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
