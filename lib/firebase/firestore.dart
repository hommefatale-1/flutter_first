import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class FireEx1 extends StatefulWidget {
  const FireEx1({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<FireEx1> {
  String? selectedValue;

  final TextEditingController _name = TextEditingController();
  final TextEditingController _age = TextEditingController();

  void _addUser() async {
    if (_name.text.isNotEmpty && _age.text.isNotEmpty) {
      FirebaseFirestore fs = FirebaseFirestore.instance;
      CollectionReference users = fs.collection("users");

      await users.add({
        'name': _name.text,
        'age': int.parse(_age.text),
      });

      _name.clear();
      _age.clear();
    } else {
      print("이름 또는 나이 입력");
    }
  }

  void _updateUser() async{
    FirebaseFirestore fs = FirebaseFirestore.instance;
    CollectionReference users = fs.collection("users");

    QuerySnapshot snap = await users.where('name', isEqualTo: '홍길동').get();
    for(QueryDocumentSnapshot doc in snap.docs){
      users.doc(doc.id).update({'age' : 30});
    }
  }
  void _deleteUser(String userId) async{
    FirebaseFirestore fs = FirebaseFirestore.instance;
    CollectionReference users = fs.collection("users");

    await users.doc(userId).delete();
  }

  Widget _listUser(){
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection("users").snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snap){
          if (snap.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator()); // 데이터 로딩 시
          }
          if (snap.hasError) {
            return Center(child: Text('오류!: ${snap.error}')); // 오류 발생
          }

          var users = snap.data!.docs;
          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              var user = users[index];
              var userName = user['name'];
              var userAge = user['age'];

              return ListTile(
                onTap: () {
                  setState(() {
                    selectedValue = user.id;
                    _name.text = userName;
                    _age.text = userAge.toString();
                  });
                },
                leading: Radio(
                    value: user.id,  // 이 라디오 버튼의 값
                    groupValue: selectedValue, // 그룹에서 현재 선택된 값
                    onChanged: (value) {
                      setState(() {
                        selectedValue = value;
                        _name.text = user['name'];
                        _age.text = user['age'].toString();
                      });

                    },// 라디오 버튼이 변경될 때 호출되는 콜백 함수
                ),
                title: Text('이름 : $userName'),
                subtitle: Text('나이: $userAge' ),
              );
            },
          );
        },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("firestore")),
        body: Center(
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: _name,
                  decoration: InputDecoration(
                    labelText: "이름",
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: _age,
                  decoration: InputDecoration(
                    labelText: "나이",
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _addUser,
                  child: Text("사용자 추가!"),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _updateUser,
                  child: Text("사용자 수정!"),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                    onPressed: () {
                      if (selectedValue != null) {
                        _deleteUser(selectedValue!);
                      } else {
                        print('삭제할 사용자를 선택해주세요.');
                      }
                    },
                    child: Text("사용자 삭제!")),
                Expanded(child: _listUser()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}