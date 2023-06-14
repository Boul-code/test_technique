import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_technique/pages/detail/widget/article_body.dart';
import 'package:test_technique/pages/detail/widget/comments.dart';
import 'package:test_technique/pages/detail/widget/header.dart';
import '../../models/posts.dart';
import '../../models/user.dart';
import '../../providers/comments_provider.dart';
import '../../providers/pictures_provider.dart';
import '../detail/widget/postButton.dart';

class Detail extends StatelessWidget {
  final Posts post;
  final Users user;

  const Detail({Key? key, required this.post, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<CommentsProvider>(
          create: (_) => CommentsProvider(),
        ),
        ChangeNotifierProvider<PicturesProvider>(
          create: (_) => PicturesProvider(),
        ),
      ],
      child: Scaffold(
        body: Container(
          color: const Color(0xFFFFF4E8),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Header(user: user,),
                      Container(
                        padding: const EdgeInsets.only(
                          top: 25,
                          left: 10,
                          right: 10,
                        ),
                        child: Column (
                          children: [
                            Container(
                              margin: const EdgeInsets.only(
                                  bottom: 25
                              ),
                              child: ArticleBody(posts: post),
                            ),
                            Container(
                              margin: const EdgeInsets.only(
                                  bottom: 25
                              ),
                              child: PostButton(postId: post.id),
                            ),
                            Comments(postId: post.id),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

