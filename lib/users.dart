import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:first/UserAddScreen.dart';

class UserList extends StatefulWidget {
  Database db;

  UserList({required this.db});

  @override
  _UserListState createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  List<Map<String, dynamic>> list = [];
  int index = 0;

  Future<void> selectUser() async {
    var user = await widget.db.query('TBL_USER'); // SELECT * FROM TBL_USER
    setState(() {
      list = user;
      print(list);
    });
  }

  Future<void> removeUser(userId) async {
    await widget.db.delete('TBL_USER', where: 'ID = ?', whereArgs: [userId]);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectUser();
  }

  void userAdd() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>  UserAddScreen(db: widget.db, index: index),)
    );
  }

  void deleteUser(BuildContext context, int index) {
    var user = list[index];
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('삭제'),
            content: Text('${user["NAME"]}님을 삭제합니까?'),
            actions: [
              TextButton(
                  onPressed: () {
                    removeUser(user['ID']);
                    Navigator.of(context).pop();
                    selectUser();
                  },
                  child: Text('삭제')),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('취소')),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('사용자목록'),
      ),
      body: ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, index) {
          var user = list[index];
          return ListTile(
              title: Row(
                children: [
                  Text('아이디 : ${user['ID']}, '),
                  Text('이름 : ${user['NAME']}, '),
                ],
              ),
              subtitle: Text('나이 : ${user['AGE']}'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      deleteUser(context, index);
                    },
                  ),
                  IconButton(
                      onPressed: () {
                        userAdd();
                      },
                      icon: Icon(Icons.add))
                ],
              ));
        },
      ),
    );
  }
}
