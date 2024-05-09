import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('스트림빌더'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),  // 스트림
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {// 스트림 빌더 함수
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());  // 데이터 로딩 시
          }

          if (snapshot.hasError) {
            return Center(child: Text('오류!: ${snapshot.error}'));  // 오류 발생
          }

          var users = snapshot.data!.docs;  // Firestore 문서 목록
          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              var user = users[index];
              var userName = user['name'];
              var userAge = user['age'];

              return ListTile(
                title: Text(userName),
                subtitle: Text('나이: $userAge'),
                trailing: IconButton(
                    onPressed: () {
                      //FirebaseFirestore.instance.collection('users').doc(user.id).delete();
                      user.reference.delete();
                    },
                    icon: Icon(Icons.delete)
                ),
              );
            },
          );
        },
      ),
    );
  }
}