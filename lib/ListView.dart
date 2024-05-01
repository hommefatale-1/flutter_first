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
        title: Text("리스트 뷰 테스트"),
      ),
      body: ListView.builder(
          itemCount: 100,
          itemBuilder: (context, index) {
            return ListTile(
                leading: Icon(Icons.access_alarm),
                title: Text("${index + 1}번째 사용자"),
              subtitle: Text("${index + 1}번째 사용자 정보"),
            );
          }),
      bottomNavigationBar: BottomAppBar(),
    ));
  }
}
