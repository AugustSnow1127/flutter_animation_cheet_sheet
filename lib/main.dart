import 'package:flutter/material.dart';

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
        backgroundColor: const Color.fromARGB(255, 55, 55, 55),
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
                return Card(
                  color: Colors.white.withOpacity(1.0 - (index % 10) * 0.03),
                  child: Center(
                    child: Text(
                      'Item $index',
                      style: const TextStyle(color: Colors.black, fontSize: 18),
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
}
