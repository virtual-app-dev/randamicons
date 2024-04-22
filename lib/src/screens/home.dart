import 'dart:io';
import 'dart:math' as math;
import 'dart:typed_data';
import 'dart:ui' as ui;

//import 'package:firebase_storage/firebase_storage.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      home: Scaffold(
        appBar: AppBar(
          centerTitle: false, // 中央寄せを解除
          title: const Text(
            'ホーム',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ),
        body: const MyCustomListView(),
      ),
    );
  }
}

class MyCustomListView extends StatefulWidget {
  const MyCustomListView({super.key});

  @override
  MyCustomListViewState createState() => MyCustomListViewState();
}

class MyCustomListViewState extends State<MyCustomListView> {
  bool _isAnimationPlayed = false; // アニメーションの状態を追跡するフラグ
  late Color selectedColor;
  late IconData selectedIcon;
  final GlobalKey iconKey = GlobalKey();

  /// 追加・削除したいアイコンはここで設定
  final List<IconData> iconsList = [
    Icons.account_circle,
    Icons.person,
    Icons.person_outline,
    Icons.face,
    Icons.tag_faces,
    Icons.mood,
    Icons.mood_bad,
    Icons.sentiment_satisfied,
    Icons.sentiment_dissatisfied,
    Icons.sentiment_neutral,
    Icons.sentiment_very_satisfied,
    Icons.sentiment_very_dissatisfied,
    Icons.child_care,
    Icons.child_friendly,
    Icons.pregnant_woman,
    Icons.accessibility_new,
    Icons.accessibility,
    Icons.hearing,
    Icons.visibility,
    Icons.visibility_off,
    Icons.watch,
    Icons.camera_alt,
    Icons.photo_camera,
    Icons.photo,
    Icons.edit,
    Icons.palette,
    Icons.brush,
    Icons.camera_front,
    Icons.camera_rear,
    Icons.account_box,
    Icons.account_balance,
    Icons.account_balance_wallet,
    Icons.account_tree,
    Icons.work,
    Icons.work_outline,
    Icons.beach_access,
    Icons.airline_seat_individual_suite,
    Icons.airline_seat_flat,
    Icons.airline_seat_flat_angled,
    Icons.airline_seat_legroom_extra,
    Icons.airline_seat_legroom_normal,
    Icons.airline_seat_legroom_reduced,
    Icons.airline_seat_recline_extra,
    Icons.airline_seat_recline_normal,
    Icons.wc,
    Icons.smoke_free,
    Icons.smoking_rooms,
    Icons.baby_changing_station,
    Icons.backpack,
    Icons.bathroom,
    Icons.bathtub,
    Icons.bed,
    Icons.blender,
    Icons.shower,
    Icons.soap,
    Icons.sports_bar,
    Icons.tapas,
    Icons.tv,
    Icons.wifi,
    Icons.keyboard_voice,
    Icons.mic,
    Icons.mic_none,
    Icons.mic_off,
    Icons.headset,
    Icons.headset_mic,
    Icons.headset_off,
    Icons.speaker,
    Icons.speaker_group,
    Icons.videogame_asset,
    Icons.watch_later,
    Icons.audiotrack,
    Icons.music_video,
    Icons.queue_music,
    Icons.library_music,
    Icons.album,
    Icons.av_timer,
    Icons.closed_caption,
    Icons.equalizer,
    Icons.explicit,
    Icons.fast_forward,
    Icons.fast_rewind,
    Icons.games,
    Icons.hearing_disabled,
    Icons.high_quality,
    Icons.library_books,
    Icons.library_add,
    Icons.loop,
    Icons.mic_external_on,
    Icons.movie,
    Icons.music_note,
    Icons.music_off,
    Icons.not_interested,
    Icons.pause,
    Icons.pause_circle_filled,
    Icons.pause_circle_outline,
    Icons.play_arrow,
    Icons.play_circle_filled,
    Icons.play_circle_outline,
  ];

  @override
  void initState() {
    super.initState();
    selectedColor = getRandomColor();
    selectedIcon = getRandomIcon();
  }

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
                        'Get icon!', //TODO:文字を検討
                        textStyle:
                            Theme.of(context).textTheme.displaySmall?.copyWith(
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
                    'Get icon!', //TODO:文字を検討
                    style: Theme.of(context).textTheme.displaySmall?.copyWith(
                          fontFamily: 'fonts/asset/Now-Regular.otf',
                        ),
                  ),
                );
        } else if (index == 1) {
          // 2行目以降にGridView.builderを使用
          return GridView.builder(
              shrinkWrap: true, // ListView内で正しく表示するためには必須
              physics:
                  const NeverScrollableScrollPhysics(), // ListViewのスクロールに従うように
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // 1列で表示
                childAspectRatio: 1,
              ),
              itemCount: 2, // 表示するアイテムの数
              itemBuilder: (context, gridIndex) {
                switch (gridIndex) {
                  case 0:
                    // 最初のアイテム
                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        alignment: Alignment.center,
                        child: FractionallySizedBox(
                          widthFactor: 1,
                          heightFactor: 1,
                          child: OutlinedButton(
                            child: Center(
                              child: Row(
                                mainAxisSize:
                                    MainAxisSize.max, // ボタンの中身を最小限のサイズにする
                                children: [
                                  Icon(Icons.touch_app,
                                      color: Colors.black), // アイコンを指定
                                  SizedBox(width: 8), // アイコンとテキストの間隔
                                  Text('アイコン変更'),
                                ],
                              ),
                            ),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: Colors.black,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              side: const BorderSide(),
                            ),
                            onPressed: changeIcon,
                          ),
                        ),
                      ),
                    );
                  case 1:
                    // 2番目のアイテム
                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        alignment: Alignment.center,
                        child: FractionallySizedBox(
                          widthFactor: 1,
                          heightFactor: 1,
                          child: OutlinedButton(
                            child: Center(
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment
                                    .center, // ボタンの中身を最小限のサイズにする
                                children: [
                                  Icon(Icons.palette,
                                      color: Colors.black), // アイコンを指定
                                  SizedBox(width: 8), // アイコンとテキストの間隔
                                  Text('背景色を変更'),
                                ],
                              ),
                            ),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: Colors.black,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              side: const BorderSide(),
                            ),
                            onPressed: changeColor, // ここに背景色を変更する関数を指定
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
                const SizedBox(height: 10), // 元々テキストがあった部分とデザイン要素の間にスペースを追加
                Container(
                  width: double.infinity, // 親ウィジェットの幅に合わせる
                  height: 200, // 高さを200に設定
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12), // 角を丸くする
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5), // 影の色
                        spreadRadius: 5, // 影の広がり
                        blurRadius: 7, // 影のぼかし
                        offset: const Offset(0, 3), // 影の方向
                      ),
                    ],
                    image: DecorationImage(
                      image: AssetImage('images/background.png'), // 背景画像
                      // fit: BoxFit.cover, // 画像がコンテナにぴったり収まるように調整
                    ),
                  ),

                  // ここに追加のウィジェットを配置できます
                  child: Center(
                    child: RepaintBoundary(
                      key: iconKey,
                      child: Container(
                        width: 100,
                        height: 100,
                        color: selectedColor,
                        child:
                            Icon(selectedIcon, color: Colors.white, size: 50),
                        //child: const Icon(Icons.person, color: Colors.white, size: 50),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        } else {}
        return null;
      },
    );
  }

  IconData getRandomIcon() {
    final random = math.Random();
    int index = random.nextInt(iconsList.length);
    return iconsList[index];
  }

  Color getRandomColor() {
    // HSLColorを使用して、色相はランダムに、彩度と明度は一定範囲で指定
    final hue = math.Random().nextDouble() * 360.0;
    const lightness = 0.7; // 明るさを70%に設定 (0.0〜1.0の範囲)
    const saturation = 0.5; // 彩度を50%に設定 (0.0〜1.0の範囲)
    return HSLColor.fromAHSL(1.0, hue, saturation, lightness).toColor();
  }

  void changeColor() {
    setState(() {
      selectedColor = getRandomColor();
    });
  }

  void changeIcon() {
    setState(() {
      selectedIcon = getRandomIcon();
    });
  }
  /* Future<void> uploadIconToStorage() async {
    RenderRepaintBoundary boundary = iconKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
    ui.Image image = await boundary.toImage(pixelRatio: 3.0);
    ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    Uint8List pngBytes = byteData!.buffer.asUint8List();

    String fileName = "default_icons/icon_${DateTime.now().millisecondsSinceEpoch}.png";
    Reference storageRef = FirebaseStorage.instance.ref().child(fileName);

    // SettableMetadataを作成してcontent-typeを設定
    SettableMetadata metadata = SettableMetadata(
      contentType: 'image/png',
      customMetadata: {'picked': 'true'}, // 必要に応じてカスタムメタデータを追加
    );

    try {
      // 画像データとメタデータをアップロード
      await storageRef.putData(pngBytes, metadata);
      String downloadUrl = await storageRef.getDownloadURL();
      print('Download URL: $downloadUrl');
      // ここでFirestoreにアップロードされた画像のURLを保存する処理を追加します。
    } catch (e) {
      print(e); // エラーのハンドリング
    }
  } */

  Future<void> downloadImageToLocal() async {
    try {
      RenderRepaintBoundary boundary =
          iconKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      Uint8List pngBytes = byteData!.buffer.asUint8List();
      // 一時ディレクトリを取得
      final directory = await getTemporaryDirectory();
      final imagePath =
          '${directory.path}/icon_${DateTime.now().millisecondsSinceEpoch}.png';
      final imageFile = File(imagePath);

      // 画像ファイルを保存
      await imageFile.writeAsBytes(pngBytes);

      // オプション：ファイルのパスをコンソールに出力
      print('Image saved to $imagePath');
    } catch (e) {
      print(e); // エラーのハンドリング
    }
  }
}
