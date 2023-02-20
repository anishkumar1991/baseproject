import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:sangathan/Dashboard/Screen/homePage/widget/MannKiBaatCard.dart';
import 'package:sangathan/Dashboard/Screen/homePage/widget/WhatsappCardWidget.dart';
import 'package:sangathan/Dashboard/Screen/homePage/widget/pravas_card_widget.dart';
import 'package:sangathan/Dashboard/Screen/homePage/widget/sangathan_card_widget.dart';
import 'package:sangathan/Values/app_colors.dart';
import 'package:sangathan/Values/icons.dart';
import 'package:sangathan/Values/size_config.dart';
import 'package:sangathan/route/route_path.dart';

import '../notification/screens/NotificatioMainScreen.dart';
import '../whatsapp/screens/WhatsappScreen.dart';
import 'cubit/home_page_cubit.dart';
import 'cubit/home_page_state.dart';
import '../../../splash_screen/cubit/user_profile_cubit.dart';
import 'widget/custom_drawer_widget.dart';
import 'package:google_fonts/google_fonts.dart';

final homePageScaffoldGlobalKey = GlobalKey<ScaffoldState>();

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController searchTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    SizeConfig().getCurrentOrientation(context);
    context.read<HomePageCubit>().getClientAppLists();
    return Scaffold(
      key: homePageScaffoldGlobalKey,
      // drawer: const CustomDrawerWidget(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: (() {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return const NotificationMainScreen();
                        },
                      ));
                    }),
                    child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColor.greyColor.withOpacity(0.1)),
                        // child: Image.asset(
                        //   AppIcons.notification,
                        //   height: 10,
                        //   color: AppColor.greyColor,
                        // ),
                        child: const Icon(
                          Icons.notifications,
                          color: AppColor.greyColor,
                          size: 20,
                        )),
                  ),
                  Image.asset(
                    AppIcons.sangathanLogo,
                    height: 55,
                    width: 55,
                    fit: BoxFit.contain,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, RoutePath.profileScreen);
                    },
                    child: Container(
                      height: 42,
                      width: 42,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: AppColor.dividerColor)),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(350),
                        child: userProfileModel.data?.avatar != null &&
                                userProfileModel.data?.avatar != ''
                            ? Image.network(
                                userProfileModel.data?.avatar ?? '',
                                fit: BoxFit.cover,
                                errorBuilder: (BuildContext context,
                                    Object exception, StackTrace? stackTrace) {
                                  return const Icon(Icons.person, size: 25);
                                },
                                loadingBuilder: (BuildContext context,
                                    Widget child,
                                    ImageChunkEvent? loadingProgress) {
                                  if (loadingProgress == null) {
                                    return child;
                                  }
                                  return Center(
                                    child: CircularProgressIndicator(
                                      value:
                                          loadingProgress.expectedTotalBytes !=
                                                  null
                                              ? loadingProgress
                                                      .cumulativeBytesLoaded /
                                                  loadingProgress
                                                      .expectedTotalBytes!
                                              : null,
                                    ),
                                  );
                                },
                              )
                            : Container(
                                color: AppColor.white,
                                child: Image.asset(AppIcons.sangathanLogo)),
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              // Container(
              //   padding: const EdgeInsets.all(10),
              //   decoration: BoxDecoration(
              //       border: Border.all(
              //           color: AppColor.borderColor.withOpacity(0.5)),
              //       borderRadius: BorderRadius.circular(25)),
              //   child: Row(
              //     children: [
              //       Image.asset(
              //         AppIcons.searchicon,
              //         height: 17,
              //         width: 17,
              //       ),
              //       const SizedBox(
              //         width: 5,
              //       ),
              //       Expanded(
              //         flex: 3,
              //         child: SizedBox(
              //           height: 25,
              //           width: double.infinity,
              //           child: TextField(
              //             controller: searchTextController,
              //             decoration: InputDecoration(
              //                 contentPadding: const EdgeInsets.all(8),
              //                 border: InputBorder.none,
              //                 hintText: S.of(context).viewToursEvents,
              //                 hintStyle: GoogleFonts.poppins(
              //                     color: AppColor.borderColor, fontSize: 14)),
              //           ),
              //         ),
              //       ),
              //       const Spacer(),
              //       InkWell(
              //         onTap: (() {}),
              //         child: Image.asset(
              //           AppIcons.micicon,
              //           height: 18,
              //           width: 14,
              //           fit: BoxFit.cover,
              //         ),
              //       )
              //     ],
              //   ),
              // ),
              // const SizedBox(
              //   height: 20,
              // ),
              Expanded(
                  child: SingleChildScrollView(
                child: BlocListener<HomePageCubit, HomePageState>(
                  listener: (context, state) {
                    if (state is ClientAppListsFailedState) {
                      EasyLoading.showError(state.errorMsg);
                    }
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// Sangathan  card widget
                      BlocBuilder<HomePageCubit, HomePageState>(
                        builder: (context, state) {
                          if (state is ClientAppListsSuccessState) {
                            if (state.clientAppListsModel.sections != null) {
                              for (var item
                                  in state.clientAppListsModel.sections!) {
                                if (item.type == "app_cards") {
                                  if (item.data != null) {
                                    for (var innerItem in item.data!) {
                                      if (innerItem.name == "Data Entry") {
                                        return GestureDetector(
                                            onTap: (() {
                                              Navigator.pushNamed(
                                                  context,
                                                  RoutePath
                                                      .sangathanDetailsScreen);
                                            }),
                                            child: SngathanCardWidget(
                                                clientId: innerItem.clientId
                                                    .toString()));
                                      }
                                    }
                                  }
                                }
                              }
                            }
                          }
                          return const SizedBox();
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),

                      ///mann ki baat widget

                      BlocBuilder<HomePageCubit, HomePageState>(
                        builder: (context, state) {
                          if (state is ClientAppListsSuccessState) {
                            if (state.clientAppListsModel.sections != null) {
                              for (var item
                                  in state.clientAppListsModel.sections!) {
                                if (item.type == "carousel") {
                                  if (item.data != null) {
                                    for (var innerItem in item.data!) {
                                      if (innerItem.actionUrl!
                                              .contains("mannkibaat") ==
                                          true) {
                                        return MannKiBaatCard(
                                            mannkibaatAuthToken:
                                                innerItem.actionUrl);
                                      }
                                    }
                                  }
                                }
                              }
                            }
                          }
                          return const SizedBox();
                        },
                      ),

                      /// whatsapp card widget
                      // const SizedBox(
                      //   height: 20,
                      // ),
                      // const WhatsappCardWidget(),

                      /// pravas card widget
                      // const SizedBox(
                      //   height: 20,
                      // ),
                      // const PravasCardWidget(),
                      // const SizedBox(
                      //   height: 20,
                      // ),
                      // const SizedBox(
                      //   height: 14,
                      // ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: [
                      //     Text(
                      //       S.of(context).myEvent,
                      //       style: const TextStyle(
                      //           fontFamily: 'Tw Cen MT',
                      //           fontSize: 20,
                      //           fontWeight: FontWeight.w400),
                      //     ),
                      //     Text(
                      //       S.of(context).seeAll,
                      //       style: const TextStyle(
                      //         fontFamily: 'Tw Cen MT',
                      //         fontSize: 20,
                      //         fontWeight: FontWeight.w400,
                      //         color: AppColor.blueTextColor,
                      //       ),
                      //     )
                      //   ],
                      // ),
                      // const SizedBox(
                      //   height: 10,
                      // ),
                      // SizedBox(
                      //     height: 270,
                      //     child: EventListView(
                      //       onTap: (() {}),
                      //       title: 'Mann ki Baat',
                      //       subtitle: '97th Edition',
                      //       date: 'On 29th Jan 2023',
                      //     )),
                      // const SizedBox(
                      //   height: 10,
                      // ),
                      //
                      // /// Meeting card widget
                      // const MeetingCard(),
                      const SizedBox(
                        height: 80,
                      )
                    ],
                  ),
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
