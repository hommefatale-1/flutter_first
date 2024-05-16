import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  runApp(MaterialApp(
    home: PostDetailPage(imageUrl: ''), // 앱 실행 시 PostDetailPage를 홈 화면으로 설정
  ));
}

class PostDetailPage extends StatelessWidget {
  final String imageUrl;

  PostDetailPage({Key? key, required this.imageUrl}) : super(key: key);// 이미지 URL을 받기 위한 생성자

  TextEditingController _commentController = TextEditingController(); // 댓글 입력을 위한 컨트롤러

  void _showCommentSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                '댓글 작성',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _commentController, // 댓글을 입력받는 텍스트필드에 컨트롤러 연결
                decoration: InputDecoration(
                  hintText: '댓글을 입력하세요',
                  border: OutlineInputBorder(),
                ),
                maxLines: null,
                keyboardType: TextInputType.multiline,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // 댓글을 전송하는 기능 추가
                  _addComment(_commentController.text, context);
                },
                child: Text('댓글 작성'),
              ),
            ],
          ),
        );
      },
    );
  }

  void _addComment(String comment, BuildContext context) {
    // 현재 시간을 타임스탬프로 저장
    Timestamp timestamp = Timestamp.fromDate(DateTime.now());
    // Firebase의 'comments' 컬렉션에 댓글 추가
    FirebaseFirestore.instance.collection('comments').add({
      'comment': comment,
      'timestamp': timestamp,
    }).then((value) {
      // 댓글 작성 성공 시 알림창 표시
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('댓글이 작성되었습니다.'),
      ));
      // 댓글 작성 완료 후 텍스트필드 초기화
      _commentController.clear();
    }).catchError((error) {
      // 댓글 작성 실패 시 알림창 표시
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('댓글 작성에 실패했습니다.'),
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('게시글 상세보기'), // 앱바 타이틀
      ),
      body: FutureBuilder(
        future: FirebaseFirestore.instance.collection('posts').where('imageUrl', isEqualTo: imageUrl).get(),
        // 이미지 URL을 기반으로 Firestore에서 게시물 세부 정보를 가져오는 FutureBuilder
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // 데이터를 기다리는 동안 로딩 인디케이터 표시
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            // 데이터를 가져오는 도중 오류가 발생하면 오류 메시지 표시
            return Center(child: Text('오류: ${snapshot.error}'));
          }
          if (snapshot.data!.docs.isEmpty) {
            // 데이터가 없으면 메시지 표시
            return Center(child: Text('데이터를 찾을 수 없습니다.'));
          }
          // 데이터가 있으면 게시물 세부 정보 추출
          var post = snapshot.data!.docs.first;
          String title = post['title'];
          String content = post['content'];

          return Stack(
            children: [
              // 이미지 위에 텍스트를 오버레이할 Stack
              Image.network(imageUrl, fit: BoxFit.cover, width: double.infinity), // 게시물 이미지 표시
              Positioned(
                top: 20,
                left: 20,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 제목은 화면 상단 왼쪽에 표시
                    Text(
                      '제목',
                      style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Text(
                      title,
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 20,
                left: 20,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 내용은 화면 하단 왼쪽에 표시
                    Text(
                      '내용',
                      style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Text(
                      content,
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            IconButton(
                onPressed: () => _showCommentSheet(context), // 댓글 아이콘 클릭 시 댓글 창 표시
                icon: Icon(Icons.comment)
            ),
          ],
        ),
      ),
    );
  }
}
