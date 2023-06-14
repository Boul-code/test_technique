import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/posts_provider.dart';

class MySearchBar extends StatefulWidget {
  final PostsProvider postsProvider;

  const MySearchBar({required this.postsProvider, Key? key}) : super(key: key);

  @override
  State<MySearchBar> createState() => _MySearchBarState();
}

class _MySearchBarState extends State<MySearchBar> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      alignment: Alignment.center,

      decoration: BoxDecoration(
        color: const Color(0xFFc8ecf3),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(8),
          topRight: Radius.circular(8),
        ),
        border: Border.all(
          color: Colors.black,
          width: 3,
        ),
      ),
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: TextField(
        onChanged: (value) {
          widget.postsProvider
              .search(value);
        },
        style: const TextStyle(color: Colors.black),
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.black, width: 3),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.black, width: 3),
          ),
          prefixIcon: const Icon(Icons.search, color: Colors.black),
          hintText: 'Rechercher',
          hintStyle: const TextStyle(color: Colors.black54),
        ),
      ),
    );
  }
}
