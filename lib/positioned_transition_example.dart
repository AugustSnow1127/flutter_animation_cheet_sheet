import 'package:flutter/material.dart';
import 'dart:async';

class PositionedTransitionExample extends StatefulWidget {
  const PositionedTransitionExample({super.key});

  @override
  PositionedTransitionExampleState createState() =>
      PositionedTransitionExampleState();
}

class PositionedTransitionExampleState
    extends State<PositionedTransitionExample>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<RelativeRect> _positionAnimation;
  late Timer _timer;
  bool _isMoved = false;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    // 定義特別的曲線動畫
    final curve = CurvedAnimation(
      parent: _controller,
      curve: const Cubic(0.68, -0.55, 0.27, 1.55), // 超出回彈效果
    );

    // 初始化位置動畫
    _positionAnimation = RelativeRectTween(
      begin: const RelativeRect.fromLTRB(50, 50, 200, 200),
      end: const RelativeRect.fromLTRB(200, 200, 50, 50),
    ).animate(curve);

    // 使用 Timer 定時切換動畫方向
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
    _timer.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          color: const Color.fromARGB(255, 42, 42, 42),
          child: Stack(
            children: [
              PositionedTransition(
                rect: _positionAnimation,
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 10,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
