// To parse this JSON data, do
//
//     final Picture = PictureFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<Picture> PictureFromJson(String str) => List<Picture>.from(json.decode(str).map((x) => Picture.fromJson(x)));

String PictureToJson(List<Picture> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Picture {
  final int albumId;
  final int id;
  final String title;
  final String url;
  final String thumbnailUrl;

  Picture({
    required this.albumId,
    required this.id,
    required this.title,
    required this.url,
    required this.thumbnailUrl,
  });

  factory Picture.fromJson(Map<String, dynamic> json) => Picture(
    albumId: json["albumId"],
    id: json["id"],
    title: json["title"],
    url: json["url"],
    thumbnailUrl: json["thumbnailUrl"],
  );

  Map<String, dynamic> toJson() => {
    "albumId": albumId,
    "id": id,
    "title": title,
    "url": url,
    "thumbnailUrl": thumbnailUrl,
  };
}
