import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../Values/Constants.dart';
import '../../../Storage/AttendeesFormStorage.dart';
import '../../../formfillsuccesspage/screens/FormSuccess.dart';
import '../../../utils/appbar/AppBar.dart';
import '../../../utils/backgroundboxdecoration/BoxDecoration.dart';
import '../../../utils/buttons/SubmitButton.dart';
import '../../../utils/drawer/UserProfileDrawer.dart';
import '../../../values/AppColors.dart';

import '../../cubit/FetchCubit.dart';
import '../cubit/SendEventCubit.dart';
import 'BoothAddress.dart';
import 'BoothName.dart';
import 'DescriptionSection.dart';
import 'Images.dart';
import 'TotalAttendee.dart';
import 'VidharSabhaStates.dart';

class FormReviewPage extends StatefulWidget {
  final String? totalAttendees;
  final int eventid;
  final String? address;
  final String? description;
  final String? img1;
  final String? img2;

  const FormReviewPage(
      {Key? key,
      this.totalAttendees,
      this.address,
      this.description,
      this.img1,
      this.img2,
      required this.eventid})
      : super(key: key);

  @override
  State<FormReviewPage> createState() => _FormReviewPageState();
}

class _FormReviewPageState extends State<FormReviewPage> {
  Position? position;
  Position? newPosition;
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  @override
  void dispose() {
    AttendeeStorageService.storage.erase();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<FetchCubit>();
    final cubit2 = context.read<SendEventCubit>();

    return Scaffold(
      appBar: AppBarWidget.getAppBar(_key, context),
      body: Scaffold(
        key: _key,
        drawer: const UserProfileDrawer(),
        body: Container(
          decoration: BoxDecorationWidget.getBoxDecoration(),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(right: 15),
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
                            Navigator.pop(context);
                          },
                          icon: const Icon(Icons.edit),
                          color: AppColor().reviewFormTextColor),
                    ],
                  ),
                  ReviewVidhanAndStates(
                    vidhanSabha: cubit.vidhansabhaname,
                    state: "Madhya Pradesh",
                  ),
                  const SizedBox(height: 24),
                  ReviewTotalAttendee(totalAttendees: widget.totalAttendees),
                  const SizedBox(height: 24),
                  ReviewBoothName(booth: cubit.boothname),
                  const SizedBox(height: 24),
                  ReviewBoothAddress(boothAddress: widget.address),
                  const SizedBox(height: 24),
                  ReviewDescription(description: widget.description),
                  const SizedBox(height: 24),
                  ReviewImages(img1: widget.img1, img2: widget.img2),
                  const SizedBox(height: 43),
                  SizedBox(
                    width: Constants.buttonSizeBoxWidth,
                    height: Constants.buttonSizeBoxHeight,
                    child: SubmitButton(onPress: () async {
                      LocationPermission permission =
                          await Geolocator.requestPermission();

                      newPosition = await getCurrentPosition();

                      await cubit2.sendEvent(
                          cubit.boothid,
                          cubit.boothname,
                          int.parse(widget.totalAttendees.toString()),
                          widget.address,
                          widget.description,
                          widget.eventid,
                          newPosition!.latitude.toString(),
                          newPosition!.longitude.toString(),
                          widget.img1,
                          widget.img2);

                      Navigator.push(context,MaterialPageRoute(builder: (context) => FormSuccess()));
                    }),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  getCurrentPosition() async {
    position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    print("latitutue ${position!.latitude}");

    print("longitutue ${position!.longitude}");

    return position;
  }
}
