import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class UserAddScreen extends StatefulWidget {
  Database db;
  var userId;

  UserAddScreen({required this.db, this.userId});

  @override
  State<UserAddScreen> createState() => _UserAddScreenState();
}

class _UserAddScreenState extends State<UserAddScreen> {
  var user;
  var _name = TextEditingController();
  var _age = TextEditingController();

  Future<void> selectUser() async {
    user = await widget.db.query(
      'TBL_USER',
      where: 'ID = ?',
      whereArgs: [widget.userId],
    );
    print(user.first);
    _name.text = user.first['NAME'];
    _age.text = user.first['AGE'].toString();
  }

  Future<void> updateUser() async{
    user = await widget.db.update(
        'TBL_USER',
        {
          'AGE':int.tryParse(_age.text) ?? 0,
          'NAME':_name.text,
        },
        where: 'ID = ?',
        whereArgs:[widget.userId],
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Container(
          child: Column(
            children: [
              TextField(
                controller: _name,
                decoration: InputDecoration(labelText: 'Name'),
              ),
              TextField(
                keyboardType: TextInputType.number,
                controller: _age,
                decoration: InputDecoration(labelText: 'age'),
              ),
              TextButton(onPressed: () {
                updateUser();
              }, child: Text('수정'))
            ],
          ),
        ));
  }
}
