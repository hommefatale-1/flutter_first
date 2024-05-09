import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
  
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:Center
        (child: Container(
        width: 100,height: 100,color: Colors.pink,
        )
      ),
      //home: Image.asset('kirby.jpg')
    );
  }
}

