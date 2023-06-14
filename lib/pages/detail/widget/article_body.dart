import 'package:flutter/material.dart';
import '../../../models/posts.dart';

class ArticleBody extends StatefulWidget {
  final Posts posts;

  const ArticleBody({Key? key, required this.posts}) : super(key: key);

  @override
  _ArticleBodyState createState() => _ArticleBodyState();
}

class _ArticleBodyState extends State<ArticleBody> {
  late Size textSize = Size.zero;
  bool showFullText = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      calculateTextSize();
    });
  }

  void calculateTextSize() {
    final textSpan = TextSpan(
      text: widget.posts.body,
      style: const TextStyle(
        fontFamily: 'PublicSans',
        fontSize: 20,
        color: Colors.black,
        fontWeight: FontWeight.bold,
      ),
    );
    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
      maxLines: showFullText ? null : 2,
    );
    textPainter.layout(maxWidth: MediaQuery.of(context).size.width);
    setState(() {
      textSize = textPainter.size;
    });
  }

  int getLineCount() {
    final textSpan = TextSpan(
      text: widget.posts.body,
      style: const TextStyle(
        fontFamily: 'PublicSans',
        fontSize: 20,
        color: Colors.black,
        fontWeight: FontWeight.bold,
      ),
    );

    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
      maxLines: null,
    );

    textPainter.layout(maxWidth: MediaQuery.of(context).size.width);

    final lines = textPainter.computeLineMetrics();
    return lines.length;
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
                    color: Color(0xFFc8ecf3),
                  ),
                  margin: const EdgeInsets.only(bottom: 20, left: 20),
                  height: 23,
                  width: textSize.width + 60,
                ),
                Text(
                  widget.posts.title,
                  style: const TextStyle(
                    fontFamily: 'PublicSans',
                    fontSize: 30,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.none,
                  ),
                  textAlign: TextAlign.start,
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: const BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: Colors.black,
                      width: 3,
                    ),
                  ),
                ),
                child: Image.asset(
                  'assets/images/foot.png',
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                padding: const EdgeInsets.only(
                  left: 15,
                  right: 15,
                  top: 25,
                  bottom: 25
                ),
                child: Text(
                  widget.posts.body,
                  key: const ValueKey('article_text'),
                  maxLines: showFullText ? getLineCount() + 1 : 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontFamily: 'PublicSans',
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.none,
                  ),
                  textAlign: TextAlign.start,
                ),
              ),
              if (!showFullText && getLineCount() > 2)
                Align(
                  alignment: Alignment.center,
                  child: TextButton(
                    onPressed: () {
                      setState(() {
                        showFullText = true;
                        calculateTextSize();
                      });
                    },
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            Container(
                              width: 90,
                              child: Image.asset(
                                'assets/images/fond_afficher_plus.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                            const Text(
                              'Afficher plus',
                              style: TextStyle(
                                fontFamily: 'PublicSans',
                                fontSize: 15,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.none,
                              ),
                              textAlign: TextAlign.start,
                            ),

                          ],
                        ),
                        const Icon(
                          Icons.arrow_drop_down,
                          color: Colors.black,
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
