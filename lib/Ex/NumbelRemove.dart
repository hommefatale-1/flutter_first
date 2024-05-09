import 'package:first/Ex//NewPage.dart';
import 'package:flutter/material.dart';
import 'dart:math';

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

class MyWidget extends StatefulWidget {
  @override
  State<MyWidget> createState() => _RanState();
}


class _RanState extends State<MyWidget> {
  Random random = Random();
  List<Widget> list = [];
  int idx = 0;

  void remove(int index){
    if(index == idx){
      idx++;
      setState(() {
        list.removeAt(0);
      });
    }
    if(list.length == 0) idx = 0;
  }
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    if(list.length == 0) {
      for (int index = 0; index < 10; index++) {
        list.add(
          Positioned(
            left: random.nextDouble() * (width - 150),
            top: random.nextDouble() * (height - 300) + 100,
            child: GestureDetector(
              onTap: () {
                if(index == 9){
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(builder: (context) => Newpage())
                  // );
                }
                remove(index);
              },
              child: Container(
                width: 50,
                height: 50,
                color: Colors.blue,
                child: Center(
                  child: Text(
                    (index + 1).toString(),
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
        );
      }
    }
    return Scaffold(
      body: Stack(
        children: list,
      ),
    );
  }
}