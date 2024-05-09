import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';


class editMemo extends StatefulWidget {
  Database db;

  editMemo({required this.db});

  @override
  State<editMemo> createState() => _MyAppState();
}

class _MyAppState extends State<editMemo> {
  TextEditingController _nameCtrl = TextEditingController();
  TextEditingController _contentCtrl = TextEditingController();

  Future<void> insertMemo() async {
    await widget.db.insert(
      'TBL_MEMO',
      {
        'NAME': _nameCtrl.text,
        'CONTENTS': _contentCtrl.text,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('메모 작성'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _nameCtrl,
              decoration: InputDecoration(
                labelText: '작성자',
              ),
            ),
            TextField(
              controller: _contentCtrl,
              decoration: InputDecoration(
                labelText: '내용',
              ),
              maxLines: null,
            ),
            ElevatedButton(
              onPressed: () async {
                await insertMemo();
                Navigator.of(context).pop();
              },
              child: Text('저장'),
            ),
          ],
        ),
      ),
    );
  }
}