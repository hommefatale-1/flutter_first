import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

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
  String youtubeId = "PzrQwrBoEek";


  @override
  Widget build(BuildContext context) {
    return YoutubePlayer(
        controller: YoutubePlayerController(
            initialVideoId: youtubeId,
            flags: YoutubePlayerFlags(
              autoPlay: true
            )
        )
    );
  }
}
