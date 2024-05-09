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
  List<Map> list = [{
    "imgPath":"kirby.jpg",
    "title":"title1",
    "contents":"contents1",
    "price":"100",
    "favorite":true
  },{
    "imgPath":"kirby.jpg",
    "title":"title2",
    "contents":"contents2",
    "price":"200",
    "favorite":false
  }];

  Widget listItem(index){
    return ListTile(
      leading: Image.asset("${list[index]["imgPath"]}"),
      title: Text("${list[index]["title"]}"), // 각 항목에 대해 고유한 제목을 생성
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("설명 :  ${list[index]["contents"]}"),
          Text("가격 : ${list[index]["price"]}")
        ],
      ),
      trailing: IconButton(
        icon: Icon(
          list[index]["favorite"]?Icons.favorite:Icons.favorite_border
        ,color: Colors.red,
        ),
        onPressed: () {
          setState(() {// 상태를 토글하여 변경
          if(list[index]["favorite"]){
            list[index]["favorite"] = false;
          }else{
            list[index]["favorite"] = true;
          }
          });
        },
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("리스트 뷰 테스트"),
      ),
      body: ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, index) {
          return listItem(index); // 각 항목에 대한 위젯을 생성하여 반환
        },
      ),
      bottomNavigationBar: BottomAppBar(),
    );
  }
}
