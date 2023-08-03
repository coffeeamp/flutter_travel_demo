// providers/post_provider.dart

import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_travel_demo/post/post.dart';

class PostProvider with ChangeNotifier {
  List<Post> _posts = [];

  List<Post> get posts => _posts;

  Future<void> fetchPosts() async {
    final response = await http.get(Uri.parse('http://10.0.2.2:8000/my_app/post/'));
    final responseData = json.decode(response.body) as List<dynamic>;
    _posts = responseData.map((json) => Post.fromJson(json)).toList();
    notifyListeners();
  }
}