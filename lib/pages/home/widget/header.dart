import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';

class HeaderSection extends StatelessWidget {
  const HeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top,
        left: 10,
        right: 10,
      ),

      child: Row(
        children: [
          Column(
            children: [
              Container(
                child: DottedBorder(
                  borderType: BorderType.Circle,
                  strokeWidth: 2,
                  color: Colors.black,
                  dashPattern: const [8, 4],
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    child : const CircleAvatar(
                      backgroundImage: AssetImage('assets/images/avatar.jpg'),
                      radius: 55,
                    ),
                  )
                ),
              )
            ],
          ),
          Container(
            margin: const EdgeInsets.only(
              left: 15,
            ),
            child: const Column(
                crossAxisAlignment:  CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Alexandre Boul',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text('@Alexandre',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(left: 20),
              child: Align(
                alignment: Alignment.center,
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final iconSize = constraints.maxWidth * 0.5;
                    return Column(
                      children: [
                        Container(
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
                          child: FloatingActionButton(
                            backgroundColor: const Color(0xFF70CDDE),
                            onPressed: () {
                              print('Bouton d\'édition cliqué');
                            },
                            child: Icon(
                              Icons.edit,
                              size: iconSize,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
