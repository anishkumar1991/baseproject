import 'package:flutter/material.dart';

import 'ArticleScreen.dart';

class MainCard extends StatelessWidget {
  final String img;
  final String text;
  const MainCard({Key? key, required this.img, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => ArticleScreen()));
      },
      child: Column(
        children: [
          Container(
            height: 150,
            width: 150,
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage(img))),
          ),
          Container(
            child: Text(
              text,
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
            ),
          )
        ],
      ),
    );
  }
}
