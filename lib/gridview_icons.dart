import 'package:flutter/material.dart';

class GridViewIcons extends StatefulWidget {
  const GridViewIcons({super.key});

  @override
  _GridViewIconsState createState() => _GridViewIconsState();
}

class _GridViewIconsState extends State<GridViewIcons> {
  final List<String> items = List.generate(100, (index) => 'Item $index');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GridView Sample'),
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, // 3列のGridView
          childAspectRatio: 1.0, // アイテムのアスペクト比
          mainAxisSpacing: 4.0, // 縦の間隔
          crossAxisSpacing: 4.0, // 横の間隔
        ),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              //TODO南くん:ごめん、遷移がうまくできてない..
              Navigator.pop(context);
            },
            child: Card(
              child: Center(
                child: Text(items[index]),
              ),
            ),
          );
        },
        itemCount: items.length,
      ),
    );
  }
}