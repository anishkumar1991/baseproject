import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sangathan/Dashboard/Screen/mannKiBaat/Utils/AppColor.dart';

import '../Utils/DropDown.dart';
import '../Utils/DropDown2.dart';
import 'Content.dart';

class FormPage extends StatefulWidget {
  const FormPage({Key? key}) : super(key: key);

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
        color: Colors.white,
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.only(top: 60, left: 20),
            child: Row(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                    size: 30,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text('जानकारी भरे ',
                    style: GoogleFonts.poppins(
                      textStyle:
                          TextStyle(fontSize: 18, color: AppColor().textcolor5),
                    )),
              ],
            ),
          ),
          const SizedBox(
            height: 21,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 85),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                'विधानसभा :',
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    color: AppColor().textcolor4),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 20, right: 20),
            height: 50,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white),
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
            ),
            child: const DropDown2(),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 85),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                'बूथ :',
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    color: AppColor().textcolor4),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 20, right: 20),
            height: 50,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white),
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
            ),
            child: const DropDown(),
          ),
          const SizedBox(
            height: 40,
          ),
          Container(
            height: 741,
            width: 400,
            decoration: BoxDecoration(
              color: AppColor().textcolor,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 32,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: TextFormField(
                      maxLength: 3,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        labelText: 'व्यक्तियों की संख्या ',
                        labelStyle: TextStyle(color: AppColor().textcolor2),
                        filled: true,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: TextFormField(
                      maxLines: null,
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        labelText: 'स्थान ( कार्यक्रम स्थल का पता ) ',
                        labelStyle: TextStyle(color: AppColor().textcolor2),
                        filled: true,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: TextFormField(
                      textAlign: TextAlign.start,
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        label: const Center(
                          child: Text('विवरण लिखे'),
                        ),
                        floatingLabelAlignment: FloatingLabelAlignment.start,
                        labelStyle: TextStyle(color: AppColor().textcolor2),
                        filled: true,
                        contentPadding: const EdgeInsets.symmetric(vertical: 100),
                        border: const OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 1, color: Colors.black)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  Padding(
                    padding: const EdgeInsets.only(left: 36),
                    child: Text(
                      'फोटो अपलोड करो ',
                      style: GoogleFonts.poppins(
                          fontSize: 16,
                          color: Colors.black54,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      const SizedBox(
                        width: 36,
                      ),
                      GestureDetector(
                        onTap: () {
                          Content(context);
                        },
                        child: DottedBorder(
                          borderType: BorderType.RRect,
                          radius: const Radius.circular(5),
                          color: AppColor().bordercolor,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.white,
                            ),
                            height: 124,
                            width: 133,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset('assets/images/image.png'),
                                const SizedBox(
                                  height: 12,
                                ),
                                Text(
                                  'फोटो यहाँ',
                                  style: TextStyle(
                                    color: AppColor().bordercolor,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                                Text(
                                  'अपलोड करें',
                                  style: TextStyle(
                                    color: AppColor().bordercolor,
                                    decoration: TextDecoration.underline,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      GestureDetector(
                        onTap: () {
                          Content(context);
                        },
                        child: DottedBorder(
                          color: AppColor().bordercolor,
                          borderType: BorderType.RRect,
                          radius: const Radius.circular(5),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5)),
                            height: 124,
                            width: 133,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset('assets/images/image.png'),
                                const SizedBox(
                                  height: 12,
                                ),
                                Text(
                                  'फोटो यहाँ',
                                  style: TextStyle(
                                    color: AppColor().bordercolor,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                                Text(
                                  'अपलोड करें',
                                  style: TextStyle(
                                    color: AppColor().bordercolor,
                                    decoration: TextDecoration.underline,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 39,
          ),
          ElevatedButton(
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                )),
                backgroundColor:
                    MaterialStateProperty.all(AppColor().buttoncolor),
              ),
              onPressed: () {},
              child: Text(
                "सबमिट",
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    color: Colors.white),
              )),
        ]),
      ),
    ));
  }
}
