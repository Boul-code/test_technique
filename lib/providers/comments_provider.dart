import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:test_technique/models/comments.dart';

class CommentsProvider with ChangeNotifier {
  List<Comments> comments = [];
  String error = '';

  Future<void> fetchCommentsById(int postId) async {
    try {
      final url = Uri.parse('https://jsonplaceholder.typicode.com/comments?postId=$postId');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = jsonDecode(response.body);
        comments = jsonData.map((comments) => Comments.fromJson(comments)).toList();
      } else {
        throw Exception('Failed to fetch comments');
      }
    } catch (e) {
      error = e.toString();
    }
    notifyListeners();
  }

  Future<void> postComment(String name, String email, String body, int postId) async {
    try {
      final url = Uri.parse('https://jsonplaceholder.typicode.com/comments');
      final response = await http.post(
        url,
        body: jsonEncode({
          'name': name,
          'email': email,
          'body': body,
          'postId': postId,
        }),
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode == 201) {
        final dynamic jsonData = jsonDecode(response.body);
        final newComment = Comments.fromJson(jsonData);
        comments.insert(0, newComment);
      } else {
        throw Exception('Failed to post comment');
      }
    } catch (e) {
      error = e.toString();
    }
    notifyListeners();
  }
}