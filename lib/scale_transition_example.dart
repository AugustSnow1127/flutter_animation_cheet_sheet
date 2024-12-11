import 'package:flutter/material.dart';
import 'dart:async';

class ScaleTransitionExample extends StatefulWidget {
  const ScaleTransitionExample({super.key});

  @override
  ScaleTransitionExampleState createState() => ScaleTransitionExampleState();
}

class ScaleTransitionExampleState extends State<ScaleTransitionExample>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _isScaledUp = true;
  late Timer _timer;

  @override
  void initState() {
    super.initState();

    // 初始化動畫控制器
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    // 定義動畫範圍
    _animation = Tween<double>(
      begin: 1.0, // 初始縮放大小
      end: 2, // 放大的縮放大小
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    // 啟動定時器來切換縮放
    _timer = Timer.periodic(const Duration(milliseconds: 1000), (timer) {
      setState(() {
        _isScaledUp = !_isScaledUp;
        if (_isScaledUp) {
          _controller.forward();
        } else {
          _controller.reverse();
        }
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel(); // 停止 Timer，避免內存洩漏
    _controller.dispose(); // 釋放動畫控制器資源
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: ScaleTransition(
                scale: _animation,
                child: Container(
                  width: constraints.maxWidth * 0.3,
                  height: constraints.maxWidth * 0.3,
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 248, 89, 142),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
