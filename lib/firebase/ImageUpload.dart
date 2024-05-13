import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io'; // File

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(ImageUpload());
}

class ImageUpload extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: UploadPage(),
    );
  }
}

class UploadPage extends StatefulWidget {
  @override
  _UploadPageState createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
  final ImagePicker _picker = ImagePicker();
  File? _selectedImage;
  bool isLoading = false;

  // 이미지 선택
  Future<void> _pickImage() async {
    XFile? pickedImage = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        _selectedImage = File(pickedImage.path);
      });
    }
  }

  // Firebase Storage에 업로드
  Future<void> _uploadImage() async {
    if (_selectedImage == null) {
      print("이미지 선택하셈");
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      var storageRef = FirebaseStorage.instance.ref().child('images/${DateTime.now().millisecondsSinceEpoch}.jpg');
      await storageRef.putFile(_selectedImage!);

      var downloadUrl = await storageRef.getDownloadURL();

      print("다운로드 주소: $downloadUrl");
    } catch (e) {
      print("에러");
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload Image'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_selectedImage != null)
              Image.file(_selectedImage!), // 미리보기
            ElevatedButton(
              onPressed: isLoading ? null : _pickImage,
              child: Text('이미지 선택'),
            ),
            ElevatedButton(
              onPressed: isLoading || _selectedImage == null ? null : _uploadImage,
              child: Text('업로드'),
            ),
          ],
        ),
      ),
    );
  }
}