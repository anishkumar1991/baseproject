import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LanguageContent extends StatelessWidget {
  final String? textcontent;

  const LanguageContent({super.key, @required this.textcontent});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 0,
      margin: const EdgeInsets.symmetric(vertical: 4),
      shadowColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6),
        side: const BorderSide(color: Colors.black, width: 0.15),
      ),
      child: Align(
        alignment: Alignment.topRight,
        child: RadioListTile(
            controlAffinity: ListTileControlAffinity.trailing,
            title: Text(textcontent!),
            value: 0,
            activeColor: Colors.green,
            groupValue: 0,
            onChanged: (value) {
              setState(() {});
            }),
      ),
    );
  }

  void setState(Null Function() param0) {}
}
