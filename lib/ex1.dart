import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Container(
            width: 800,
            height: 400,
            color: Colors.blueGrey,
            margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
            child: Row(
              children: [
                //비율을 지정해줄 수 있는 위젯
                Flexible(
                  child: Container(
                    width: 400,
                    height: 400,
                    color: Colors.purple,
                  ),
                  flex: 2,
                ),
                Flexible(
                  child: Container(
                    width: 300,
                    height: 400,
                    color: Colors.blue,
                  ),
                  flex: 2,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
