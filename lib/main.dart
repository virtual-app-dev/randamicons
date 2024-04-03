import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

void main() {
  runApp(HomePage());
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      //TODO:ダークモード対応
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(icon: const Icon(Icons.menu), onPressed: () {}),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomRight: Radius.elliptical(90, 30),
            ),
          ),
          elevation: 0,
        ),
        body: MyCustomListView(),
      ),
    );
  }
}

class MyCustomListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 2, // 1行目の特別なアイテム + GridView.builderを含む2つのアイテム
      itemBuilder: (context, index) {
        if (index == 0) {
          // 1行目の特別なアイテム
          return Container(
            padding: const EdgeInsets.all(10),
            child: AnimatedTextKit(
              animatedTexts: [
                TypewriterAnimatedText(
                  'Live a good design life',
                  textStyle: Theme.of(context).textTheme.displayLarge?.copyWith(
                        fontFamily: 'NotoSans',
                      ),
                  speed: const Duration(milliseconds: 200),
                ),
              ],
              totalRepeatCount: 1,
              pause: const Duration(milliseconds: 1000),
              displayFullTextOnTap: true,
              stopPauseOnTap: true,
            ),
          );
        } else {
          // 2行目以降にGridView.builderを使用
          return GridView.builder(
              shrinkWrap: true, // ListView内で正しく表示するためには必須
              physics: NeverScrollableScrollPhysics(), // ListViewのスクロールに従うように
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // 2列で表示
                childAspectRatio: 1,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
              ),
              itemCount: 4, // 表示するアイテムの数
              itemBuilder: (context, gridIndex) {
                switch (gridIndex) {
                  case 0:
                    // 最初のアイテム
                    return Container(
                      alignment: Alignment.center,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(primary: Colors.red),
                        child: Text('アイコンを作る'),
                      ),
                    );
                  case 1:
                    // 2番目のアイテム
                    return Container(
                      alignment: Alignment.center,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(primary: Colors.green),
                        child: Icon(Icons.star),
                      ),
                    );
                  case 2:
                    // 3番目のアイテム
                    return Container(
                      alignment: Alignment.center,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(primary: Colors.blue),
                        child: Text('設定'),
                      ),
                    );
                  case 3:
                    // 4番目のアイテム
                    return Container(
                      alignment: Alignment.center,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(primary: Colors.yellow),
                        child: Icon(Icons.accessibility_new),
                      ),
                    );
                  default:
                    // それ以外のアイテム
                    return Container();
                }
              });
        }
      },
    );
  }
}
