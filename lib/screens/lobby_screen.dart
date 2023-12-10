import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  User? loggedUser; // ?는 null이 될 수 있다는 뜻

  @override
  void initState() {
    // TODO: implement initState 
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async { // 로그인이 되어있는지 확인
    try{
      final user = _authentication.currentUser;
      if (user != null) { // 로그인이 되어있으면
        loggedUser = user; // loggedUser에 user를 넣어줌
        print(loggedUser!.email);
      }
    }catch(e){
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lobby page'),
        actions: [
          IconButton(
            onPressed: (){
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
              child: Text('Drawer Header'),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
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
