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
        body: BntUp(),
      ),
    );
  }
}
class BntUp extends StatefulWidget {
  const BntUp({super.key});

  @override
  State<BntUp> createState() => _BntUpState();
}

class _BntUpState extends State<BntUp> {
  int cnt = 0;
  void increaseNum() {
    setState(() {
      cnt++;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Flexible(
            flex: 9,
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('asdasdas'),
                  Text('$cnt')
                ],
              ),
            )),
        Flexible(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(onPressed:increaseNum, child: Icon(Icons.add))
                  ],
                ),
              ),
            ))
      ],
    );
  }
}
