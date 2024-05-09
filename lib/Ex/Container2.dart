import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home : MyWidget()
    );
  }
}

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body:Center(
          child: Container(
            width: 500,height: 500,color: Colors.purple,
            child: Row(
              children: [
                Flexible(
                    flex: 1,
                    child: Container(
                      child: Column(
                        children: [
                          Flexible(
                            flex: 1,
                              child: Container(
                            width: 250,height: 100,color: Colors.blue,
                          )),
                          Flexible(
                            flex: 1,
                              child: Container(
                            width: 250,height: 100,color: Colors.blue,
                          )),
                          Flexible(
                              flex: 1,
                              child: Container(
                            width: 250,height: 100,color: Colors.blue,
                          )),
                          Flexible(
                              flex: 1,
                              child: Container(
                            width: 250,height: 100,color: Colors.blue,
                          ))
                        ],
                      ),
                    )
                ),
                Flexible(
                    flex: 1,
                    child:Container(
                      width: 250,height: 450,color: CupertinoColors.secondarySystemGroupedBackground,
                    )
                )
              ],
            ),
          ),
        )
    );
  }
}
