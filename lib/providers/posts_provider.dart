import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import '../models/posts.dart';
import 'package:flutter/material.dart';

class PostsProvider extends ChangeNotifier {
  static const apiEndPoint = 'https://jsonplaceholder.typicode.com/posts';
  bool isLoading = true;
  String error = '';
  List<Posts> posts = [];
  List<Posts> searchedPosts = [];
  int batchCount = 3;
  int currentPage = 1;
  bool hasMoreData = true;
  bool get hasError => error.isNotEmpty;
  final ScrollController scrollController = ScrollController();
  bool isDataLoaded = false;



  Future<void> getDataFromAPI() async {
    try {
      final response = await http.get(Uri.parse('$apiEndPoint?_page=$currentPage&_limit=$batchCount'));
      if (response.statusCode == 200) {
        final List<Posts> fetchedPosts = postsFromJson(response.body);
        posts.addAll(fetchedPosts);
        searchedPosts = List.from(posts);
        currentPage++;
        if (fetchedPosts.isEmpty || fetchedPosts.length < batchCount) {
          hasMoreData = false;
        }
      } else {
        error = response.statusCode.toString();
      }
    } catch (e) {
      error = e.toString();
    }
    isLoading = false;
    isDataLoaded = true;
    notifyListeners();
  }

  void loadMoreData() async {
    if (!isLoading && hasMoreData) {
      isLoading = true;
      try {
        final response = await http.get(Uri.parse('$apiEndPoint?_page=$currentPage&_limit=$batchCount'));
        if (response.statusCode == 200) {
          final List<Posts> fetchedPosts = postsFromJson(response.body);
          posts.addAll(fetchedPosts);
          currentPage++;
          if (searchText.isEmpty) {
            searchedPosts = List.from(posts);
          } else {
            searchedPosts = posts
                .where((post) => post.title.toLowerCase().startsWith(searchText))
                .toList();
          }
          if (fetchedPosts.isEmpty || fetchedPosts.length < batchCount) {
            hasMoreData = false;
          } else {
            hasMoreData = true;
          }
        } else {
          error = response.statusCode.toString();
        }
      } catch (e) {
        error = e.toString();
      }
      isLoading = false;
      notifyListeners();
    }
  }

  void updateData() {
    if (searchText.isEmpty) {
      searchedPosts = List.from(posts);
    } else {
      searchedPosts = posts
          .where((post) => post.title.toLowerCase().startsWith(searchText))
          .toList();
    }
    notifyListeners();
  }

  String searchText = '';

  void search(String username) {
    searchText = username.toLowerCase();
    updateData();
  }

  void initializeScrollListener() {
    scrollController.addListener(() {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        loadMoreData();
      }
    });
  }

  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  Future<void> addPost(String title, String body) async {
    try {
      final response = await http.post(
        Uri.parse(apiEndPoint),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'title': title,
          'body': body,
          'userId': 1,
        }),
      );

      if (response.statusCode == 201) {
        final newPost = Posts.fromJson(jsonDecode(response.body));
        searchedPosts.insert(0, newPost);
      } else {
        error = response.statusCode.toString();
      }
    } catch (e) {
      error = e.toString();
    }
    notifyListeners();
  }
}
