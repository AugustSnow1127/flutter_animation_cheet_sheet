import 'package:flutter/material.dart';
import 'dart:async';

class AnimatedAlignExample extends StatefulWidget {
  const AnimatedAlignExample({super.key});

  @override
  AnimatedAlignExampleState createState() => AnimatedAlignExampleState();
}

class AnimatedAlignExampleState extends State<AnimatedAlignExample> {
  bool _isAlignedLeft = true;
  late Timer _timer;

  @override
  void initState() {
    super.initState();

    _timer = Timer.periodic(const Duration(milliseconds: 1000), (timer) {
      setState(() {
        _isAlignedLeft = !_isAlignedLeft;
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // 獲取父容器的寬高
        final parentWidth = constraints.maxWidth;
        final parentHeight = constraints.maxHeight;

        // 設置對齊位置
        final alignment =
            _isAlignedLeft ? Alignment.bottomLeft : Alignment.topRight;

        return AnimatedAlign(
          alignment: alignment,
          duration: const Duration(seconds: 1),
          curve: Curves.easeInOut,
          child: Container(
            width: parentWidth * 0.2,
            height: parentHeight * 0.2,
            decoration: BoxDecoration(
              color: _isAlignedLeft ? Colors.green : Colors.orange,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        );
      },
    );
  }
}
