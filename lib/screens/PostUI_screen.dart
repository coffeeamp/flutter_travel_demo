import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_travel_demo/post/post.dart'; // Post 모델 클래스 파일
import 'package:flutter_travel_demo/post/post_provider.dart'; // PostProvider 클래스 파일

class PostUIScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Post UI'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                _showCreatePostDialog(context); // 게시글 작성 다이얼로그 호출
              },
              child: Text('게시글 작성'),
            ),
            ElevatedButton(
              onPressed: () {
                // 게시글 조회
                Provider.of<PostProvider>(context, listen: false).getAllPosts();
              },
              child: Text('게시글 조회'),
            ),
            Consumer<PostProvider>(
              builder: (context, postProvider, _) {
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: postProvider.posts.length,
                  itemBuilder: (context, index) {
                    Post post = postProvider.posts[index];
                    return ListTile(
                      title: Text(post.title),
                      subtitle: Text(post.content),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showCreatePostDialog(BuildContext context) {
    String title = '';
    String content = '';

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('게시글 작성'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(hintText: '제목'),
                onChanged: (value) => title = value,
              ),
              SizedBox(height: 8),
              TextField(
                decoration: InputDecoration(hintText: '내용'),
                onChanged: (value) => content = value,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('취소'),
            ),
            TextButton(
              onPressed: () async {
                if (title.isNotEmpty && content.isNotEmpty) {
                  Post post = Post(title: title, content: content);
                  await Provider.of<PostProvider>(context, listen: false).createPost(post);
                  Navigator.pop(context);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('제목과 내용을 입력해주세요.'),
                    ),
                  );
                }
              },
              child: Text('작성'),
            ),
          ],
        );
      },
    );
  }
}
