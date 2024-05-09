import 'package:flutter/material.dart';
import 'NewPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyWidget(),
    );
  }
}

//
class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  TextEditingController _titleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ㅎㅎㅎ"),
      ),
      body: Container(
          child: TextField(
        controller: _titleController,
        decoration: InputDecoration(
          labelText: "입력 하시오 : ",
        ),
      )),
      bottomNavigationBar: BottomAppBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          String title = _titleController.text;
          print(title);
          //페이지이동(위젯)
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => Newpage(title: title)));
        },
        child: Icon(Icons.add),
        tooltip: "페이지 이동",
      ),
    );
  }
}
