import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/user.dart';

class UsersProvider extends ChangeNotifier {
  List<Users> _users = [];
  List<Users> get users => _users;
  String error = '';
  bool isDataLoaded = false;

  Future<void> fetchUsers() async {
    try {
      final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
      if (response.statusCode == 200) {
        final List<dynamic> jsonData = jsonDecode(response.body);
        _users = jsonData.map((user) => Users.fromJson(user)).toList();
      } else {
        throw Exception('Failed to fetch users');
      }
    } catch (e) {
      error = e.toString();
    }
    notifyListeners();
    isDataLoaded = true;
  }

  Users? getUserById(int id) {
    try {
      return _users.firstWhere((user) => user.id == id);
    } catch (e) {
      return null;
    }
  }
}