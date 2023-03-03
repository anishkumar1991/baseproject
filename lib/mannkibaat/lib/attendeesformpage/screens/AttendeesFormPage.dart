import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../Values/app_colors.dart';
import '../../Storage/AttendeesFormStorage.dart';
import '../../utils/backgroundboxdecoration/BoxDecoration.dart';
import '../../utils/buttons/SubmitButton.dart';
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
  final totalAttendeesKey = GlobalKey<FormState>();

  TextEditingController totalAttendeesController = TextEditingController();

  TextEditingController addressController = TextEditingController();

  TextEditingController descriptionController = TextEditingController();

  final GlobalKey<ScaffoldState> _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<FetchCubit>();
    cubit.fetchAcId();
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AttendeeFormCubit(),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
            backgroundColor: AppColor().appBarColor,
            title: Text("मन की बात",
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                    color: AppColor().textColor)),
            centerTitle: true,
            leading: IconButton(
              onPressed: (() {
                Navigator.pop(context);
              }),
              icon: const Icon(Icons.arrow_back),
              color: Colors.black,
            ),
            automaticallyImplyLeading: false,
            titleSpacing: 0),
        body: Scaffold(
          key: _key,
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
                      key: totalAttendeesKey,
                      controller: totalAttendeesController,
                      style: TextStyle(color: AppColor().textColor),
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: AppColor().textFieldColor,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(
                                  width: 1, color: AppColor().textFieldColor))),
                      keyboardType: TextInputType.phone,
                      inputFormatters: <TextInputFormatter>[
                        LengthLimitingTextInputFormatter(4),
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                      ],
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter Total Att';
                        }
                        return null;
                      },
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
                  IntrinsicHeight(
                    child: TextFormField(
                        // keyboardType: TextInputType.multiline,
                        minLines: 1,
                        maxLines: 20,
                        controller: addressController,
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
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(150),

                          /// here char limit is 5
                        ],
                        onChanged: (value) {
                          AttendeeStorageService.setaddress(value.toString());
                          print(AttendeeStorageService.getaddress());
                        }),
                  ),
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
                    child: IntrinsicHeight(
                      child: TextFormField(
                          minLines: 1,
                          maxLines: 20,
                          controller: descriptionController,
                          expands: false,
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
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(300),

                            /// here char limit is 5
                          ],
                          onChanged: (value) {
                            AttendeeStorageService.setdescription(
                                value.toString());
                            print(AttendeeStorageService.getdescription());
                          }),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'फोटो अपलोड करें *',
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
                          if (cubit.vidhanSabhaSelected == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text("विधान सभा का चयन करें")));
                          } else if (cubit.boothSelected == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text("बूथ का चयन करें")));
                          } else if (totalAttendeesController
                              .value.text.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text("कुल उपस्थिति संख्या भरें")));
                          } else if ((AttendeeStorageService.getimage1url() ==
                                      null ||
                                  AttendeeStorageService.getimage1url() ==
                                      "") &&
                              (AttendeeStorageService.getimage2url() == null ||
                                  AttendeeStorageService.getimage2url() ==
                                      "")) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text("कृपया 1 फोटो चुनें")));
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
                                                  .getimage1url() ??
                                              " ",
                                          img2: AttendeeStorageService
                                                  .getimage2url() ??
                                              " ",
                                          eventid: widget.eventId,
                                        )));
                          }
                        },
                        textButtonText: 'प्रीव्यू व सबमिट ',
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
