import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_8.dart';


class ChatBubbles extends StatelessWidget {
  const ChatBubbles(this.message, this.userName, this.isMe, this.userImage,{super.key});

  final String message;
  final String userName;
  final bool isMe;
  final String userImage;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children:[
        Row(
        mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if(isMe)
          Padding(
            padding: const EdgeInsets.fromLTRB(0,10,45,0),
            child: ChatBubble(
              clipper: ChatBubbleClipper8(type: BubbleType.sendBubble),
              alignment: Alignment.topRight,
              margin: EdgeInsets.only(top: 20),
              backGroundColor: Colors.blue,
              child: Container(
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.7,
                ),
                child: Column(
                  crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start, // 내가 보낸 메시지면 오른쪽 정렬, 상대방이 보낸 메시지면 왼쪽 정렬
                  children: [
                    Text(
                      userName,
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      message,
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
                ),
          ),
        if(!isMe)
        Padding(
          padding: const EdgeInsets.fromLTRB(45,10,0,0),
          child: ChatBubble(
              clipper: ChatBubbleClipper1(type: BubbleType.receiverBubble),
              backGroundColor: Color(0xffE7E7ED),
              margin: EdgeInsets.only(top: 20),
              child: Container(
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.7,
                ),
                child: Column(
                  crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start, // 내가 보낸 메시지면 오른쪽 정렬, 상대방이 보낸 메시지면 왼쪽 정렬
                  children: [
                    Text(
                      userName,
                      style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      message,
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),
              ),
            ),
        )
        ],
      ),
      Positioned(
        top : 0,
        right: isMe ? 5 : null,
        left: isMe ? null : 5,
        child: CircleAvatar(
          backgroundImage: NetworkImage(userImage),
        ),
        )
      ],
    );
  }
}