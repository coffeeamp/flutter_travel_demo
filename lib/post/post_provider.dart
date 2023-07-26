import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

class PostProvider extends ChangeNotifier {
  String baseUrl = "http://10.0.2.2:8000/my_app/post/";
