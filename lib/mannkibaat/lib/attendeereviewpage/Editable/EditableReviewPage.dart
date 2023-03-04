import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sangathan/mannkibaat/lib/attendeesformpage/screens/AttendeesFormPage.dart';

import '../../../../Values/app_colors.dart';
import '../../attendeesformpage/cubit/FetchCubit.dart';
import '../../utils/backgroundboxdecoration/BoxDecoration.dart';
import '../screens/BoothAddress.dart';
import '../screens/BoothName.dart';
import '../screens/DescriptionSection.dart';
import '../screens/Images.dart';
import '../screens/TotalAttendee.dart';
import '../screens/VidharSabhaStates.dart';
import 'EditableAttendeesFormPage.dart';

class EditableReviewPage extends StatefulWidget {
  final int id;
  final String vidhanSabha;
  final String state;
  final String totalAttendees;
  final String booth;
  final String address;
  final String description;
  final String img1;
  final String img2;

  const EditableReviewPage(
      {Key? key,
      required this.vidhanSabha,
      required this.state,
      required this.totalAttendees,
      required this.booth,
      required this.address,
      required this.description,
      required this.img1,
      required this.img2,
      required this.id})
      : super(key: key);

  @override
  State<EditableReviewPage> createState() => _EditableReviewPage();
}

class _EditableReviewPage extends State<EditableReviewPage> {
  // final GlobalKey<ScaffoldState> _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<FetchCubit>();

    return Scaffold(
      appBar: AppBar(
          backgroundColor: AppColor().appBarColor,
          title: Text("मन की बात",
              style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                  color: AppColor().textColor)),
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back),
            color: Colors.black,
          ),
          automaticallyImplyLeading: false,
          titleSpacing: 0),
      body: Scaffold(
        // key: _key,
        body: Container(
          decoration: BoxDecorationWidget.getBoxDecoration(),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 14),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                          width: 200,
                          child: ListTile(
                            title: Text("समीक्षा",
                                style: GoogleFonts.publicSans(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 20,
                                    color: AppColor().textColor)),
                          )),
                      IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        EditableAttendeesFormPage(
                                          eventId: widget.id,
                                          vidhanSabhaPreFilled:
                                              widget.vidhanSabha,
                                          boothPreFilled: widget.booth,
                                          totalAttendeesPreFilled:
                                              widget.totalAttendees,
                                          img1PreFilled2: widget.img2,
                                          img1PreFilled1: widget.img1,
                                          descriptionPreFilled:
                                              widget.description,
                                          addressPreFilled: widget.address,
                                        )));
                          },
                          icon: const Icon(Icons.edit),
                          color: AppColor().reviewFormTextColor),
                    ],
                  ),
                  ReviewVidhanAndStates(
                    vidhanSabha: widget.vidhanSabha,
                    state: widget.state,
                  ),
                  const SizedBox(height: 0),
                  ReviewTotalAttendee(totalAttendees: widget.totalAttendees),
                  const SizedBox(height: 0),
                  ReviewBoothName(booth: widget.booth),
                  const SizedBox(height: 0),
                  ReviewBoothAddress(boothAddress: widget.address),
                  const SizedBox(height: 0),
                  ReviewDescription(description: widget.description),
                  const SizedBox(height: 10),
                  ReviewImages(img1: widget.img1, img2: widget.img2),
                  const SizedBox(height: 4),
                  // SizedBox(
                  //   width: Constants.buttonSizeBoxWidth,
                  //   height: Constants.buttonSizeBoxHeight,
                  //   child: SubmitButton(onPress: () {
                  //     Navigator.push(
                  //         context,
                  //         MaterialPageRoute(
                  //             builder: (context) => FormSuccess()));
                  //   }),
                  // ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
