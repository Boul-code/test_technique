import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled6/pages/detail/detail.dart';
import 'package:untitled6/providers/comments_provider.dart';

import '../../../providers/comments_provider.dart';
import '../../../providers/pictures_provider.dart';

class Comments extends StatefulWidget {
  final int postId;

  const Comments({Key? key, required this.postId}) : super(key: key);

  @override
  _CommentsState createState() => _CommentsState();
}

class _CommentsState extends State<Comments> {
  @override
  void initState() {
    super.initState();
    final commentsProvider = Provider.of<CommentsProvider>(context, listen: false);
    final randomPhotoProvider = Provider.of<PicturesProvider>(context, listen: false);
    commentsProvider.fetchCommentsById(widget.postId);
    commentsProvider.fetchCommentsById(widget.postId).then((_) {
      if (commentsProvider.comments.isNotEmpty) {
        randomPhotoProvider.fetchRandomPhotos(commentsProvider.comments.length);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
          border: Border.all(
            color: Colors.black,
            width: 3,
          ),
        ),
        child: Column(
            children: [
              Container(
                  padding: const EdgeInsets.only(
                    top: 20,
                    bottom: 20,
                    left: 15,
                    right: 15,
                  ),
                  child: Stack(
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                          color: Color(0xFFFFBA05),
                        ),
                        margin: const EdgeInsets.only(bottom: 20, left: 20),
                        height: 23,
                        width: 205,
                      ),
                      const Text(
                        'Commentaires',
                        style: TextStyle(
                          fontFamily: 'PublicSans',
                          fontSize: 30,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.none,
                        ),
                        textAlign: TextAlign.start,
                      ),
                    ],
                  )
              ),
              Container(
                decoration: const BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: Colors.black,
                      width: 3,
                    ),
                  ),
                ),
                child: Consumer<CommentsProvider>(
                  builder: (context, commentsProvider, _) {
                    if (commentsProvider.comments.isEmpty) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      return SingleChildScrollView(
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: commentsProvider.comments.length,
                          itemBuilder: (context, index) {
                            final post = commentsProvider.comments[index];
                            return commentsUi(context, commentsProvider.comments[index], index);
                          },
                        ),
                      );
                    }
                  },
                ),
              )
            ]
        )
    );
  }
  Widget commentsUi(BuildContext context, comments, int index) {
    return Container(
      margin: const EdgeInsets.only(
        bottom: 40,
        left: 10,
        right: 10,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: const Color(0xFFFFF4E8),
        border: Border.all(
          color: Colors.black,
          width: 3,
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.only(
                    top: 15,
                    bottom: 15,
                    right: 15,
                    left: 15
                ),
                margin: const EdgeInsets.only(
                  right: 10
                ),
                child: Consumer<PicturesProvider>(
                  builder: (context, randomPhotoProvider, _) {
                    if (randomPhotoProvider.randomPhotos.isEmpty) {
                      return Container(
                        padding: const EdgeInsets.all(2),
                        child: const CircleAvatar(
                          backgroundImage: AssetImage('assets/images/avatar.jpg'),
                          radius: 55,
                        ),
                      );
                    } else {
                      final randomPhotos = randomPhotoProvider.randomPhotos;
                      final randomPhotoIndex = index % randomPhotos.length;
                      final randomPhoto = randomPhotos[randomPhotoIndex];
                      return DottedBorder(
                        borderType: BorderType.Circle,
                        strokeWidth: 2,
                        color: Colors.black,
                        dashPattern: const [8, 4],
                        child: Container(
                          padding: const EdgeInsets.all(2),
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(randomPhoto.url),
                            radius: 25,
                          ),
                        ),
                      );
                    }
                  },
                ),
              ),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      comments.name,
                      style: const TextStyle(
                        fontFamily: 'PublicSans',
                        fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.none,
                      ),
                      textAlign: TextAlign.start,
                    ),
                    const SizedBox(height: 10,),
                    Text(
                      comments.email,
                      style: const TextStyle(
                        fontFamily: 'PublicSans',
                        fontSize: 12,
                        color: Color(0xFF3F3F3F),
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.none,
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
              ),
            ],
          ),
          LayoutBuilder(
              builder: (context, constraints) {
                return SizedBox(
                  width: constraints.maxWidth,
                  child: Container(
                    padding: const EdgeInsets.only(
                        top: 15,
                        bottom: 15,
                        right: 15,
                        left: 15
                    ),
                    decoration: const BoxDecoration(
                      border: Border(
                        top: BorderSide(
                          color: Colors.black,
                          width: 3,
                        ),
                      ),
                    ),

                    child:  Text(
                      comments.body,
                      style: const TextStyle(
                        fontFamily: 'PublicSans',
                        fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.none,
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ),
                );
              }
          )
        ],
      ),
    );
  }


}


