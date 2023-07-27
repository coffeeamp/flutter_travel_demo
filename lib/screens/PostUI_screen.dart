import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_travel_demo/post/post.dart';
import 'package:flutter_travel_demo/post/post_provider.dart';
import 'package:provider/provider.dart';

class PostScreen extends StatelessWidget {
  const PostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final postProvider = Provider.of<PostProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text('포스팅 화면'), // 타이틀 텍스트
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () async {
              await postProvider.getAllPost(); // 포스트 리스트를 가져옴
            },
            child: Text('포스트 가져오기'),
          ),
          Consumer<PostProvider>(
            builder : (context, postProvider, child){
              if (postProvider.posts.isEmpty){
                return Text('포스트가 없습니다.');
              } else{
                return Expanded(
                  child: ListView.builder(
                    itemCount: postProvider.posts.length, // 포스트 리스트의 길이만큼 아이템을 만듬
                    itemBuilder: (context, index){
                      return ListTile(
                        title: Text(postProvider.posts[index].title), // 포스트의 타이틀을 가져옴
                        subtitle: Text(postProvider.posts[index].content), // 포스트의 내용을 가져옴
                      );
                    }
                  )
                );
              }
            }
          ),
        ],
      ),
    );
  }
}