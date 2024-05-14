import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Session.dart'; // 세션 관리 클래스
import '../firebase/main.dart'; // 메인 파일

void main() {
  runApp(Login());
}

// 로그인 위젯
class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      // Provider 제공
      create: (context) => Session(), // 세션 객체 생성
      child: MaterialApp(
        title: '세션 예제',
        home: HomeScreen(), // 홈 화면으로 설정
      ),
    );
  }
}

// 홈 화면 위젯
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final session = Provider.of<Session>(context); // 세션 객체 가져오기

    return Scaffold(
      appBar: AppBar(
        title: Text('세션 예제'),
      ),
      body: Center(
        child: session.isLoggedIn // 로그인 상태에 따라 다른 화면 표시
            ? Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 사용자 정보 표시
            Text(
                "로그인 성공! 아이디는 ${session.user!.id} 비밀번호는 ${session.user!.password} 입니다"),
            ElevatedButton(
              onPressed: () {
                session.logout(); // 로그아웃
              },
              child: Text('로그아웃'),
            ),
          ],
        )
            : ElevatedButton(
          onPressed: () {
            // 로그인
            bool loginSuccess = session.login('test', '1234'); // 로그인 시도
            if (!loginSuccess) {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('로그인 실패'),
                    content: Text('아이디 또는 비밀번호가 맞지 않습니다.'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('확인'),
                      )
                    ],
                  );
                },
              );
            }
          },
          child: Text('로그인'),
        ),
      ),
    );
  }
}
