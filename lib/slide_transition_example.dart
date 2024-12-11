import 'package:flutter/material.dart';
import 'dart:async';

class SlideTransitionExample extends StatefulWidget {
  const SlideTransitionExample({super.key});

  @override
  SlideTransitionExampleState createState() => SlideTransitionExampleState();
}

class SlideTransitionExampleState extends State<SlideTransitionExample>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;
  bool _isMoved = true;
  late Timer _timer;

  @override
  void initState() {
    super.initState();

    // 初始化動畫控制器
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    // 定義位移動畫範圍
    _animation = Tween<Offset>(
      begin: const Offset(2.0, -1.0), // 從最左邊開始
      end: const Offset(2.0, 2.0), // 滑動到最右邊
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.bounceOut,
    ));

    // 啟動定時器來切換位移
    _timer = Timer.periodic(const Duration(milliseconds: 1500), (timer) {
      setState(() {
        _isMoved = !_isMoved;
        if (_isMoved) {
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
              alignment: Alignment.centerLeft,
              child: SlideTransition(
                position: _animation,
                child: Container(
                  width: constraints.maxWidth * 0.2,
                  height: constraints.maxWidth * 0.2,
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 220, 115, 16),
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
