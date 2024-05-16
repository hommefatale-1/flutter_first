import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(PostUpload());
}

class PostUpload extends StatelessWidget {
  const PostUpload({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PostPage(),
    );
  }
}

class PostPage extends StatefulWidget {
  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  final ImagePicker _picker = ImagePicker();
  TextEditingController _titleController = TextEditingController();
  TextEditingController _contentController = TextEditingController();
  File? _selectedImage;

  //이미지 선택
  Future<void> _pickImage() async {
    XFile? pickedImage = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _selectedImage = File(pickedImage.path);
      });
    }
  }

  // 이미지 미리보기 위젯
  Widget _buildPreviewImage() {
    return _selectedImage == null
        ? Container()
        : Container(
            width: 200,
            height: 200,
            child: Image.file(_selectedImage!),
          );
  }

void _post() async{
    String title = _titleController.text;
    String content = _contentController.text;

    // 이미지가 선택되었는지 확인
    if (_selectedImage == null) {
      print('이미지를 선택하세요.');
      return;
    }
    try{
      var storageRef = FirebaseStorage.instance.ref().child('images/${DateTime.now().millisecondsSinceEpoch}.jpg');
      await storageRef.putFile(_selectedImage!);
      // 이미지 업로드 성공 시, 이미지 다운로드 URL 가져오기
      String imageUrl = await storageRef.getDownloadURL();

      // 게시글 데이터 Firestore에 저장
      await FirebaseFirestore.instance.collection('posts').add({
        'title': title,
        'content': content,
        'imageUrl': imageUrl, // 이미지 URL도 함께 저장
        'timestamp': Timestamp.now(), // 게시글 생성 시간도 함께 저장
      });

      // 게시 후 입력 필드 초기화
      _titleController.clear();
      _contentController.clear();
      setState(() {
        _selectedImage = null;
      });

    }catch (error) {
      print('게시글 등록 중 오류 발생: $error');
    }

}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('게시글등록'),
      ),
      body: Center(
        child: Column(
          children: [
            //이미지 미리보기
            _buildPreviewImage(),
            SizedBox(height: 20),
            //이미지 업로드
            ElevatedButton(
              onPressed: _pickImage,
              child: Text('이미지 선택'),
            ),
            SizedBox(height: 20,),
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                hintText: '게시글 제목',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20,),
            TextField(
              controller:_contentController,
              maxLines: null, //여러 줄 허요
              keyboardType: TextInputType.multiline,//여러 줄의 텍스트 입력 키보드 표시
              decoration: InputDecoration(
                hintText: '게시글 내용',
                border: OutlineInputBorder(),
              ),
            ),
            ElevatedButton(
                onPressed: _post,
                child:Text('등록하기'),
            ),
          ],
        ),
      ),
    );
  }
}
