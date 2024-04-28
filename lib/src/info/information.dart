import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:random_icons/src/info/agreement.dart';
import 'package:random_icons/src/info/developer.dart';
import 'package:random_icons/src/info/policy.dart';
import 'package:url_launcher/url_launcher.dart';

class InformationScreen extends StatelessWidget {
  const InformationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final versionInfo = _getVersionInfo();
    return Scaffold(
      appBar: AppBar(
        centerTitle: false, // 中央寄せを解除
        title: const Text(
          'アプリについて',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
      ),
      body: Container(
        color: Colors.grey[200],
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          const Row(
                            children: <Widget>[
                              SizedBox(width: 15),
                              Text("現在のバージョン"),
                            ],
                          ),
                          const SizedBox(width: 15),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                FutureBuilder(
                                  future: versionInfo,
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState == ConnectionState.waiting) {
                                      // データを取得中の場合はローディングインジケータを表示
                                      return const CircularProgressIndicator();
                                    } else if (snapshot.hasData) {
                                      // データが取得できた場合はバージョン情報を表示
                                      log("${snapshot.data!}");
                                      return Text(snapshot.data, style: const TextStyle(color: Colors.grey));
                                    } else {
                                      // 何らかの理由でデータが取得できなかった場合は代替のウィジェットを表示
                                      return const Text('Unknown version');
                                    }
                                  },
                                ),
                                const SizedBox(width: 15),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Divider(color: Colors.grey, thickness: 0.7),
                    InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const AgreementScreen()));
                      },
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                SizedBox(width: 15),
                                Text("利用規約"),
                              ],
                            ),
                            SizedBox(width: 15),
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Icon(Icons.arrow_forward_ios, color: Colors.grey),
                                  SizedBox(width: 15),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const PolicyScreen()));
                      },
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                SizedBox(width: 15),
                                Text("プライバシーポリシー"),
                              ],
                            ),
                            SizedBox(width: 15),
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Icon(Icons.arrow_forward_ios, color: Colors.grey),
                                  SizedBox(width: 15),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    FutureBuilder(
                      future: versionInfo, // 非同期でバージョン情報を取得するFuture
                      builder: (context, snapshot) {
                        // インクウェルウィジェットのonTapに処理を定義
                        return InkWell(
                          onTap: () {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              // ローディング中の場合はダイアログを表示
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('読み込み中... 時間をあけて再度お試しください'),
                                ),
                              );
                            } else
                            // 非同期処理が終了したら、ダイアログが表示されていれば閉じる
                            if (snapshot.hasError) {
                              // エラーがある場合はSnackBarを表示
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('エラーが発生しました: ${snapshot.error}'),
                                ),
                              );
                            } else if (snapshot.hasData) {
                              // データが取得できた場合はバージョン情報をもとにライセンスページを表示
                              final version = snapshot.data;
                              showLicensePage(
                                context: context,
                                applicationName: "Randomicons",
                                applicationVersion: "Version: $version",
                              );
                            } else {
                              // データがない場合はSnackBarやアラートを表示するなどの処理
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('バージョン情報を取得できませんでした。'),
                                ),
                              );
                            }
                          },
                          child: const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    SizedBox(width: 15),
                                    Text("著作権情報"),
                                  ],
                                ),
                                SizedBox(width: 15),
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Icon(Icons.arrow_forward_ios, color: Colors.grey),
                                      SizedBox(width: 15),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const DeveloperScreen()));
                      },
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                SizedBox(width: 15),
                                Text("デベロッパー"),
                              ],
                            ),
                            SizedBox(width: 15),
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Icon(Icons.arrow_forward_ios, color: Colors.grey),
                                  SizedBox(width: 15),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () async {
                        await _launchURL('https://vlog.virtual-glossary.com/contact/');
                      },
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                SizedBox(width: 15),
                                Text("お問い合わせ"),
                              ],
                            ),
                            SizedBox(width: 15),
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Icon(Icons.arrow_forward_ios, color: Colors.grey),
                                  SizedBox(width: 15),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// エラーが出る場合はビルドを試してみる
  /// android: flutter build apk
  /// ios: flutter build ios
  /// web: flutter build web
  Future _getVersionInfo() async {
    //await Future.delayed(const Duration(seconds: 3));
    final PackageInfo packageInfo = await PackageInfo.fromPlatform();
    log("$packageInfo");
    return "${packageInfo.version}+${packageInfo.buildNumber}";
  }

  Future<void> _launchURL(String url) async {
    try {
      Uri uri = Uri.parse(url);
      launchUrl(uri);
    } catch (e) {
      log(e.toString());
    }
  }
}
