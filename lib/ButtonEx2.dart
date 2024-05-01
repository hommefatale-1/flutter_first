import 'package:flutter/material.dart';

void main() {
  runApp(const one());
}

class one extends StatefulWidget {
  const one({super.key});

  @override
  State<one> createState() => _oneState();
}

class _oneState extends State<one> {
  var align = Alignment.center;
  bool flg = true;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      body: Align(
        alignment: align,
        child: Container(
          width: 200,
          height: 200,
          child: ElevatedButton(
              onPressed: () {
                setState(() {
                  if(flg){
                    align = Alignment.topCenter;
                    flg = false;
                  }else{
                    align = Alignment.center;
                    flg = true;
                  }
                });
              },
              child: Text('클릭')),
        ),
      ),
    ));
  }
}
