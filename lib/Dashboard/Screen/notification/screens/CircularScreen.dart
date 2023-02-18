import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sangathan/Dashboard/Screen/notification/cubit/NotificationState.dart';
import 'package:url_launcher/url_launcher.dart';
import '../cubit/DatePicCubit.dart';
import '../cubit/DatePicState.dart';
import '../cubit/NotificationCubit.dart';
import '../widgets/FileTypeIcons.dart';
import 'package:intl/intl.dart';

class CircularScreen extends StatelessWidget {
  const CircularScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var time = null;
    var temptimeshow;
    final cubit = context.read<NotificationCubit>();
    cubit.fetchNotification();

    return BlocBuilder<NotificationCubit, NotificationState>(
      builder: (context, state) {
        if (state is NotificationFetchingState) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is NotificationErrorState) {
          return Center(
            child: Text(
              "कुछ गलत हुआ.",
              style: GoogleFonts.quicksand(
                  fontWeight: FontWeight.w600, fontSize: 20),
            ),
          );
        }
        if (state is NotificationFetchedState) {
          return Column(
            children: [
              const Divider(
                color: Color(0xFF979797),
              ),
              // Padding(
              //   padding: const EdgeInsets.only(left: 15, top: 15),
              //   child: Row(
              //     children: [
              //       Text(
              //         "Today",
              //         style: GoogleFonts.quicksand(
              //             fontWeight: FontWeight.w600,
              //             fontSize: 14,
              //             color: const Color(0xFF2F2F2F)),
              //       ),
              //       Text(
              //         " - Monday, Jan 23",
              //         style: GoogleFonts.quicksand(
              //             fontWeight: FontWeight.w600,
              //             fontSize: 14,
              //             color: const Color(0xFF666666)),
              //       ),
              //     ],
              //   ),
              // ),
              const SizedBox(height: 10),
              BlocBuilder<NotificationCubit, NotificationState>(
                builder: (context, state) {
                  if (state is NotificationFetchedState) {
                    return Flexible(
                      child: BlocBuilder<DatePicCubit, DatePicState>(
                        builder: (context, state) {
                          if (state is DatePickedStateState) {
                            return ListView.builder(
                              shrinkWrap: true,
                              physics: const ScrollPhysics(),
                              itemCount:
                                  cubit.tempModel!.notificationsList?.length,
                              itemBuilder: (context, index) {
                                var tempdate = cubit
                                    .tempModel!.notificationsList![index].date;
                                var tempdate2 =
                                    tempdate! + " " + "12:23:42.528083";

                                var printdate = DateFormat("d MMMM")
                                    .format(DateTime.parse(tempdate2));

                                var comparedate = DateFormat("d MMMM")
                                    .format(state.datePicked);

                                time = cubit
                                    .tempModel!.notificationsList![index].time;
                                var temptime = time.split(":");

                                if (int.parse(temptime[0]) >= 12) {
                                  if (int.parse(temptime[1]) > 0)
                                    temptimeshow = "PM";
                                } else {
                                  temptimeshow = "AM";
                                }
                                var showtime = temptime[0] +
                                    ":" +
                                    temptime[1] +
                                    " " +
                                    temptimeshow;

                                if (cubit.tempModel!.notificationsList![index]
                                            .sType ==
                                        "circular" &&
                                    printdate == comparedate) {
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ListTile(
                                        leading: CustomFileIcon(
                                            FileType: cubit
                                                .tempModel!
                                                .notificationsList![index]
                                                .uploadFile),
                                        title: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              printdate +
                                                  "," +
                                                  " " +
                                                  showtime.toString(),
                                              style: GoogleFonts.quicksand(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 12,
                                                  color:
                                                      const Color(0xFF262626)),
                                            ),
                                            Text(
                                              cubit
                                                  .tempModel!
                                                  .notificationsList![index]
                                                  .notificationTitle
                                                  .toString(),
                                              style: GoogleFonts.poppins(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 13,
                                                  color:
                                                      const Color(0xFF262626)),
                                            ),
                                            const SizedBox(height: 4),
                                          ],
                                        ),
                                        subtitle: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              cubit
                                                  .tempModel!
                                                  .notificationsList![index]
                                                  .description
                                                  .toString(),
                                              style: GoogleFonts.poppins(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 10,
                                                  color:
                                                      const Color(0xFF999999)),
                                            ),
                                            InkWell(
                                              onTap: () => _onOpen(
                                                  cubit
                                                      .tempModel!
                                                      .notificationsList![index]
                                                      .link
                                                      .toString(),
                                                  context),
                                              child: Text(
                                                cubit
                                                    .tempModel!
                                                    .notificationsList![index]
                                                    .link
                                                    .toString(),
                                                style: GoogleFonts.poppins(
                                                    decoration: TextDecoration
                                                        .underline,
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 10,
                                                    color: Colors.blue),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      const Divider(
                                        endIndent: 20,
                                        indent: 20,
                                        color: Color(0xFF979797),
                                      ),
                                    ],
                                  );
                                } else {
                                  return const SizedBox();
                                }
                              },
                            );
                          }
                          return ListView.builder(
                            shrinkWrap: true,
                            physics: const ScrollPhysics(),
                            itemCount:
                                cubit.tempModel!.notificationsList?.length,
                            itemBuilder: (context, index) {
                              var tempdate = cubit
                                  .tempModel!.notificationsList![index].date;
                              var tempdate2 =
                                  tempdate! + " " + "12:23:42.528083";

                              var printdate = DateFormat("d MMMM")
                                  .format(DateTime.parse(tempdate2));
                              time = cubit
                                  .tempModel!.notificationsList![index].time;
                              var temptime = time.split(":");

                              if (int.parse(temptime[0]) >= 12) {
                                if (int.parse(temptime[1]) > 0)
                                  temptimeshow = "PM";
                              } else {
                                temptimeshow = "AM";
                              }
                              var showtime = temptime[0] +
                                  ":" +
                                  temptime[1] +
                                  " " +
                                  temptimeshow;

                              if (cubit.tempModel!.notificationsList![index]
                                      .sType ==
                                  "circular") {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ListTile(
                                      leading: CustomFileIcon(
                                          FileType: cubit
                                              .tempModel!
                                              .notificationsList![index]
                                              .uploadFile),
                                      title: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            printdate +
                                                "," +
                                                " " +
                                                showtime.toString(),
                                            style: GoogleFonts.quicksand(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 12,
                                                color: const Color(0xFF262626)),
                                          ),
                                          Text(
                                            cubit
                                                .tempModel!
                                                .notificationsList![index]
                                                .notificationTitle
                                                .toString(),
                                            style: GoogleFonts.poppins(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 13,
                                                color: const Color(0xFF262626)),
                                          ),
                                          const SizedBox(height: 4),
                                        ],
                                      ),
                                      subtitle: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            cubit
                                                .tempModel!
                                                .notificationsList![index]
                                                .description
                                                .toString(),
                                            style: GoogleFonts.poppins(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 10,
                                                color: const Color(0xFF999999)),
                                          ),
                                          InkWell(
                                            onTap: () => _onOpen(
                                                cubit
                                                    .tempModel!
                                                    .notificationsList![index]
                                                    .link
                                                    .toString(),
                                                context),
                                            child: Text(
                                              cubit
                                                  .tempModel!
                                                  .notificationsList![index]
                                                  .link
                                                  .toString(),
                                              style: GoogleFonts.poppins(
                                                  decoration:
                                                      TextDecoration.underline,
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 10,
                                                  color: Colors.blue),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    const Divider(
                                      endIndent: 20,
                                      indent: 20,
                                      color: Color(0xFF979797),
                                    ),
                                  ],
                                );
                              } else {
                                return const SizedBox();
                              }
                            },
                          );
                        },
                      ),
                    );
                  }
                  return const Text("fetching");
                },
              ),
            ],
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  Future<void> _onOpen(String link, BuildContext context) async {
    if (await canLaunchUrl(Uri.parse(link))) {
      await launchUrl(Uri.parse(link));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Can't Open"),
        duration: Duration(milliseconds: 70),
      ));
    }
  }
}
