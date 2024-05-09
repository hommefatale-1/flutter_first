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
              Icon(Icons.menu),
              Center(child: Text("커비의 모험")),
              Image.asset('kirby.jpg',width: 100,height: 80,)
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

class MyWidget extends StatefulWidget {
  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  double x = 0;

  double y = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
            left: x,
            top: y,
            child: Draggable(
                child: Container(
                  width: 100,
                  height: 100,
                  color: Colors.amber,
                ),
                feedback: Container(
                  width: 100,
                  height: 100,
                  color: Colors.amber.withOpacity(0.5),
                ),
              onDraggableCanceled: (velocity, offset) {
                setState(() {
                  x = offset.dx;
                  y = offset.dy - AppBar().preferredSize.height;
                });
              },
            ),
        )
      ],
    );
  }
}
