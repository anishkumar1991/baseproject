import 'package:flutter/material.dart';
import 'package:sangathan/Values/icons.dart';

class CardListView extends StatelessWidget {
  const CardListView(
      {super.key,
        required this.onTap,});
  final GestureTapCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        physics:const BouncingScrollPhysics(),
        itemCount: 10,
        scrollDirection: Axis.horizontal,
        itemBuilder: ((context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: onTap,
              child: SizedBox(
                height: 25,
                width: 130,
                child: ClipRRect(
                  borderRadius:  BorderRadius.circular(8),
                  child: Image.asset(
                    AppIcons.tempCardImg,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          );
        }));
  }
}
