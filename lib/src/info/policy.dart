import 'package:flutter/material.dart';

class PolicyScreen extends StatelessWidget {
  const PolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('プライバシーポリシー'),
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Text(
          'このアプリケーション（以下、「本アプリ」といいます。）のプライバシーポリシーは、以下の通りです。\n\n'
          '【個人情報の収集について】\n'
          '本アプリは、ユーザーの個人情報（氏名、メールアドレス、電話番号など）を収集することはありません。\n\n'
          '【個人情報の利用目的について】\n'
          '本アプリが収集する情報は、アプリの機能改善やユーザーサポートのためにのみ使用されます。\n\n'
          '【個人情報の第三者提供について】\n'
          '本アプリは、ユーザーの同意を得ずに個人情報を第三者に提供することはありません。\n\n'
          '【個人情報の管理について】\n'
          '本アプリは、収集した個人情報の紛失、破壊、改ざん及び漏洩などを防ぐため、適切な管理を行います。\n\n'
          '【プライバシーポリシーの変更について】\n'
          '本アプリは、必要に応じてプライバシーポリシーを変更することがあります。変更後のプライバシーポリシーは、本アプリ内での告知、または本アプリのウェブサイト上での公開をもって、効力を生じるものとします。\n\n'
          '【お問い合わせ】\n'
          '本プライバシーポリシーに関するお問い合わせは、xxx（お問い合わせ先）までお願いします。\n\n',
          style: TextStyle(fontSize: 13.0),
        ),
      ),
    );
  }
}
