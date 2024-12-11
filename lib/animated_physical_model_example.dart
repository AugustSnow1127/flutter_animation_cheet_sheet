import 'package:flutter/material.dart';
import 'dart:async';

class AnimatedPhysicalModelExample extends StatefulWidget {
  const AnimatedPhysicalModelExample({super.key});

  @override
  AnimatedPhysicalModelExampleState createState() =>
      AnimatedPhysicalModelExampleState();
}

class AnimatedPhysicalModelExampleState
    extends State<AnimatedPhysicalModelExample> {
  bool _isFlat = true;
  late Timer _timer;

  @override
  void initState() {
    super.initState();

    // 定期切換陰影效果
    _timer = Timer.periodic(const Duration(milliseconds: 1500), (timer) {
      setState(() {
        _isFlat = !_isFlat;
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
              child: AnimatedPhysicalModel(
                duration: const Duration(milliseconds: 1000),
                curve: Curves.easeInOut,
                shape: BoxShape.rectangle,
                elevation: _isFlat ? 2.0 : 20.0, // 增加顯著的陰影效果
                color: const Color.fromARGB(255, 138, 241, 163),
                shadowColor: Colors.white,
                borderRadius: BorderRadius.zero, // 保持直角
                child: SizedBox(
                  width: constraints.maxWidth * 0.3,
                  height: constraints.maxWidth * 0.3,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
