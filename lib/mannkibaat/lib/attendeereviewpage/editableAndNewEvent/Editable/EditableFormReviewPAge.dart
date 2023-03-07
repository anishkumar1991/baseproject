import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sangathan/mannkibaat/lib/attendeesformpage/review/cubit/SendEventState.dart';

import '../../../../../Storage/mannkibaat.dart';
import '../../../../../Values/Constants.dart';
import '../../../../../Values/app_colors.dart';
import '../../../attendeesformpage/cubit/FetchCubit.dart';
import '../../../attendeesformpage/review/cubit/SendEventCubit.dart';
import '../../../attendeesformpage/review/screens/BoothAddress.dart';
import '../../../attendeesformpage/review/screens/BoothName.dart';
import '../../../attendeesformpage/review/screens/DescriptionSection.dart';
import '../../../attendeesformpage/review/screens/Images.dart';
import '../../../attendeesformpage/review/screens/TotalAttendee.dart';
import '../../../attendeesformpage/review/screens/VidharSabhaStates.dart';
import '../../../formfillsuccesspage/screens/FormSuccess.dart';
import '../../../utils/backgroundboxdecoration/BoxDecoration.dart';
import '../../../utils/buttons/SubmitButton.dart';



class EditableFormReviewPage extends StatefulWidget {
  final String? totalAttendees;
  final int eventid;
  final String? address;
  final String? description;
  final String img1;
  final String img2;
  final String eventDetailId;

  const EditableFormReviewPage(
      {Key? key,
        this.totalAttendees,
        this.address,
        this.description,
        required this.img1,
        required this.img2,
        required this.eventid, required this.eventDetailId})
      : super(key: key);

  @override
  State<EditableFormReviewPage> createState() => _EditableFormReviewPage();
}

class _EditableFormReviewPage extends State<EditableFormReviewPage> {
  Position? position;
  Position? newPosition;
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    LocationPermission permission;
    final cubit = context.read<FetchCubit>();
    final cubit2 = context.read<SendEventCubit>();

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
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 15),
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
                  const SizedBox(height: 2),
                  ReviewBoothName(booth: cubit.boothname),
                  ReviewTotalAttendee(totalAttendees: widget.totalAttendees),
                  const SizedBox(height: 4),
                  ReviewBoothAddress(boothAddress: widget.address),
                  const SizedBox(height: 8),
                  ReviewDescription(description: widget.description),
                  const SizedBox(height: 10),
                  ReviewImages(img1: widget.img1, img2: widget.img2),
                  const SizedBox(height: 2),
                  SizedBox(
                    width: Constants.buttonSizeBoxWidth,
                    height: Constants.buttonSizeBoxHeight,
                    child: BlocConsumer<SendEventCubit, SendEventState>(
                      listener: (context, state) {
                        if (state is EventSendState) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => FormSuccess(),
                              ));
                        } else if (state is EventErrorState) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(state.error)));
                        }
                      },
                      builder: (context, state) {
                        if (state is EventSendingState) {
                          return const SpinKitFadingCircle(
                            color: AppColor.buttonOrangeBackGroundColor,
                            size: 30,
                          );
                        }
                        return SubmitButton(onPress: () async {
                          print('-------eventDetailsID--->${widget.eventDetailId}');
                          newPosition = await getCurrentPosition();
                          await cubit2.sendEventAgain(
                              MKBStorageService.getUserAuthToken().toString(),
                              cubit.boothid,
                              cubit.boothname,
                              int.parse(widget.totalAttendees.toString()),
                              widget.address,
                              widget.description,
                              widget.eventid,
                              newPosition!.latitude.toString(),
                              newPosition!.longitude.toString(),
                              widget.img1,
                              widget.img2,
                            widget.eventDetailId,
                          );

                        }, textButtonText: 'सबमिट',);
                      },
                    ),
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

  Future<Position> getCurrentPosition() async {
    LocationPermission permission;

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Location permissions denied.")));
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Color(0xFFFF9559),
          content: Text(
              "Location permissions are completely disabled, please enable them by going to the app settings.")));
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }
}
