import 'package:flutter/material.dart';
import 'dart:async';

class AnimatedModalBarrierExample extends StatefulWidget {
  const AnimatedModalBarrierExample({super.key});

  @override
  AnimatedModalBarrierExampleState createState() =>
      AnimatedModalBarrierExampleState();
}

class AnimatedModalBarrierExampleState
    extends State<AnimatedModalBarrierExample> {
  bool _isBarrierVisible = false;
  late Timer _timer;

  @override
  void initState() {
    super.initState();

    // 定期切換 Barrier 的可見性
    _timer = Timer.periodic(const Duration(milliseconds: 1000), (timer) {
      setState(() {
        _isBarrierVisible = !_isBarrierVisible;
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
    return Stack(
      children: [
        Align(
          alignment: Alignment.center,
          child: ElevatedButton(
            onPressed: () {},
            child: Text(_isBarrierVisible ? 'Cannot Press' : 'Press Me'),
          ),
        ),
        if (_isBarrierVisible)
          AnimatedModalBarrier(
            color: AlwaysStoppedAnimation<Color>(
              _isBarrierVisible ? Colors.black54 : Colors.transparent,
            ),
            dismissible: true,
          ),
      ],
    );
  }
}

void main() => runApp(AnimatedModalBarrierExample());
