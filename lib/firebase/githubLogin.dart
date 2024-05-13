import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_web_auth/flutter_web_auth.dart';

class GitHubAuth {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> signInWithGitHub() async {
    // GitHub OAuth 요청
    final result = await FlutterWebAuth.authenticate(
      url: 'https://github.com/login/oauth/authorize?client_id=Ov23liIES1bWyREvsGAg',
      callbackUrlScheme: 'myapp',
    );


    final code = Uri.parse(result).queryParameters['code'];

    final credential = GithubAuthProvider.credential(code!);

    await _auth.signInWithCredential(credential);
  }
}

class GitHubLogin extends StatelessWidget {
  final GitHubAuth _gitHubAuth = GitHubAuth();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('GitHub Auth')),
      body: Center(
        child: ElevatedButton(
          onPressed: _gitHubAuth.signInWithGitHub,
          child: Text('Sign In with GitHub'),
        ),
      ),
    );
  }
}