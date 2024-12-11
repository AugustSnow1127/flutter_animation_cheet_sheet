import 'package:flutter/material.dart';

class HeroExample extends StatelessWidget {
  const HeroExample({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: FirstPage(),
    );
  }
}

class FirstPage extends StatelessWidget {
  const FirstPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF333333), // 背景色
      child: Center(
        child: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    const SecondPage(),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  return FadeTransition(opacity: animation, child: child);
                },
              ),
            );
          },
          child: Hero(
            tag: 'floating-button',
            child: Container(
              width: 150,
              height: 150,
              decoration: const BoxDecoration(
                color: Colors.purple,
                shape: BoxShape.circle,
              ),
              child: const Center(
                child: Text(
                  'Press Me',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class SecondPage extends StatelessWidget {
  const SecondPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF444444), // 背景色
      child: Center(
        child: GestureDetector(
          onTap: () {
            Navigator.pop(context); // 點擊返回上一頁
          },
          child: Hero(
            tag: 'floating-button',
            child: Container(
              width: 200, // 放大後的寬度
              height: 200, // 放大後的高度
              decoration: const BoxDecoration(
                color: Colors.orange,
                shape: BoxShape.rectangle,
              ),
              child: const Center(
                child: Text(
                  'Press Again',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
