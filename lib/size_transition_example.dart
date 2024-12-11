import 'package:flutter/material.dart';
import 'package:animation_cheet_sheet/triangle_painter.dart';

class SizeTransitionExample extends StatefulWidget {
  const SizeTransitionExample({super.key});

  @override
  SizeTransitionExampleState createState() => SizeTransitionExampleState();
}

class SizeTransitionExampleState extends State<SizeTransitionExample>
    with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 3),
    vsync: this,
  )..repeat();
  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.fastOutSlowIn,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Transform.translate(
          offset:
              Offset(0, constraints.maxHeight * 0.5 - 50), // 位移到垂直中心，扣除三角形一半高度
          child: SizeTransition(
            sizeFactor: _animation,
            axis: Axis.horizontal,
            axisAlignment: 0.0,
            child: CustomPaint(
              size: const Size(100, 100), // 將三角形縮小至 0.5 倍大小
              painter: TrianglePainter(color: Colors.blue),
            ),
          ),
        );
      },
    );
  }
}
