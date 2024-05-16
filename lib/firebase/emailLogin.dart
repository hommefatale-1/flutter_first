import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';

void main() {
  runApp(EmailLogin());
}

class EmailLogin extends StatefulWidget {
  const EmailLogin({Key? key}) : super(key: key);

  @override
  _EmailLoginState createState() => _EmailLoginState();
}

class _EmailLoginState extends State<EmailLogin> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '이메일 회원가입', // 앱 제목 설정
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: RegisterPage(), // 첫 화면으로 RegisterPage 위젯을 보여줌
    );
  }
}

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _emailController = TextEditingController(); // 이메일 입력을 위한 컨트롤러
  final TextEditingController _verificationCodeController = TextEditingController(); // 인증 코드 입력을 위한 컨트롤러
  String _verificationCode = ''; // 생성된 인증 코드를 저장하는 변수
  bool _isVerificationCodeSent = false; // 인증 코드가 전송되었는지 여부를 나타내는 변수
  Timer? _timer; // 시간을 계산하기 위한 타이머
  int _remainingTime = 10; // 초기 남은 시간을 나타내는 변수 (테스트를 위해 10으로 설정)

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _timer?.cancel(); // 위젯이 dispose 될 때 타이머 종료
    super.dispose();
  }

  void _startTimer() {
    // 1초마다 타이머 실행하여 남은 시간 감소
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_remainingTime > 0) {
          _remainingTime--;
        } else {
          _timer?.cancel(); // 타이머 종료
        }
      });
    });
  }

  void _resendVerificationCode() {
    final random = Random();
    _verificationCode = '';
    for (int i = 0; i < 6; i++) {
      _verificationCode += random.nextInt(10).toString();
    }

    final email = _emailController.text.trim(); // 이메일 변수 정의

    final smtpServer =
    gmail('hommefatale01@gmail.com', 'amgv ycxv xkww tbso'); // Gmail SMTP 서버 설정
    final message = Message()
      ..from = Address('hommefatale01@gmail.com', 'The bed is my stage.') // 발신자 이메일 및 이름 설정
      ..recipients.add(email) // 수신자 이메일 추가
      ..subject = '회원가입 확인 이메일' // 이메일 제목 설정
      ..text = '인증 코드: $_verificationCode'; // 이메일 내용 설정 (인증 코드 포함)

    send(message, smtpServer); // 이메일 전송

    setState(() {
      _isVerificationCodeSent = true; // 인증 코드 전송 상태를 true로 변경
      _remainingTime = 180; // 남은 시간을 3분으로 설정
    });

    _startTimer(); // 타이머 시작
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('회원가입'), // 화면 상단에 '회원가입' 제목 표시
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: '이메일'), // 이메일 입력 필드
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                String email = _emailController.text.trim();
                _sendVerificationCode(email); // 인증 코드 전송 버튼 클릭 시 인증 코드 전송
              },
              child: Text('인증 코드 전송'), // '인증 코드 전송' 버튼 텍스트
            ),
            SizedBox(height: 16.0),
            if (_isVerificationCodeSent) ...[
              TextField(
                controller: _verificationCodeController,
                decoration: InputDecoration(labelText: '인증 코드'), // 인증 코드 입력 필드
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  String verificationCode =
                  _verificationCodeController.text.trim();
                  _verifyVerificationCode(verificationCode); // 인증 코드 확인 버튼 클릭 시 인증 코드 확인
                },
                child: Text('인증 코드 확인'), // '인증 코드 확인' 버튼 텍스트
              ),
              SizedBox(height: 8.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('남은 시간: ${_remainingTime ~/ 60}분 ${_remainingTime % 60}초'), // 남은 시간 텍스트 표시
                  SizedBox(width: 16.0),
                  if (_remainingTime == 0) // 남은 시간이 0일 때에만 코드 재전송 버튼을 보여줌
                    ElevatedButton(
                      onPressed: () {
                        _resendVerificationCode(); // 코드 재전송 버튼 클릭 시 코드 재전송
                      },
                      child: Text('코드 재전송'), // '코드 재전송' 버튼 텍스트
                    ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  void _sendVerificationCode(String email) {
    final random = Random();
    _verificationCode = '';
    for (int i = 0; i < 6; i++) {
      _verificationCode += random.nextInt(10).toString();
    }

    final smtpServer =
    gmail('hommefatale01@gmail.com', 'amgv ycxv xkww tbso'); // Gmail SMTP 서버 설정
    final message = Message()
      ..from = Address('hommefatale01@gmail.com', 'The bed is my stage.') // 발신자 이메일 및 이름 설정
      ..recipients.add(email) // 수신자 이메일 추가
      ..subject = '회원가입 확인 이메일' // 이메일 제목 설정
      ..text = '인증 코드: $_verificationCode'; // 이메일 내용 설정 (인증 코드 포함)

    send(message, smtpServer); // 이메일 전송

    setState(() {
      _isVerificationCodeSent = true; // 인증 코드 전송 상태를 true로 변경
      _remainingTime = 180; // 남은 시간을 3분으로 설정
    });

    _startTimer(); // 타이머 시작
  }

  void _verifyVerificationCode(String verificationCode) {
    if (verificationCode == _verificationCode) {
      _registerUser(); // 인증 코드가 일치할 경우 사용자 등록
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('오류'),
            content: Text('인증 코드가 올바르지 않습니다.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('확인'),
              ),
            ],
          );
        },
      );
    }
  }

  void _registerUser() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('회원가입 완료'),
          content: Text('회원가입이 완료되었습니다.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('확인'),
            ),
          ],
        );
      },
    );
  }
}
