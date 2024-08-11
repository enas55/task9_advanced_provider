import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:task9_advanced_provider/models/comment_model.dart';

class CommentProvider with ChangeNotifier {
  List<Comment> _comments = [];

  List<Comment> get comments => _comments;

  Future<void> getComments(int postId) async {
    try {
      var dio = Dio();
      final response = await dio
          .get('https://jsonplaceholder.typicode.com/posts/$postId/comments');
      if (response.statusCode == 200) {
        List data = response.data;
        _comments = data.map((e) => Comment.fromJson(e)).toList();
        notifyListeners();
      } else {
        throw Exception('Failed to load comments');
      }
    } catch (e) {
      throw Exception('Failed to load comments: $e');
    }
  }
}
