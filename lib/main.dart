

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

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
          leading: IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () {}), //TODO:設定への遷移を追加
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

class MyCustomListView extends StatefulWidget {
  @override
  _MyCustomListViewState createState() => _MyCustomListViewState();
}

class _MyCustomListViewState extends State<MyCustomListView> {
  bool _isAnimationPlayed = false; // アニメーションの状態を追跡するフラグ

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 3, // 1行目の特別なアイテム + GridView.builderを含む2つのアイテム
      itemBuilder: (context, index) {
        if (index == 0) {
          // 1行目の特別なアイテム
          return !_isAnimationPlayed
              ? Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  child: AnimatedTextKit(
                    animatedTexts: [
                      TypewriterAnimatedText(
                        'Live a good design life', //TODO:文字を検討
                        textStyle:
                            Theme.of(context).textTheme.displayLarge?.copyWith(
                                  fontFamily: 'fonts/asset/Now-Regular.otf',
                                ),
                        speed: const Duration(milliseconds: 200),
                      ),
                    ],
                    totalRepeatCount: 1,
                    pause: const Duration(milliseconds: 800),
                    displayFullTextOnTap: true,
                    stopPauseOnTap: true,
                    onFinished: () {
                      setState(() {
                        _isAnimationPlayed = true; // アニメーションが終了したらフラグを更新
                      });
                    },
                  ),
                )
              : Container(
                  // アニメーションが完了した後に表示するウィジェット
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    'Live a good design life', //TODO:文字を検討
                    style: Theme.of(context).textTheme.displayLarge?.copyWith(
                          fontFamily: 'fonts/asset/Now-Regular.otf',
                        ),
                  ),
                );
        } else if (index == 1) {
          // 2行目以降にGridView.builderを使用
          return GridView.builder(
              shrinkWrap: true, // ListView内で正しく表示するためには必須
              physics: NeverScrollableScrollPhysics(), // ListViewのスクロールに従うように
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // 1列で表示
                childAspectRatio: 1,
              ),
              itemCount: 2, // 表示するアイテムの数
              itemBuilder: (context, gridIndex) {
                switch (gridIndex) {
                  case 0:
                    // 最初のアイテム
                    return Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Container(
                        alignment: Alignment.center,
                        child: FractionallySizedBox(
                          widthFactor: 1,
                          heightFactor: 1,
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red, // ボタンの内側のパディング
                              shape: RoundedRectangleBorder(
                                // ボタンの形状
                                borderRadius:
                                    BorderRadius.circular(12.0), // 角の丸み
                              ),
                            ),
                            child: Text('アイコンを変更'),
                          ),
                        ),
                      ),
                    );
                  case 1:
                    // 2番目のアイテム
                    return Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Container(
                        alignment: Alignment.center,
                        child: FractionallySizedBox(
                          widthFactor: 1,
                          heightFactor: 1,
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red, // ボタンの内側のパディング
                              shape: RoundedRectangleBorder(
                                // ボタンの形状
                                borderRadius:
                                    BorderRadius.circular(12.0), // 角の丸み
                              ),
                            ),
                            child: Text('背景色を変更'),
                          ),
                        ),
                      ),
                    );
                  default:
                    return Container();
                }
              });
        } else if (index == 2) {
          // index == 2の場合の特別なウィジェットをここに配置します
          return Container(
            padding: const EdgeInsets.all(10),
            alignment: Alignment.center,
            child: Column(
              mainAxisSize: MainAxisSize.min, // 子ウィジェットのサイズに合わせてColumnのサイズを調整
              children: [
                SizedBox(height: 10), // 元々テキストがあった部分とデザイン要素の間にスペースを追加
                Container(
                  width: double.infinity, // 親ウィジェットの幅に合わせる
                  height: 300, // 高さを200に設定
                  decoration: BoxDecoration(
                    color: Colors.blue[100], // 背景色を薄い青に設定
                    borderRadius: BorderRadius.circular(12), // 角を丸くする
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5), // 影の色
                        spreadRadius: 5, // 影の広がり
                        blurRadius: 7, // 影のぼかし
                        offset: Offset(0, 3), // 影の方向
                      ),
                    ],
                  ),
                  // ここに追加のウィジェットを配置できます
                  child: Center(
                    child: Text(
                      "ここに結果を表示する",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          );
        } else {}
      },
    );
  }
}
