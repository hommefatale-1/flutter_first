import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(Icons.menu),
              Center(child: Text("커비의 모험")),
              Icon(
                Icons.account_tree_rounded,
                size: 50,
              )
            ],
          ),
          backgroundColor: Colors.purpleAccent,
        ),
        body: MyWidget(),
        bottomNavigationBar: BottomAppBar(),
      ),
    );
  }
}

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: QrImageView(
            data: "https://www.youtube.com",
            version: QrVersions.auto,
            size: 300,
        ),
      );
  }
}
