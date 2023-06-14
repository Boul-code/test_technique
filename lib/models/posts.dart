// To parse this JSON data, do
//
//     final Posts = PostsFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<Posts> postsFromJson(String str) => List<Posts>.from(json.decode(str).map((x) => Posts.fromJson(x)));

String postsToJson(List<Posts> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Posts {
  final int userId;
  final int id;
  final String title;
  final String body;

  Posts({
    required this.userId,
    required this.id,
    required this.title,
    required this.body,
  });

  factory Posts.fromJson(Map<String, dynamic> json) => Posts(
    userId: json["userId"],
    id: json["id"],
    title: json["title"],
    body: json["body"],
  );

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "id": id,
    "title": title,
    "body": body,
  };
}
