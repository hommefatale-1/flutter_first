import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';

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
              Icon(Icons.search),
              Center(child: Text("커비의 모험")),
              Icon(
                Icons.account_tree_rounded,
                size: 50,
              )
            ],
          ),
          backgroundColor: Colors.purpleAccent,
        ),
        body: Align(
          child:Container(
            width: 400, height: 400,color: CupertinoColors.systemGreen,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                width: 100, height: 100, color: Colors.orange,
              ),
            ),
          )
        ),
    bottomNavigationBar: SizedBox(
          height: 50,
          child: BottomAppBar(
            color: Colors.yellowAccent,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Icon(
                  Icons.star_border,
                  color: Colors.orange,
                ),
                Icon(
                  Icons.search,
                  color: CupertinoColors.systemGreen,
                ),
                Icon(
                  Icons.add_call,
                  color: Colors.purple,
                ),
                Icon(
                  Icons.send_to_mobile,
                  color: Colors.amberAccent,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
