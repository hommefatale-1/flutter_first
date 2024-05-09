import 'package:flutter/material.dart';

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
  List<Color> colors = [
    Colors.blue,
    Colors.green,
    Colors.red,
    Colors.yellow,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Container(
          width: 500, height: 500,color: Colors.grey,
          child: Row(
            children: [
              Expanded(
                  flex: 1,
                  child: Column(
                    children:List.generate(
                        4, (index) => Expanded(
                        child: Container(
                          width: 100,
                          height: 200,
                          color: colors[index % colors.length],
                        ),
                      ),
                    ),
                  ),
              ),
              Expanded(
                  flex: 2,
                  child: Container(
                    width: 100,height: 200,
                    color: Colors.purpleAccent,
                  )
              )
            ],

          ),
        ),
      ),
    );
  }
}