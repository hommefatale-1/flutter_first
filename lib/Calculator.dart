import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyWidget(),
    );
  }
}

class MyWidget extends StatelessWidget {

  const MyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("계산기"),
        backgroundColor: Colors.blue[100 * 2],
      ),
      body: Column(
        children: [
          Flexible(
            flex: 2,
            child: Container(
              alignment: Alignment.bottomRight,
              padding: const EdgeInsets.all(20.0),
              child: Text(
                "0",
                style: TextStyle(fontSize: 48),
              ),
            ),
          ),
          Flexible(
            flex: 8,
            child: GridView.builder(
              itemCount: 20,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 3,
                mainAxisSpacing: 5,
              ),
              itemBuilder: (context, index) {
               const List<String> labels = [
                  'C','(','%','/',
                  '7','8','9','*',
                  '4','5','6','-',
                  '1','2','3','+',
                  '0','00','.','=',
                ];
                final color = (labels[index] == '+' ||
                        labels[index] == '-' ||
                        labels[index] == '*' ||
                        labels[index] == '/' ||
                        labels[index] == '=')
                    ? Colors.blue
                    : Colors.grey;

                return GestureDetector(

                  onTap: () {
                    // 터치 이벤트 처리
                  },
                  child: Container(
                    color: color,
                    child: Center(
                      child: Text(
                        labels[index],
                        style: TextStyle(fontSize: 24,color: Colors.red),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}