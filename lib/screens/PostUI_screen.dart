import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_travel_demo/post/post.dart';
import 'package:flutter_travel_demo/providers/post_provider.dart';
import 'package:provider/provider.dart';

class PostListScreen extends StatelessWidget {
  const PostListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Post List'),
      ),
      body: FutureBuilder(
        future: Provider.of<PostProvider>(context, listen: false).fetchPosts(),
        builder: (ctx, dataSnapshot){
          if(dataSnapshot.connectionState == ConnectionState.waiting){
            return Center(child: CircularProgressIndicator());
          }else{
            if(dataSnapshot.error != null){
              return Center(child: Text('An error occurred!'));
          }else{
            return Consumer<PostProvider>(
              builder: (ctx, postProvider, ch){
                List<Post> posts = postProvider.posts;
                return ListView.builder(
                  itemCount: posts.length,
                  itemBuilder:(context, index){
                    Post post = posts[index];
                    return ListTile(
                      title: Text(post.title),
                      subtitle: Text(post.content),
                    );
                  },
                );
              },
            );
          }
        }
      },
    ),
    );
  }
}