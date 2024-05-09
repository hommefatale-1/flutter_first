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
              Image.asset('kirby.jpg',width: 80,height: 80,)
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
 double width = 100;
 double height = 100;
 Color color = Colors.black;
 bool isToggled = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () {
          setState(() {
            if(isToggled){
              width = 100;
              height = 100;
              color = Colors.black;
            }else{
              width = 300;
              height = 500;
              color = Colors.purple;
            }
             isToggled = !isToggled;
          });
        },
        child: AnimatedContainer(
          duration: Duration(
            seconds: 5
          ),
          width: width,
          height: height,
          color: color,
          curve: Curves.decelerate,
        ),
      ),
    );
  }
}
