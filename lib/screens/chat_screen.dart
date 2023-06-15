import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_travel_demo/chatting/chat/message.dart';
import 'package:flutter_travel_demo/chatting/chat/new_message.dart';


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
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: Messages()
            ),
            NewMessage()
          ],
        ),
      )
    );
  }
}