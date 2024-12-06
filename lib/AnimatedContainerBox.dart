import 'package:flutter/material.dart';

class AnimatedContainerBox extends StatefulWidget {
  final int index;

  const AnimatedContainerBox({super.key, required this.index});

  @override
  AnimatedContainerBoxState createState() => AnimatedContainerBoxState();
}

class AnimatedContainerBoxState extends State<AnimatedContainerBox> {
  bool _isExpanded = false;

  void _toggleContainer() {
    setState(() {
      _isExpanded = !_isExpanded; // 切換狀態
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggleContainer, // 點擊切換動畫
      child: AnimatedContainer(
        width: _isExpanded ? 150 : 300, // 寬度改變
        height: _isExpanded ? 300 : 100, // 高度改變
        color: _isExpanded ? Colors.blue : Colors.red, // 顏色改變
        duration: const Duration(seconds: 1), // 動畫持續時間
        curve: Curves.easeInOut, // 動畫曲線
        child: const Center(
          child: Text(
            'Tap Me!',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
