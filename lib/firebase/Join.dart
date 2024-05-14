import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Join extends StatelessWidget {
  const Join({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: JoinForm(),
    );
  }
}

class JoinForm extends StatefulWidget {
  @override
  _JoinFormState createState() => _JoinFormState();
}

class _JoinFormState extends State<JoinForm> {
  final TextEditingController _userId = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _repassword = TextEditingController();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _phone = TextEditingController();

  void _addJoin() async {
    FirebaseFirestore fs = FirebaseFirestore.instance;
    CollectionReference userlist = fs.collection("userlist");

    if (_password.text != _repassword.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('패스워드가 일치하지 않습니다.')),
      );
      return;
    }

    var checkId = await fs.collection('userlist')
        .where('id', isEqualTo: _userId.text)
        .get();

    if (checkId.docs.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('이미 존재하는 아이디입니다.')),
      );
      return;
    }

    try {
      await userlist.add({
        'id': _userId.text,
        'pwd': _password.text,
        'repwd': _repassword.text,
        'name' : _name.text,
        'email': _email.text,
        'phone': int.tryParse(_phone.text) ?? 0,
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('가입되었습니다.')),
      );
      _userId.clear();
      _password.clear();
      _repassword.clear();
      _email.clear();
      _phone.clear();

      // 일정 시간 후에 이전 화면으로 돌아가기
      Future.delayed(Duration(seconds: 1), () {
        Navigator.pop(context);
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('회원가입'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _userId,
              decoration: InputDecoration(labelText: "아이디"),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _password,
              obscureText: true,
              decoration: InputDecoration(labelText: "비밀번호"),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _repassword,
              obscureText: true,
              decoration: InputDecoration(labelText: "비밀번호 확인"),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _name,
              decoration: InputDecoration(labelText: "이름"),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _email,
              decoration: InputDecoration(labelText: "이메일"),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: _phone,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
              ],
              decoration: InputDecoration(
                labelText: '휴대폰 번호',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _addJoin();
              },
              child: Text('가입하기'),
            )
          ],
        ),
      ),
    );
  }
}
