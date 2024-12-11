import 'package:flutter/material.dart';
import 'dart:async';

class AnimatedListExample extends StatefulWidget {
  const AnimatedListExample({super.key});

  @override
  AnimatedListExampleState createState() => AnimatedListExampleState();
}

class AnimatedListExampleState extends State<AnimatedListExample> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  final List<int> _items = [];
  late Timer _timer;
  int _nextItem = 0;

  @override
  void initState() {
    super.initState();

    // 定期新增和移除項目
    _timer = Timer.periodic(const Duration(milliseconds: 1500), (timer) {
      setState(() {
        if (_items.isNotEmpty && _nextItem % 2 == 0) {
          _removeItem(0);
        } else {
          _addItem();
        }
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel(); // 停止 Timer，避免內存洩漏
    super.dispose();
  }

  void _addItem() {
    final int index = _items.length;
    _items.add(_nextItem++);
    _listKey.currentState
        ?.insertItem(index, duration: const Duration(milliseconds: 500));
  }

  void _removeItem(int index) {
    final int removedItem = _items.removeAt(index);
    _listKey.currentState?.removeItem(
      index,
      (context, animation) => _buildItem(removedItem, animation),
      duration: const Duration(milliseconds: 500),
    );
  }

  Widget _buildItem(int item, Animation<double> animation) {
    return SizeTransition(
      sizeFactor: animation,
      child: Card(
        color: Colors.blue,
        child: ListTile(
          title: Text(
            'Item $item',
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Padding(
          padding: EdgeInsets.only(top: constraints.maxHeight * 0.2),
          child: AnimatedList(
            key: _listKey,
            initialItemCount: _items.length,
            itemBuilder: (context, index, animation) =>
                _buildItem(_items[index], animation),
          ),
        );
      },
    );
  }
}
