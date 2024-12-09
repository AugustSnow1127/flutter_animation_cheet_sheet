import 'package:flutter/material.dart';
import 'package:animation_cheet_sheet/AnimatedContainerBox.dart';
import 'package:animation_cheet_sheet/AnimatedAlignBox.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    double maxCrossAxisExtent = screenWidth > 1200
        ? 300 // 超大螢幕
        : screenWidth > 800
            ? 400 // 中型螢幕
            : 600; // 小螢幕

    return MaterialApp(
      home: Scaffold(
        backgroundColor: const Color.fromARGB(255, 42, 42, 42),
        body: SafeArea(
          child: Center(
            child: GridView.builder(
              padding: const EdgeInsets.all(10.0),
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: maxCrossAxisExtent,
                mainAxisSpacing: 10.0,
                crossAxisSpacing: 10.0,
                childAspectRatio: 1,
              ),
              itemCount: 10,
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12), // 圓角
                    border: Border.all(
                      color: const Color.fromARGB(255, 239, 239, 239), // 邊框顏色
                      width: 3.0, // 邊框寬度
                    ),
                  ),
                  child: Stack(
                    children: [
                      Center(
                        child: _buildGridItem(index),
                      ),
                      Positioned(
                        top: 12,
                        left: 12,
                        child: _buildTopLeftLabel(index),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGridItem(int index) {
    final widgetMap = {
      0: AnimatedContainerBox(index: index),
      1: AnimatedAlignBox(index: index),
    };

    // 如果存在對應的 Widget，返回；否則返回默認 Text
    return widgetMap[index] ??
        Text(
          'Item $index', // 默認顯示文字
          style: const TextStyle(
              fontSize: 16, color: Color.fromARGB(255, 191, 191, 191)),
        );
  }

  Widget _buildTopLeftLabel(int index) {
    final labelMap = {
      0: 'AnimatedContainer',
      1: 'AnimatedAlign',
    };

    // 如果存在對應的 Label，返回；否則返回默認 Label
    return Text(
      labelMap[index] ?? 'Label $index',
      style: const TextStyle(
        fontSize: 18,
        color: Color.fromARGB(255, 235, 235, 211),
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
