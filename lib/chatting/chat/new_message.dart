import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class NewMessage extends StatefulWidget {
  const NewMessage({super.key});

  @override
  State<NewMessage> createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  final _controller = TextEditingController(); // 입력한 텍스트를 가져오기 위해 사용
  var _userEnteredMessage = '';

  void _sendMessage(){
    FocusScope.of(context).unfocus(); // 키보드가 사라지게 함
    final user = FirebaseAuth.instance.currentUser;
    FirebaseFirestore.instance.collection('chat').add({
      'text': _userEnteredMessage,
      'time': Timestamp.now(), // 현재 시간을 가져옴
      'userID': user!.uid
    });
    _controller.clear(); // 메시지를 보내고 나면 입력창을 비움
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8),
      padding: EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              maxLines: null,
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Send a message...'
              ),
              onChanged: (value){
                setState(() {
                  _userEnteredMessage = value;
                });
              },
            ),
          ),
          IconButton(
            onPressed: _userEnteredMessage.trim().isEmpty ? null : _sendMessage,
            icon: Icon(Icons.send),
            color: Colors.blue,
          )
        ]
      ),
    );
  }
}