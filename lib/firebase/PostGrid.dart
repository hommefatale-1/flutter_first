import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:first/firebase/PostDetailPage.dart';

void main() async {
  // Firebase 초기화가 완료되기를 기다립니다.
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // 앱 실행
  runApp(PostGrid());
}

// 게시글 목록을 보여주는 위젯
class PostGrid extends StatelessWidget {
  const PostGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('게시글 목록'), // 앱 바의 제목
        ),
        body: Grid(), // 그리드 위젯을 본문으로 표시
      ),
    );
  }
}

// 게시글 이미지를 그리드로 표시하는 StatefulWidget
class Grid extends StatefulWidget {
  const Grid({Key? key}) : super(key: key);

  @override
  State<Grid> createState() => _GridState(); // Grid 위젯의 상태를 생성
}

// Grid 위젯의 상태를 관리하는 State 클래스
class _GridState extends State<Grid> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      // Firestore의 'posts' 컬렉션에서 데이터 변경을 감지하는 스트림
      stream: FirebaseFirestore.instance.collection('posts').snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // 데이터 로딩 중에는 프로그레스 인디케이터를 표시
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.hasError) {
          // 오류 발생 시 오류 메시지 표시
          return Center(
            child: Text('데이터를 불러오는 중 오류 발생: ${snapshot.error}'),
          );
        }
        // 데이터가 준비되면 게시글 이미지를 그리드로 표시
        return GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            // 4개의 열을 가진 그리드 생성
            crossAxisCount: 4,
            crossAxisSpacing: 1.0, // 열 간의 간격
            mainAxisSpacing: 1.0, // 행 간의 간격
          ),
          itemCount: snapshot.data!.docs.length, // 전체 게시글 수
          itemBuilder: (context, index) {
            // 각 게시글에 대해 탭 이벤트를 처리하기 위한 GestureDetector 생성
            var post = snapshot.data!.docs[index]; // 스냅샷에서 게시글 데이터 가져오기
            String imageUrl = post['imageUrl']; // 게시글 데이터에서 이미지 URL 가져오기
            return GestureDetector(
              onTap: () {
                // 게시글이 탭되면 해당 게시글의 상세보기 페이지로 이동
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PostDetailPage(imageUrl: imageUrl),
                  ),
                );
              },
              child: Image.network(imageUrl), // 게시글 이미지 표시
            );
          },
        );
      },
    );
  }
}
