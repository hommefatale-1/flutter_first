import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: MyWidget());
  }
}

class MyWidget extends StatefulWidget {
  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
 int? selectValue = 1;

 Widget _displayImage(){
  if(selectValue == 1){
    return Image.asset('kirby.jpg');
  }else if(selectValue == 2){
    return Image.asset('kirby.jpg');
  }else{
    return Image.asset('kriby.jpg');
  }

 }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('data'),
      ),
      body: Column(
        children: [
          ListTile(
            onTap: () {
              setState(() {
                selectValue = 1;
              });
            },
            title: Text("버튼 1"),
            leading: Radio(
                value: 1,
                groupValue: selectValue,
                onChanged: (value) {
                  setState(() {
                    selectValue = value;
                  });
                },
            ),

          ),
          ListTile(
            title: Text("버튼 2"),
            leading: Radio(
              value: 2,
              groupValue: selectValue,
              onChanged: (value) {
                setState(() {
                  selectValue = value;
                });
              },
            ),
            onTap: () {
              setState(() {
                selectValue = 0;
              });
            },
          ),
          Expanded(
              child: Center(
                child: _displayImage(),
              )
          )
        ],
      ),
    );
  }
}
