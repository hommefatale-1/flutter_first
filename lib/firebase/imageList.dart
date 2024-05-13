import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(ImageList());
}

class ImageList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyWidget(),
    );
  }
}

class MyWidget extends StatefulWidget {
  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  late Future<List<String>> _imageUrls; // 다운로드 URL 목록

  @override
  void initState() {
    super.initState();
    _imageUrls = _fetchImageUrls(); // 이미지 URL 호출
  }

  Future<List<String>> _fetchImageUrls() async {
    // "images" 경로의 모든 파일 목록 가져오기
    final storage = FirebaseStorage.instance.ref().child('images');
    final ListResult list = await storage.listAll();

    // URL 목록
    List<String> urls = [];
    for (var item in list.items) {
      String downloadUrl = await item.getDownloadURL();
      urls.add(downloadUrl);
    }

    return urls;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Firebase Storage Images'),
      ),
      body: FutureBuilder(
        future: _imageUrls,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else {
            List<String> imageUrls = snapshot.data!;

            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 4,
                mainAxisSpacing: 4,
              ),
              itemCount: imageUrls.length,
              itemBuilder: (context, index) {
                return Image.network(
                  imageUrls[index],
                  fit: BoxFit.cover, // 이미지 맞춤
                );
              },
            );
          }
        },
      ),
    );
  }
}