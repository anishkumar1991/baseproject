import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Storage/AttendeesFormStorage.dart';
import '../../attendeereviewpage/screens/ReviewPageMain.dart';
import '../../utils/appbar/AppBar.dart';
import '../../utils/backgroundboxdecoration/BoxDecoration.dart';
import '../../utils/buttons/SubmitButton.dart';
import '../../utils/drawer/UserProfileDrawer.dart';
import '../../values/AppColors.dart';
import '../../values/Constants.dart';
import '../cubit/AttendeeFormCubit.dart';
import '../cubit/FetchCubit.dart';
import '../review/screens/ReviewPageMain.dart';
import 'DropDownScreen.dart';
import 'ImageUploadBox.dart';

class AttendeesFormPage extends StatefulWidget {
  final int eventId;

  const AttendeesFormPage({Key? key, required this.eventId}) : super(key: key);

  @override
  State<AttendeesFormPage> createState() => _AttendeesFormPageState();
}

class _AttendeesFormPageState extends State<AttendeesFormPage> {
  TextEditingController totalAttendeesController = TextEditingController();

  TextEditingController addressController = TextEditingController();

  TextEditingController descriptionController = TextEditingController();

  final GlobalKey<ScaffoldState> _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AttendeeFormCubit(),
        ),
      ],
      child: Scaffold(
        appBar: AppBarWidget.getAppBar(_key, context),
        body: Scaffold(
          key: _key,
          drawer: const UserProfileDrawer(),
          body: Container(
            decoration: BoxDecorationWidget.getBoxDecoration(),
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 14,
                  left: Constants.paddingLeft,
                  right: Constants.paddingRight),
              child: SingleChildScrollView(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'विवरण दर्ज करें',
                    style: GoogleFonts.publicSans(
                        fontSize: 20,
                        color: AppColor().textColor,
                        fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 25),
                  const DropDown(),
                  const SizedBox(height: 20),
                  Text(
                    'कुल उपस्थित *',
                    style: GoogleFonts.publicSans(
                        fontSize: 16,
                        color: AppColor().textColor,
                        fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                      controller: totalAttendeesController,
                      style: TextStyle(color: AppColor().textColor),
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: AppColor().textFieldColor,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(
                                  width: 1, color: AppColor().textFieldColor))),
                      keyboardType: const TextInputType.numberWithOptions(
                        signed: false,
                      ),
                      onChanged: (value) {
                        AttendeeStorageService.settotalAttendees(
                            value.toString());
                        print(AttendeeStorageService.gettotalAttendees());
                      }),
                  const SizedBox(height: 20),
                  Text(
                    'पता',
                    style: GoogleFonts.publicSans(
                        fontSize: 16,
                        color: AppColor().textColor,
                        fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                      controller: addressController,
                      style: TextStyle(color: AppColor().textColor),
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: AppColor().textFieldColor,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(
                                  width: 1, color: AppColor().textFieldColor))),
                      keyboardType: TextInputType.name,
                      onChanged: (value) {
                        AttendeeStorageService.setaddress(value.toString());
                        print(AttendeeStorageService.getaddress());
                      }),
                  const SizedBox(height: 15),
                  Text(
                    'विवरण',
                    style: GoogleFonts.publicSans(
                        fontSize: 16,
                        color: AppColor().textColor,
                        fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 90,
                    child: TextFormField(
                        controller: descriptionController,
                        expands: true,
                        maxLines: null,
                        minLines: null,
                        style: TextStyle(color: AppColor().textColor),
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: AppColor().textFieldColor,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(
                                    width: 1,
                                    color: AppColor().textFieldColor))),
                        keyboardType: TextInputType.name,
                        onChanged: (value) {
                          AttendeeStorageService.setdescription(
                              value.toString());
                          print(AttendeeStorageService.getdescription());
                        }),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'तश्वीरें अपलोड करें *',
                    style: GoogleFonts.publicSans(
                        fontSize: 16,
                        color: AppColor().textColor,
                        fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(height: 10),
                  ImageBox(),
                  const SizedBox(height: 25),
                  Align(
                    alignment: Alignment.center,
                    child: SizedBox(
                      height: Constants.buttonSizeBoxHeight,
                      width: Constants.buttonSizeBoxWidth,
                      child: SubmitButton(
                        onPress: () {

                          if (AttendeeStorageService.getimage1url() == null &&
                              AttendeeStorageService.getimage2url() == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content:
                                        Text("Please Select Atleast 1 Image")));
                          } else {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => FormReviewPage(
                                          totalAttendees:
                                              totalAttendeesController.text,
                                          address: addressController.text,
                                          description:
                                              descriptionController.text,
                                          img1: AttendeeStorageService
                                                  .getimage1url()
                                              .toString(),
                                          img2: AttendeeStorageService
                                                  .getimage2url()
                                              .toString(),
                                          eventid: widget.eventId,
                                        )));
                          }
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 30)
                ],
              )),
            ),
          ),
        ),
      ),
    );
  }
}
