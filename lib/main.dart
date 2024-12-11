import 'package:flutter/material.dart';
import 'package:animation_cheet_sheet/animated_container_example.dart';
import 'package:animation_cheet_sheet/animated_align_example.dart';
import 'package:animation_cheet_sheet/animated_cross_fade_example.dart';
import 'package:animation_cheet_sheet/animated_default_text_style_example.dart';
import 'package:animation_cheet_sheet/animated_list_example.dart';
import 'package:animation_cheet_sheet/animated_modal_barrier_example.dart';
import 'package:animation_cheet_sheet/animated_opacity_example.dart';
import 'package:animation_cheet_sheet/animated_physical_model_example.dart';
import 'package:animation_cheet_sheet/decorated_box_transition_example.dart';
import 'package:animation_cheet_sheet/positioned_transition_example.dart';
import 'package:animation_cheet_sheet/rotation_transition_example.dart';
import 'package:animation_cheet_sheet/scale_transition_example.dart';
import 'package:animation_cheet_sheet/slide_transition_example.dart';
import 'package:animation_cheet_sheet/size_transition_example.dart';
import 'package:animation_cheet_sheet/hero_example.dart';

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
              itemCount: 15,
              itemBuilder: (context, index) {
                return Container(
                  // 最外層：負責繪製邊框與圓角
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: const Color.fromARGB(255, 239, 239, 239),
                      width: 3.0,
                    ),
                  ),
                  // 內層：ClipRRect確保內部內容不超出範圍，並維持相同的圓角
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      color: const Color.fromARGB(255, 42, 42, 42), // 內部底色
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
                    ),
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
      0: const AnimatedContainerExample(),
      1: const AnimatedAlignExample(),
      2: const AnimatedCrossFadeExample(),
      3: const AnimatedDefaultTextStyleExample(),
      4: const AnimatedListExample(),
      5: const AnimatedModalBarrierExample(),
      6: const AnimatedOpacityExample(),
      7: const AnimatedPhysicalModelExample(),
      8: const DecoratedBoxTransitionExample(),
      9: const PositionedTransitionExample(),
      10: const RotationTransitionExample(),
      11: const ScaleTransitionExample(),
      12: const SlideTransitionExample(),
      13: const SizeTransitionExample(),
      14: const HeroExample(),
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
      2: 'AnimatedCrossFade',
      3: 'AnimatedDefaultTextStyle',
      4: 'AnimatedList',
      5: 'AnimatedModalBarrier',
      6: 'AnimatedOpacity',
      7: 'AnimatedPhysicalModel',
      8: 'DecoratedBoxTransition',
      9: 'PositionedTransition',
      10: 'RotationTransition',
      11: 'ScaleTransition',
      12: 'SlideTransition',
      13: 'SizeTransition',
      14: 'Hero',
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
