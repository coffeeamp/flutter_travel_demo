import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_travel_demo/chatting/chat/chat_bubble.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Messages extends StatelessWidget {
  const Messages({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return StreamBuilder(
      stream: FirebaseFirestore.instance
        .collection('chat')
        .orderBy('time', descending: true)
        .snapshots(), // 실시간으로 데이터를 가져옴
      builder: (context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot){ // 스트림에서 최신의 데이터를 가져오기 위해 AsyncSnapshot 사용
        if(snapshot.connectionState == ConnectionState.waiting){ // 연결이 되기 전까지는 로딩중이라고 표시
          return Center(
            child: CircularProgressIndicator(), // 로딩중이라고 표시
          );
        }
        final chatdocs = snapshot.data!.docs; // final docs는 테이블의 내용
        return ListView.builder(
          reverse: true,
          itemCount: chatdocs.length,
          itemBuilder: (context, index){
            return ChatBubbles( // 
              chatdocs[index]['text'],
              chatdocs[index]['userID'].toString() == user!.uid,
              chatdocs[index]['userName'].toString(),
            );
          },
        );
      }
    );
  }
}