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

class MyWidget extends StatefulWidget {
  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  int? selectValue = 1;

  Widget _displayImage() {
    if(selectValue == 1){
      return Image.asset('assets/iu.jpg');
    } else if(selectValue == 2){
      return Image.asset('assets/iu2.jpg');
    } else if(selectValue == 3){
      return Image.asset('assets/img1.jpg');
    } else {
      return SizedBox();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          ListTile(
            title: Text("버튼 11"),
            leading: Radio(
                value: 1,
                groupValue: selectValue,
                onChanged: (value) {
                  setState(() {
                    selectValue = value;
                  });
                }
            ),
            onTap: (){
              setState(() {
                selectValue = 1;
              });
            },
          ),
          ListTile(
            title: Text("버튼 22"),
            leading: Radio(
                value: 2,
                groupValue: selectValue,
                onChanged: (value) {
                  setState(() {
                    selectValue = value;
                  });
                }
            ),
            onTap: (){
              setState(() {
                selectValue = 2;
              });
            },
          ),
          ListTile(
            title: Text("버튼 33"),
            leading: Radio(
                value: 3,
                groupValue: selectValue,
                onChanged: (value) {
                  setState(() {
                    selectValue = value;
                  });
                }
            ),
            onTap: (){
              setState(() {
                selectValue = 3;
              });
            },
          ),
          Expanded(
              child: Center(
                  child: _displayImage()
              )
          )
        ],
      ),
    );
  }
}