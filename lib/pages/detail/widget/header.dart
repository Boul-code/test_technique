import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:test_technique/providers/pictures_provider.dart';
import '../../../models/user.dart';
import 'package:provider/provider.dart';

class Header extends StatefulWidget {
  final Users user;

  const Header({Key? key, required this.user}) : super(key: key);

  @override
  _HeaderState createState() => _HeaderState();
}

class _HeaderState extends State<Header> {

  @override
  void initState() {
    super.initState();
    final randomPhotoProvider = Provider.of<PicturesProvider>(context, listen: false);
    randomPhotoProvider.fetchRandomPhotos(1);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text(
            'Retour',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          iconTheme: const IconThemeData(
            color: Colors.black,
          ),
        ),
        Container(
          padding: const EdgeInsets.only(
              top: 15,
              left: 15
          ),
          child: Row(
            children: [
              Consumer<PicturesProvider>(
                builder: (context, randomPhotoProvider, _) {
                  final randomPhotos = randomPhotoProvider.randomPhotos;
                  if (randomPhotos.isNotEmpty) {
                    final randomPhotoIndex = 1 % randomPhotos.length;
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
                          radius: 55,
                        ),
                      ),
                    );
                  } else {
                    return Container(
                      padding: const EdgeInsets.all(2),
                      child: const CircleAvatar(
                        backgroundImage: AssetImage('assets/images/avatar.jpg'),
                        radius: 55,
                      ),
                    );
                  }
                },
              ),
              Container(
                margin: const EdgeInsets.only(
                  left: 25,
                ),
                child: Column(
                  crossAxisAlignment:  CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.user.name,
                      style: const TextStyle(
                        fontFamily: 'PublicSans',
                        fontSize: 25,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.none,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
