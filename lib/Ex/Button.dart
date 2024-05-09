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
        body: BtnEvent(),
        bottomNavigationBar: BottomAppBar(),
      ),
    );
  }
}

//사용자 정의 위젯
class BtnEvent extends StatefulWidget {
  const BtnEvent({super.key});

  @override
  State<BtnEvent> createState() => _BtnEventState();
}

class _BtnEventState extends State<BtnEvent> {
  String txt = "Hello";

  void updateTxt() {
    setState(() {
      txt = "안녕";
    });
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(txt),
        ElevatedButton(onPressed: updateTxt, child: Text('클릭'))
      ],
    );
  }
}

//나만의 위젯
// class MyWidget extends StatelessWidget {
//   const MyWidget({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.fromLTRB(20, 20, 0, 0),
//       width: 100,
//       height: 100,
//       color: Colors.yellow,
//     );
//   }
// }
