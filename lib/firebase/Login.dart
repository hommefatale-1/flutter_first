import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:first/firebase/Session.dart';
import 'main.dart';

void main() {
  runApp(Login());
}

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => Session(),
      child: MaterialApp(
        title: '세션 예제',
        home: HomeScreen(),
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _userIdController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _login() async {
    FirebaseFirestore fs = FirebaseFirestore.instance;
    CollectionReference USERLIST = fs.collection("USERLIST");

    String userId = _userIdController.text;
    String password = _passwordController.text;

    // 사용자의 ID와 비밀번호가 일치하는지 확인합니다.
    final checkUser = await fs
        .collection('USERLIST')
        .where('id', isEqualTo: userId)
        .where('pwd', isEqualTo: password)
        .get();

    if (checkUser.docs.isNotEmpty) {
      // 세션 객체 생성
      final session = Provider.of<Session>(context, listen: false);
      final userData = checkUser.docs.first.data();
      // 사용자 데이터가 유효한지 확인하고 세션에 전달합니다.
      String name = userData['name'] ?? ''; // 이름 필드가 없는 경우 기본값으로 빈 문자열 사용
      String email = userData['email'] ?? ''; // 이메일 필드가 없는 경우 기본값으로 빈 문자열 사용
      String phone = userData['phone'].toString() ?? ''; // 휴대폰 필드가 없는 경우 기본값으로 빈 문자열 사용

      session.login(userId, name, email, phone);
      // 로그인 후 메인 페이지로 이동
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MyApp()),
      );
    } else {
      // 사용자가 존재하지 않거나 비밀번호가 일치하지 않는 경우 오류 메시지를 표시합니다.
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('아이디 또는 비밀번호가 잘못되었습니다.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final session = Provider.of<Session>(context); // 세션 객체 가져오기

    return Scaffold(
      appBar: AppBar(
        title: Text('세션 예제'),
      ),
      body: Center(
        child: session.isLoggedIn // 세션 상태에 따라 UI 표시
            ? Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Logged in as: ${session.user!.username}'),
            ElevatedButton(
              onPressed: () {
                session.logout();
              },
              child: Text('로그아웃'),
            ),
          ],
        )
            : Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              TextField(
                controller: _userIdController,
                decoration: InputDecoration(labelText: '아이디'),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(labelText: '비밀번호'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  _login();
                },
                child: Text('로그인'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
