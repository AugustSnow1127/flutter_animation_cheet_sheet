import 'package:flutter/material.dart';
import 'dart:async';

class AnimatedContainerExample extends StatefulWidget {
  const AnimatedContainerExample({super.key});

  @override
  AnimatedContainerExampleState createState() =>
      AnimatedContainerExampleState();
}

class AnimatedContainerExampleState extends State<AnimatedContainerExample> {
  bool _isExpanded = false;
  late Timer _timer;

  @override
  void initState() {
    super.initState();

    _timer = Timer.periodic(const Duration(milliseconds: 1500), (timer) {
      setState(() {
        _isExpanded = !_isExpanded;
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
        // 獲取父容器的寬度
        final parentWidth = constraints.maxWidth;

        // 動態計算寬高
        final width = _isExpanded ? parentWidth * 0.3 : parentWidth * 0.5;
        final height = _isExpanded ? parentWidth * 0.5 : parentWidth * 0.2;

        return AnimatedContainer(
          width: width,
          height: height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(_isExpanded ? 50 : 0),
            color: _isExpanded ? Colors.blue : Colors.red,
          ),
          duration: const Duration(seconds: 1),
          curve: Curves.easeInOut,
        );
      },
    );
  }
}
