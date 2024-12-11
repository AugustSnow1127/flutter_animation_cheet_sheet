import 'package:flutter/material.dart';
import 'dart:async';

class AnimatedDefaultTextStyleExample extends StatefulWidget {
  const AnimatedDefaultTextStyleExample({super.key});

  @override
  AnimatedDefaultTextStyleExampleState createState() =>
      AnimatedDefaultTextStyleExampleState();
}

class AnimatedDefaultTextStyleExampleState
    extends State<AnimatedDefaultTextStyleExample> {
  bool _isLargeFont = false;
  late Timer _timer;

  @override
  void initState() {
    super.initState();

    // 使用 Timer 每隔 1.5 秒切換狀態
    _timer = Timer.periodic(const Duration(milliseconds: 1000), (timer) {
      setState(() {
        _isLargeFont = !_isLargeFont;
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel(); // 停止 Timer，避免內存洩漏
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final parentWidth = constraints.maxWidth;

        return Center(
          child: AnimatedDefaultTextStyle(
            style: TextStyle(
              fontSize: _isLargeFont ? parentWidth * 0.1 : parentWidth * 0.05,
              color: _isLargeFont ? Colors.purple : Colors.orange,
              fontWeight: _isLargeFont ? FontWeight.bold : FontWeight.normal,
            ),
            duration: const Duration(seconds: 1),
            curve: Curves.easeInOut,
            child: const Text('Dynamic Text Style!'),
          ),
        );
      },
    );
  }
}
