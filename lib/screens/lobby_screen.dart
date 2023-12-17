import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter_travel_demo/screens/APIconnect_screen.dart';
import 'package:flutter_travel_demo/screens/chat_screen.dart';
// import 'package:flutter_travel_demo/screens/counter.dart';


class LobbyScreen extends StatefulWidget {
  const LobbyScreen({super.key});

  @override
  State<LobbyScreen> createState() => _LobbyScreenState();
}

class _LobbyScreenState extends State<LobbyScreen> {
  final _authentication = FirebaseAuth.instance;
  User? loggedUser;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async { // 현재 유저 정보 가져오기
    try {
      final user = _authentication.currentUser; 
      if (user != null) {
        setState(() {
          loggedUser = user;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  Future<String> getUserProfileImageUrl(String userId) async {
    try {
      // 여기서 userId를 사용하여 데이터베이스 또는 다른 소스에서 이미지 URL을 가져오기
      // 아래는 예시로 Firebase Storage에서 가져오는 방법

      firebase_storage.Reference ref =
          firebase_storage.FirebaseStorage.instance.ref().child('picked_image/$userId.png');
      String downloadUrl = await ref.getDownloadURL();

      return downloadUrl;
    } catch (e) {
      print(e);
      return ''; // 에러가 발생하면 빈 문자열 반환 또는 다른 기본값 설정
    }
  }
@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lobby page'),
        actions: [
          IconButton(
            onPressed: () {
              _authentication.signOut();
            },
            icon: Icon(Icons.exit_to_app_outlined),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Column(
                children: [
                   // 로그인이 되어있으면 프로필 이미지를 보여줌
            if (loggedUser != null)
              FutureBuilder<String>(
                future: getUserProfileImageUrl(loggedUser!.uid),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator(); // 데이터를 기다리는 동안 로딩 표시
                  }
                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  }
                  return CircleAvatar(
                    backgroundImage: NetworkImage(snapshot.data!),
                    radius: 40,
                  );
                },
              ),
            // 유저 이메일을 보여줌
            if (loggedUser != null)
              Text(
                loggedUser!.email!,
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
                ],
              )
            ),
          ],
        ),
      ),
      body: Padding(
  padding: EdgeInsets.fromLTRB(10, 50, 10, 10),
  child: GridView.count(
    crossAxisCount: 3, // 열의 개수
    mainAxisSpacing: 10.0, // 수직 간격
    crossAxisSpacing: 10.0, // 수평 간격
    children: [
      ElevatedButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => ChatScreen()));
        },
        style: ElevatedButton.styleFrom(
          backgroundColor : Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Text('채팅'),
      ),
      ElevatedButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => ApiScreen()));
        },
        style: ElevatedButton.styleFrom(
          backgroundColor : Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Text('API'),
      ),
      ElevatedButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => ApiScreen())); // 수정 필요함
        },
        style: ElevatedButton.styleFrom(
          backgroundColor : Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Text('POST'),
      ),
      ElevatedButton(
        onPressed: () {
          // Add your logic for the fourth button
        },
        style: ElevatedButton.styleFrom(
          backgroundColor : Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Text('Button 4'),
      ),
      ElevatedButton(
        onPressed: () {
          // Add your logic for the fifth button
        },
        style: ElevatedButton.styleFrom(
          backgroundColor : Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Text('Button 5'),
      ),
      ElevatedButton(
        onPressed: () {
          // Add your logic for the sixth button
        },
        style: ElevatedButton.styleFrom(
          backgroundColor : Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Text('Button 6'),
      ),
    ],
  ),
),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_filled),
            label: '홈',
            backgroundColor: Colors.white,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_sharp),
            label: '마이페이지',
            backgroundColor: Colors.white,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: '설정',
            backgroundColor: Colors.white,
          ),
        ],
        onTap: (int index){
          if(index == 0){
            Navigator.push(context, MaterialPageRoute(builder: (context) => LobbyScreen()));
          }
          else if(index == 1){
            Navigator.push(context, MaterialPageRoute(builder: (context) => LobbyScreen()));
          }
          else if(index == 2){
            Navigator.push(context, MaterialPageRoute(builder: (context) => LobbyScreen()));
          }
        }
      ),
      ); 
  }
}
