import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sangathan/Storage/mannkibaat.dart';
import '../../../../../Storage/user_storage_service.dart';
import '../../../attendeereviewpage/screens/ReviewPageMain.dart';
import '../../../attendeesformpage/screens/AttendeesFormPage.dart';
import '../../../generateauthtoken/cubit/SendCubit.dart';
import '../../cubit/DashCubit.dart';
import '../../cubit/DashState.dart';
import '../ProgramCard.dart';

class OnGoing extends StatefulWidget {
  const OnGoing({Key? key}) : super(key: key);

  @override
  State<OnGoing> createState() => _OnGoingState();
}

class _OnGoingState extends State<OnGoing> {
  @override
  Widget build(BuildContext context) {
    DateTime currentDate = DateTime.now();
    var time = null;
    var temptimeshow;
    int status = 0;
    final cubit = context.read<DashCubit>();
    cubit.getDashData(MKBStorageService.getUserAuthToken().toString());

    return BlocBuilder<DashCubit, DashStates>(
      builder: (context, state) {
        if (state is DashLoadingState) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is DashErrorState) {
          return Center(
            child: Text(
              "कुछ गलत हुआ.",
              style: GoogleFonts.quicksand(
                  fontWeight: FontWeight.w600, fontSize: 20),
            ),
          );
        }
        if (state is DashGotEventsState) {
          return Column(
            children: [
              const Divider(
                color: Color(0xFF979797),
              ),
              const SizedBox(height: 10),
              ListView.builder(
                shrinkWrap: true,
                physics: const ScrollPhysics(),
                itemCount: state.dashModal.data.length,
                itemBuilder: (BuildContext context, int index) {
                  DateTime startdate =
                      state.dashModal.data[index].airedDetail.startDateTime;
                  DateTime enddate =
                      state.dashModal.data[index].airedDetail.endDateTime;

                  if (enddate.isAfter(currentDate) ||
                      enddate.isAtSameMomentAs(currentDate) ||
                      startdate.isAfter(currentDate) ||
                      startdate.isAtSameMomentAs(currentDate)) {
                    status = 1;
                    return InkWell(
                      onTap: () {
                        if (state.dashModal.data[index].eventHasDetail ==
                            false) {
                          print(
                              'inside REVIEW statement-->${state.dashModal.data[index].eventDetail.totalAttendees}');
                          print(
                              'Event Detail-->${state.dashModal.data[index].eventDetail}');

                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AttendeesFormPage(
                                        eventId: state.dashModal.data[index].id,
                                      )));
                        } else {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AttendeeReviewPage(
                                        vidhanSabha:
                                            '${state.dashModal.data[index].eventDetail.ac?.first.name}',
                                        state:
                                            '${state.dashModal.data[index].eventDetail.countryStateRef?.first.name}',
                                        totalAttendees:
                                            '${state.dashModal.data[index].eventDetail.totalAttendees}',
                                        booth:
                                            '${state.dashModal.data[index].eventDetail.location?.first.name}',
                                        address:
                                            '${state.dashModal.data[index].eventDetail.address}',
                                        description:
                                            '${state.dashModal.data[index].eventDetail.description}',
                                        img1:
                                            '${state.dashModal.data[index].eventDetail.photo1}',
                                        img2:
                                            '${state.dashModal.data[index].eventDetail.photo2}',
                                      )));
                        }
                      },
                      child: ProgramCard(
                          id: '${state.dashModal.data[index].id}',
                          date: state.dashModal.data[index].airedDetail.date,
                          time: state.dashModal.data[index].airedDetail.time,

                          //right now I am not fetching images because API is having faulty images.
                          img: state.dashModal.data[index].eventPhoto),
                    );
                  }
                },
              ),
              // status == 0
              //     ? Center(
              //         child: Text(
              //         "कोई रिकॉर्ड उपलब्ध नहीं है",
              //         style: GoogleFonts.quicksand(
              //             color: Colors.black,
              //             fontSize: 20,
              //             fontWeight: FontWeight.w500),
              //       ))
              //     : const SizedBox(),
            ],
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
