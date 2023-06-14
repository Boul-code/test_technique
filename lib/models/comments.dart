// To parse this JSON data, do
//
//     final Comments = CommentsFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<Comments> CommentsFromJson(String str) => List<Comments>.from(json.decode(str).map((x) => Comments.fromJson(x)));

String CommentsToJson(List<Comments> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Comments {
  final int postId;
  final int id;
  final String name;
  final String email;
  final String body;

  Comments({
    required this.postId,
    required this.id,
    required this.name,
    required this.email,
    required this.body,
  });

  factory Comments.fromJson(Map<String, dynamic> json) => Comments(
    postId: json["postId"],
    id: json["id"],
    name: json["name"],
    email: json["email"],
    body: json["body"],
  );

  Map<String, dynamic> toJson() => {
    "postId": postId,
    "id": id,
    "name": name,
    "email": email,
    "body": body,
  };
}