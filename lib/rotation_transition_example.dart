import 'package:flutter/material.dart';
import 'dart:async';

class RotationTransitionExample extends StatefulWidget {
  const RotationTransitionExample({super.key});

  @override
  RotationTransitionExampleState createState() =>
      RotationTransitionExampleState();
}

class RotationTransitionExampleState extends State<RotationTransitionExample>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _rotationAnimation;
  late Timer _timer;
  bool _isRotating = false;

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
      curve: const Cubic(0.42, 0.0, 0.58, 1.0), // 平滑且均勻的曲線
    );

    // 初始化旋轉動畫
    _rotationAnimation = Tween<double>(
      begin: 0.0,
      end: 2.0, // 完整旋轉 360 度 (2π radians)
    ).animate(curve);

    // 使用 Timer 定時切換動畫方向
    _timer = Timer.periodic(const Duration(milliseconds: 1500), (timer) {
      setState(() {
        _isRotating = !_isRotating;
        if (_isRotating) {
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
              Align(
                alignment: Alignment.center,
                child: RotationTransition(
                  turns: _rotationAnimation,
                  child: Container(
                    width: constraints.maxWidth * 0.3,
                    height: constraints.maxWidth * 0.3,
                    decoration: BoxDecoration(
                      color: Colors.yellow,
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
              ),
            ],
          ),
        );
      },
    );
  }
}
