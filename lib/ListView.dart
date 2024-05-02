import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: MyWidget());
  }
}

class MyWidget extends StatefulWidget {
  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  bool isbool = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("리스트 뷰 테스트"),
      ),
      body: ListView.builder(
        itemCount: 100,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Image.asset('kirby.jpg'),
            title: Text("${index + 1}번째 사용자"),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("설명 :  사용한지 10년밖에 안된 노트북 팔아요~"),
                Text("가격 : 제쉬요~")
              ],
            ),
            trailing: IconButton(
              icon: Icon(
                isbool ? Icons.favorite : Icons.favorite_border,
                color: isbool ? Colors.red : Colors.black,
              ),
              onPressed: () {
                setState(() {
                  isbool = !isbool;
                });
              },
            ),
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(),
    );
  }
}
