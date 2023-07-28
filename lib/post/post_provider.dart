// post_provider.dart (PostProvider 클래스 파일)
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_travel_demo/post/post.dart';

class PostProvider extends ChangeNotifier {
  final String baseUrl = "http://10.0.2.2:8000/my_app/post/"; // Django 서버의 URL

  List<Post> _posts = [];
  List<Post> get posts => _posts;

  Future<void> getAllPosts() async {
    try {
      var response = await http.get(Uri.parse(baseUrl));
      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = json.decode(response.body);
        _posts = jsonResponse.map((json) => Post.fromJson(json)).toList();
        notifyListeners();
      } else {
        throw Exception('Failed to load posts');
      }
    } catch (e) {
      throw Exception('Failed to load posts: $e');
    }
  }

  Future<void> createPost(Post post) async {
    try {
      var response = await http.post(
        Uri.parse(baseUrl),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode(post.toJson()),
      );
      if (response.statusCode == 201) {
        // 성공적으로 게시글이 생성됨
        _posts.add(post);
        notifyListeners();
      } else {
        throw Exception('Failed to create post');
      }
    } catch (e) {
      throw Exception('Failed to create post: $e');
    }
  }
}
