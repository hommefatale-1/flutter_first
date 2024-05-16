import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:first/Login/Session.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'package:first/firebase/firestore.dart';
import 'package:first/firebase/userList.dart';
import 'package:first/firebase/googleLogin.dart';
import 'package:first/firebase/githubLogin.dart';
import 'package:first/firebase/ImageUpload.dart';
import 'package:first/firebase/post.dart';
import 'package:first/firebase/map.dart';
import 'package:first/firebase/Login.dart';
import 'package:first/firebase/Join.dart';
import 'package:first/firebase/emailLogin.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
      ChangeNotifierProvider(
        create: (context) => Session(),
        child: MyApp(),
      )
  );
}

class MyApp extends StatelessWidget {


  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  MyApp() {
    _firebaseMessaging.getToken().then((token) {
      print("토큰: $token");
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print(
          "Received a message: ${message.notification?.title}, ${message.notification?.body}");
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print(
          "Notification clicked: ${message.notification?.title}, ${message.notification?.body}");
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {

  TabController? _tabController;
  int _currentIndex = 0;
  late String userName; // 사용자 이름을 저장할 변수 추가

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  // 사용자 이름을 초기화하는 함수
  String _initializeUserName() {
    var session = Provider.of<Session>(context);
    setState(() {
      userName = session.isLoggedIn ? session.user!.id : '김승인';
    });
    return userName;
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('기본 구조 복습'),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: 'Tab 1'),
            Tab(text: 'Tab 2'),
          ],
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage('assets/kirby.jpg'),
                    ),
                    SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                        _initializeUserName(),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'abc@abc.com',
                          style: TextStyle(
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.login),
              title: Text("로그인"),
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Login()));
              },
            ),
            ListTile(
              leading: Icon(Icons.login),
              title: Text("이메일로그인"),
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => EmailLogin()));
              },
            ),
            ListTile(
              leading: Icon(Icons.add),
              title: Text("파이어스토어"),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => FireEx1()));
              },
            ),
            ListTile(
              leading: Icon(Icons.add),
              title: Text("리스트"),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => UserList()));
              },
            ),
            ListTile(
              leading: Icon(Icons.add),
              title: Text("게시글"),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => PostUpload()));
              },
            ),
            ListTile(
              leading: Icon(Icons.add),
              title: Text("지도"),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => TestMap()));
              },
            ),
            ListTile(
              leading: Icon(Icons.login),
              title: Text("회원가입"),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Join(),
                    ));
              },
            ),
            ListTile(
              leading: Icon(Icons.login),
              title: Text("GitHublogin"),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => GitHubLogin(),
                    ));
              },
            ),
            ListTile(
              leading: Icon(Icons.image),
              title: Text("Image"),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ImageUpload(),
                    ));
              },
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text("Home"),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text("setting"),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text("logout"),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          Center(child: Image.asset('iu.jpg')),
          Center(child: Image.asset('iu2.jpg')),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('${_currentIndex + 1} 번째 탭 클릭 ')),
          );
        },
      ),
    );
  }
}
