import 'package:flutter/material.dart';
import 'dart:async';

class DecoratedBoxTransitionExample extends StatefulWidget {
  const DecoratedBoxTransitionExample({super.key});

  @override
  DecoratedBoxTransitionExampleState createState() =>
      DecoratedBoxTransitionExampleState();
}

class DecoratedBoxTransitionExampleState
    extends State<DecoratedBoxTransitionExample>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Decoration> _decorationAnimation;
  bool _isHighlighted = false;
  late Timer _timer;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _decorationAnimation = DecorationTween(
      begin: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Colors.blue, Colors.lightBlueAccent],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
          ),
        ],
      ),
      end: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Colors.red, Colors.orangeAccent],
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.9),
            spreadRadius: 5,
            blurRadius: 15,
          ),
        ],
      ),
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    // 定期切換裝飾動畫
    _timer = Timer.periodic(const Duration(milliseconds: 1500), (timer) {
      setState(() {
        _isHighlighted = !_isHighlighted;
        if (_isHighlighted) {
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
        return Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: DecoratedBoxTransition(
                decoration: _decorationAnimation,
                child: Container(
                  width: constraints.maxWidth * 0.5,
                  height: constraints.maxWidth * 0.5,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
