import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../attendeereviewpage/screens/ReviewPageMain.dart';
import '../../../attendeesformpage/screens/AttendeesFormPage.dart';
import '../../cubit/DashCubit.dart';
import '../../cubit/DashState.dart';
import '../ProgramCard.dart';

class Expired extends StatelessWidget {
  const Expired({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var time = null;
    var temptimeshow;
    final cubit = context.read<DashCubit>();
    cubit.getDashData();

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
          return ListView.builder(
            shrinkWrap: true,
            physics: const ScrollPhysics(),
            itemCount: state.dashModal.data.length,
            itemBuilder: (BuildContext context, int index) {
              // var s = state.dashModal.data[index].airedDetail.endDate;
              // var temp = s.split("th");
              //
              // var s1 = state.dashModal.data[index].airedDetail.date;
              // var temp1 = s1.split("th");
              //
              // ((temp[0] + temp[1].toString() >=
              //         DateFormat("d MMM y")
              //             .format(DateTime.now())
              //             .toString()) ||
              //     (temp1[0] + temp1[1].toString() >=
              //         DateFormat("d MMM y")
              //             .format(DateTime.now())
              //             .toString()));


              return InkWell(
                onTap: () {
                  if (state.dashModal.data[index].eventHasDetail == true) {
                    print(
                        'inside REVIEW statement-->${state.dashModal.data[index].eventDetail.totalAttendees}');
                    print(
                        'Event Detail-->${state.dashModal.data[index].eventDetail}');

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
                              '${state.dashModal.data[index].eventDetail.photo1}',
                            )));
                  } else {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AttendeesFormPage()));
                  }
                },
                child: ProgramCard(
                    id: '${state.dashModal.data[index].id}',
                    date: state.dashModal.data[index].airedDetail.date,
                    time: state.dashModal.data[index].airedDetail.time,

                    //right now I am not fetching images because API is having faulty images.
                    img: state.dashModal.data[index].eventPhoto),
              );

            },
          );
        }

        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
