import 'package:flutter/material.dart';
import 'dart:async';

class AnimatedCrossFadeExample extends StatefulWidget {
  const AnimatedCrossFadeExample({
    super.key,
  });

  @override
  AnimatedCrossFadeExampleState createState() =>
      AnimatedCrossFadeExampleState();
}

class AnimatedCrossFadeExampleState extends State<AnimatedCrossFadeExample> {
  bool _showFirst = true;
  late Timer _timer;

  @override
  void initState() {
    super.initState();

    // 使用 Timer 每隔 1.5 秒切換狀態
    _timer = Timer.periodic(const Duration(milliseconds: 1500), (timer) {
      setState(() {
        _showFirst = !_showFirst;
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
          child: AnimatedCrossFade(
            firstChild: Container(
              width: parentWidth * 0.5,
              height: parentWidth * 0.5,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Center(
                child: Text(
                  'First',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
            ),
            secondChild: Container(
              width: parentWidth * 0.5,
              height: parentWidth * 0.5,
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Center(
                child: Text(
                  'Second',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
            ),
            crossFadeState: _showFirst
                ? CrossFadeState.showFirst
                : CrossFadeState.showSecond,
            duration: const Duration(seconds: 1),
          ),
        );
      },
    );
  }
}
