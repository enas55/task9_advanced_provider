import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:task9_advanced_provider/models/post_model.dart';

class PostProvider with ChangeNotifier {
  List<Post> _posts = [];

  List<Post> get posts => _posts;

  Future<void> getPosts() async {
    try {
      var dio = Dio();
      final response =
          await dio.get('https://jsonplaceholder.typicode.com/posts');
      if (response.statusCode == 200) {
        List data = response.data;
        _posts = data.map((e) => Post.fromJson(e)).toList();
        notifyListeners();
      } else {
        throw Exception('Failed to load posts');
      }
    } catch (e) {
      throw Exception('Failed to load posts: $e');
    }
  }
}
