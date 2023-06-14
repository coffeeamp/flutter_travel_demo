import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _authentication = FirebaseAuth.instance;
  User? loggedUser; // ?는 null이 될 수 있다는 뜻

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getcurrentUser();
  } // initState는 위젯이 생성될 때 호출되는 함수

  void getcurrentUser(){
    try{
      final user = _authentication.currentUser;
      if(user != null){ // user가 null이 아니면
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
        title: Text('Chat Screen')
      ),
      body: StreamBuilder(
        // collection은 테이블이라고 생각하면 됨, 테이블의 이름은 chats, 
        // 그리고 그 테이블의 5eJ16uYrbBSZQRtO2L1i라는 id를 가진 테이블의 message를 가져옴
        stream: FirebaseFirestore.instance.collection( 
          '/chats/5eJ16uYrbBSZQRtO2L1i/message').snapshots(), // 실시간으로 데이터를 가져옴
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot){
            final docs = snapshot.data!.docs; // final docs는 테이블의 내용
            return ListView.builder(
              itemCount: docs.length, // 테이블의 길이만큼 리스트뷰를 만듦
              itemBuilder: (context, index){
                return Container(
                  child: Text(docs[index]['text'],
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                    )
                  ),
                );
              },
            );
          },
      ),
    );
  }
}