import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
        ),
      ),
      body:Padding(
        padding: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ElevatedButton(
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ChatScreen()));
                },
                child: Text('Chat'),
              ),
              ElevatedButton(
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ApiScreen()));
                },
                child: Text('API'),
              ),
              ElevatedButton(
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ApiScreen())); // 수정 필요
                },
                child: Text('POST'),
              ),
            ],
          )
        ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_filled),
            label: '홈',
            backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_sharp),
            label: '마이페이지',
            backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: '설정',
            backgroundColor: Colors.blue,
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
