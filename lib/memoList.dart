import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:first/memo.dart';

// 테이블 생성
Future<Database> InsertDB() async {
  String path = await getDatabasesPath();
  String dbPath = join(path, 'secondDB.db');

  return await openDatabase(
    dbPath,
    version: 1,
    onCreate: (Database db, int version) async {
      await db.execute('''
        CREATE TABLE IF NOT EXISTS TBL_MEMO(
          ID INTEGER PRIMARY KEY AUTOINCREMENT,
          NAME TEXT,
          CONTENTS TEXT
        )
      ''');
    },
  );
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var db = await InsertDB();
  runApp(MyApp(db: db));
}

class MyApp extends StatelessWidget {
  final Database db;

  MyApp({required this.db});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MemoList(db: db),
    );
  }
}

class MemoList extends StatefulWidget {
  final Database db;

  MemoList({required this.db});

  @override
  _MemoListState createState() => _MemoListState();
}

class _MemoListState extends State<MemoList> {
  List<Map<String, dynamic>> list = [];

  Future<void> selectMomo() async {
    var memo = await widget.db.query('TBL_MEMO');
    setState(() {
      list = memo;
    });
  }

  @override
  void initState() {
    super.initState();
    selectMomo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('메모장 목록'),
      ),
      body: ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, index) {
          var memo = list[index];
          return ListTile(
            title: Text('작성자: ${memo['NAME']}'),
            subtitle: Text('내용: ${memo['CONTENTS']}'),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => editMemo(db: widget.db),
            ),
          ).then((_) => selectMomo()); // 메모 작성 후 목록 다시 로드
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
