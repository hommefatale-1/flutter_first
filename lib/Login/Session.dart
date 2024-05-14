import 'package:flutter/material.dart';

class Session with ChangeNotifier {
  User? _user; // 현재 로그인된 사용자
  User? get user => _user; // 사용자 정보 가져오기
  bool get isLoggedIn => _user != null; // 로그인 상태 여부 확인

  bool login(String id, String password) {
    // 여기에 로그인 로직을 구현합니다.
    // 성공시 true를 반환하고, 실패시 false를 반환합니다.

    // 예시 코드: 간단한 로그인 로직
    if (id == 'test' && password == '1234') {
      _user = User(id: id, password: password); // 로그인 성공
      notifyListeners();
      return true;
    } else {
      // 로그인 실패
      return false;
    }
  }

  void logout() {
    _user = null; // 사용자 정보 삭제
    notifyListeners(); // 리스너에 변경 사항 알림
  }
}

class User {
  final String id;
  final String password;

  User({required this.id, required this.password}); // 생성자
}