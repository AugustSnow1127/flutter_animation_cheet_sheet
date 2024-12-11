import 'package:flutter/material.dart';
import 'dart:async';

class AnimatedOpacityExample extends StatefulWidget {
  const AnimatedOpacityExample({super.key});

  @override
  AnimatedOpacityExampleState createState() => AnimatedOpacityExampleState();
}

class AnimatedOpacityExampleState extends State<AnimatedOpacityExample> {
  bool _isVisible = true;
  late Timer _timer;

  @override
  void initState() {
    super.initState();

    // 定期切換透明度
    _timer = Timer.periodic(const Duration(milliseconds: 1500), (timer) {
      setState(() {
        _isVisible = !_isVisible;
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
        return Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: AnimatedOpacity(
                opacity: _isVisible ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 1000),
                curve: Curves.easeInOut,
                child: Container(
                  width: constraints.maxWidth * 0.5,
                  height: constraints.maxWidth * 0.5,
                  color: const Color.fromARGB(255, 243, 33, 222),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
