import 'package:flutter/material.dart';

class ContentCard extends StatefulWidget {
  final String title;
  final String views;
  final String img;

  const ContentCard(
      {Key? key, required this.title, required this.views, required this.img})
      : super(key: key);

  @override
  State<ContentCard> createState() => _ContentCardState();
}

class _ContentCardState extends State<ContentCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 169,
      width: 117,
      child: Card(
        elevation: 4,
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Stack(
          children: [
            Positioned(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.network(
                  widget.img,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
                bottom: 1,
                left: 8,
                child: Text(
                  widget.title,
                  style: TextStyle(
                      fontFamily: 'Tw Cen Mt',
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w400),
                )),
            Positioned(
                bottom: 20,
                left: 8,
                child: Text(widget.views,
                    style: TextStyle(
                        fontFamily: 'Tw Cen Mt',
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        color: Colors.white))),
          ],
        ),
      ),
    );
  }
}
