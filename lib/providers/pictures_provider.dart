import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:math';
import 'package:untitled6/models/picture.dart';

class PicturesProvider with ChangeNotifier {
  List<Picture> randomPhotos = [];
  String error = '';

  Future<void> fetchRandomPhotos(int count) async {
    try {
      final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));
      if (response.statusCode == 200) {
        final List<dynamic> jsonData = jsonDecode(response.body);
        final List<Picture> pictures = jsonData.map((data) => Picture.fromJson(data)).toList();
        pictures.shuffle(); // Mélangez les photos aléatoirement
        randomPhotos = pictures.take(count).toList(); // Prenez les "count" premières photos
      } else {
        throw Exception('Failed to fetch random photos');
      }
    } catch (e) {
      error = e.toString();
    }
    notifyListeners();
  }
}