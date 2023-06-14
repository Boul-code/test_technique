import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_technique/pages/home/widget/searchBar.dart';

import '../../../providers/posts_provider.dart';

class BottomSheetButton extends StatelessWidget {
  const BottomSheetButton({Key? key});

  @override
  Widget build(BuildContext context) {
    final postsProviders = Provider.of<PostsProvider>(context);
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.black,
          width: 2,
        ),
        boxShadow: const [
          BoxShadow(
            color: Colors.black,
            offset: Offset(1, 2),
            blurRadius: 0,
          ),
        ],
      ),
      child: Material(
        elevation: 0,
        shape: const CircleBorder(),
        color: const Color(0xFFFFDC02),
        child: GestureDetector(
          onTap: () {
            showModalBottomSheet<void>(
              barrierColor: Colors.transparent,
              context: context,
              isDismissible: true,
              builder: (BuildContext context) {
                return SingleChildScrollView(
                  padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: MySearchBar(postsProvider: postsProviders),
                );
              },
            );
          },
          child: const Icon(
            Icons.search,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
