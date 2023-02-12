import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sangathan/Dashboard/Screen/notification/cubit/NotificationState.dart';
import '../cubit/NotificationCubit.dart';
import '../widgets/FileTypeIcons.dart';

class CircularScreen extends StatelessWidget {
  const CircularScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              state.error,
              style: GoogleFonts.quicksand(
                  fontWeight: FontWeight.w600, fontSize: 20),
            ),
          );
        }
        return Column(
          children: [
            const Divider(
              color: Color(0xFF979797),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, top: 15),
              child: Row(
                children: [
                  Text(
                    "Today",
                    style: GoogleFonts.quicksand(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: const Color(0xFF2F2F2F)),
                  ),
                  Text(
                    " - Monday, Jan 23",
                    style: GoogleFonts.quicksand(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: const Color(0xFF666666)),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            BlocBuilder<NotificationCubit, NotificationState>(
              builder: (context, state) {
                if (state is NotificationFetchedState) {
                  return Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: cubit.tempModel!.notificationsList.length,
                      itemBuilder: (context, index) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            ListTile(
                              leading: CustomFileIcon(
                                  FileType: cubit.tempModel!
                                      .notificationsList[index].uploadFile),
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "10:30 AM",
                                    style: GoogleFonts.quicksand(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12,
                                        color: const Color(0xFF262626)),
                                  ),
                                  Text(
                                    cubit.tempModel!.notificationsList[index]
                                        .notificationTitle,
                                    style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 13,
                                        color: const Color(0xFF262626)),
                                  ),
                                  const SizedBox(height: 4),
                                ],
                              ),
                              subtitle: Text(
                                cubit.tempModel!.notificationsList[index]
                                    .description,
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 10,
                                    color: const Color(0xFF999999)),
                              ),
                            ),
                            const Divider(
                              endIndent: 20,
                              indent: 20,
                              color: Color(0xFF979797),
                            ),
                          ],
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
      },
    );
  }
}
