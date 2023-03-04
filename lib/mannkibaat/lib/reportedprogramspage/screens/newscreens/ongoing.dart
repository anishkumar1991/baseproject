import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sangathan/Storage/mannkibaat.dart';
import 'package:sangathan/generated/l10n.dart';

import '../../../attendeereviewpage/screens/ReviewPageMain.dart';
import '../../../attendeesformpage/screens/AttendeesFormPage.dart';
import '../../cubit/DashCubit.dart';
import '../../cubit/DashState.dart';
import '../ProgramCard.dart';

class OnGoing extends StatefulWidget {
  const OnGoing({Key? key}) : super(key: key);

  @override
  State<OnGoing> createState() => _OnGoingState();
}

class _OnGoingState extends State<OnGoing>
    with AutomaticKeepAliveClientMixin<OnGoing> {
  @override
  Widget build(BuildContext context) {
    DateTime currentDate = DateTime.now();
    var time = null;
    var temptimeshow;
    String? airedText;
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
              state.error,
              style: GoogleFonts.quicksand(
                  fontWeight: FontWeight.w600, fontSize: 20),
            ),
          );
        }
        if (state is DashGotEventsState) {
          for (var item in state.dashModal.data) {
            DateTime startdate = item.airedDetail.startDateTime;
            DateTime enddate = item.airedDetail.endDateTime;

            if (enddate.isAfter(currentDate) ||
                enddate.isAtSameMomentAs(currentDate) ||
                startdate.isAfter(currentDate) ||
                startdate.isAtSameMomentAs(currentDate)) {
              status = 1;
            }
          }

          return SingleChildScrollView(
            child: Column(
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
                      print("id ${state.dashModal.data[index].id}");
                      return InkWell(
                        onTap: () {
                          if (state.dashModal.data[index].eventHasDetail ==
                              false) {
                            print("start date ${startdate.day}");
                            print("current date ${currentDate.day}");
                            print(startdate.hour);
                            print(currentDate.hour);
                            if (startdate.isAfter(currentDate)) {
                              if (startdate.hour > currentDate.hour && startdate.day >= currentDate.day) {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title:
                                          Text("${S.of(context).upcoming}.."),
                                      content: Text(
                                          "You can edit after ${state.dashModal.data[index].airedDetail.date + " " + state.dashModal.data[index].airedDetail.time}"),
                                      actions: [
                                        TextButton(
                                          style: TextButton.styleFrom(
                                            textStyle: Theme.of(context)
                                                .textTheme
                                                .labelLarge,
                                          ),
                                          child: Text(S.of(context).ok),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                              }     else if (startdate.hour <= currentDate.hour) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => AttendeesFormPage(
                                          eventId: state
                                              .dashModal.data[index].id,
                                        )));
                              }
                              else if (startdate.hour >= currentDate.hour && startdate.day<=currentDate.day) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => AttendeesFormPage(
                                          eventId: state
                                              .dashModal.data[index].id,
                                        )));
                              }
                            }
                            else if (startdate.hour >= currentDate.hour && startdate.day<=currentDate.day) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AttendeesFormPage(
                                        eventId: state
                                            .dashModal.data[index].id,
                                      )));
                            }
                            else if (startdate.hour >= currentDate.hour && startdate.month<currentDate.month) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AttendeesFormPage(
                                        eventId: state
                                            .dashModal.data[index].id,
                                      )));
                            }
                            else if (startdate.hour <= currentDate.hour) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AttendeesFormPage(
                                        eventId: state
                                            .dashModal.data[index].id,
                                      )));
                            }

                          } else {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AttendeeReviewPage(
                                          vidhanSabha:
                                              '${state.dashModal.data[index].eventDetail.ac?.first.name}',
                                          state:
                                              '${state.dashModal.data[index].eventDetail.countryState?.first.name}',
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
                            airedText: (startdate.hour <= currentDate.hour &&
                                    startdate.day == currentDate.day)
                                ? S.of(context).live
                                : (startdate.day >= currentDate.day && startdate.month == currentDate.month)
                                    ? S.of(context).upcoming
                                    : S.of(context).airedon,
                            clickNreport:
                                (state.dashModal.data[index].eventHasDetail ==
                                        false)
                                    ? S.of(context).report
                                    : '${S.of(context).clicktoknowmore} >',
                            id: state.dashModal.data[index].name,
                            date: state.dashModal.data[index].airedDetail.date,
                            time: state.dashModal.data[index].airedDetail.time,

                            //right now I am not fetching images because API is having faulty images.
                            img: state.dashModal.data[index].eventPhoto),
                      );
                    }

                    return const SizedBox();
                  },
                ),
                status == 0
                    ? Padding(
                        padding: const EdgeInsets.only(top: 150),
                        child: Center(
                            child: Text(
                          "कोई रिकॉर्ड उपलब्ध नहीं है",
                          style: GoogleFonts.quicksand(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.w500),
                        )),
                      )
                    : const SizedBox()
              ],
            ),
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
