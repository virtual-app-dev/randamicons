import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DeveloperScreen extends StatelessWidget {
  const DeveloperScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('デベロッパー'),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.grey[200],
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: const Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    DeveloperInfo(
                      name: 'Kanbe Yuta',
                      githubUsername: 'yuta0403',
                    ),
                    Divider(color: Colors.grey, thickness: 0.5),
                    DeveloperInfo(
                      name: 'Oshino Mamiko',
                      githubUsername: 'moshi10',
                    ),
                    Divider(color: Colors.grey, thickness: 0.5),
                    DeveloperInfo(
                      name: 'Minami Satoshi',
                      githubUsername: 'Tomoshi3104',
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class DeveloperInfo extends StatelessWidget {
  final String name;
  final String githubUsername;

  const DeveloperInfo(
      {super.key, required this.name, required this.githubUsername});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        await _launchURL('https://github.com/$githubUsername');
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //Text(name),
            Text(githubUsername),
            Container(
                alignment: Alignment.center,
                child: const Row(
                  children: [
                    Text("GitHubページへ"),
                    SizedBox(width: 10),
                    Icon(Icons.arrow_forward_ios, color: Colors.grey),
                  ],
                )),
          ],
        ),
      ),
    );
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
