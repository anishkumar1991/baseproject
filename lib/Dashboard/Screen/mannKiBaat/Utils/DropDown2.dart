import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'AppColor.dart';

const List<String> list = <String>['भोपाल', 'Jaipur', 'Panna', 'Patna'];

class DropDown2 extends StatefulWidget {

  const DropDown2({Key? key}) : super(key: key);

  @override
  State<DropDown2> createState() => _DropDown2State();
}

class _DropDown2State extends State<DropDown2> {
  String dropdownValue = list.first;
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField2(
      decoration: InputDecoration(
        fillColor: Colors.white,
         prefixIcon: Image.asset(
        'assets/images/mannkibaat/image2.png',
        height: 20,
        width: 14,
      ),
      ),
      value: dropdownValue,
      onChanged: (String? value) {
        setState(() {
          dropdownValue = value!;
        });
      },
      items: list.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value, style: GoogleFonts.poppins(
              fontWeight: FontWeight.w500,
              fontSize: 16,
              color: AppColor().textcolor3),),

        );
      }).toList(),
    );

  }
}
