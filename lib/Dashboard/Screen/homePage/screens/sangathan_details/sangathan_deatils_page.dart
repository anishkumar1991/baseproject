import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sangathan/Dashboard/Screen/homePage/screens/sangathan_details/cubit/sangathan_detail.state.dart';
import 'package:sangathan/Dashboard/Screen/homePage/screens/sangathan_details/cubit/sangathan_detail_cubit.dart';
import 'package:sangathan/Dashboard/Screen/homePage/screens/zila_data_page/zila_data_screen.dart';
import 'package:sangathan/Values/app_colors.dart';
import 'package:sangathan/Values/icons.dart';
import 'package:sangathan/Values/space_height_widget.dart';
import 'package:sangathan/Values/space_width_widget.dart';
import 'package:sangathan/generated/l10n.dart';
import 'package:sangathan/route/route_path.dart';
import 'package:shimmer/shimmer.dart';

class SangathanDetailsPage extends StatefulWidget {
  const SangathanDetailsPage({super.key});

  @override
  State<SangathanDetailsPage> createState() => _SangathanDetailsPageState();
}

class _SangathanDetailsPageState extends State<SangathanDetailsPage> {
  @override
  void initState() {
    BlocProvider.of<SangathanDetailsCubit>(context).getSangathanDataLevel();
    BlocProvider.of<SangathanDetailsCubit>(context).getAllotedLocations();
    showLocationBottomSheet();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<SangathanDetailsCubit>();
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            spaceHeightWidget(10),
            appbar(),
            spaceHeightWidget(20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                children: [
                  IconButton(
                      splashRadius: 20,
                      onPressed: (() {
                        Navigator.pop(context);
                      }),
                      icon: const Icon(Icons.arrow_back)),
                  Text(
                    S.of(context).sangathan,
                    style: GoogleFonts.quicksand(
                        fontSize: 18, fontWeight: FontWeight.w600),
                  )
                ],
              ),
            ),
            spaceHeightWidget(10),
            sangathanGridView(cubit),
            spaceHeightWidget(24),
            Container(
              padding: const EdgeInsets.all(12),
              width: MediaQuery.of(context).size.width,
              color: const Color(0xFFECECF8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Create Shakti Kendra',
                    style: GoogleFonts.quicksand(
                        fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  Container(
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          gradient: const LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Color(0xFFE6E5FD),
                                Color(0xFFFFE3D3),
                              ])),
                      child: Image.asset(
                        AppIcons.shaktikendraImage,
                        height: 35,
                      ))
                ],
              ),
            ),
            spaceHeightWidget(20),
            sangathanReportCard(),
            spaceHeightWidget(60)
          ],
        ),
      )),
    );
  }

  showLocationBottomSheet() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await showModalBottomSheet(
          enableDrag: false,
          isDismissible: false,
          context: context,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0))),
          builder: (builder) {
            return BlocConsumer<SangathanDetailsCubit, SangathanDetailsState>(
              listener: ((context, state) {
                if (state is ErrorState) {
                  EasyLoading.showError(state.error);
                }
              }),
              builder: (context, state) {
                var cubit = context.read<SangathanDetailsCubit>();
                if (state is LocationFetchedState) {
                  if (state.locationData.data != null) {
                    cubit.locationList = state.locationData.data!.locations!;
                  }
                }
                return SizedBox(
                    height: MediaQuery.of(context).size.height * 0.75,
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          spaceHeightWidget(15),
                          Row(
                            children: [
                              IconButton(
                                  onPressed: (() {
                                    if (cubit.selectedId == null) {
                                      EasyLoading.showError(
                                          S.of(context).pleaseChoosePlace);
                                    } else {
                                      Navigator.pop(context);
                                    }
                                  }),
                                  icon: const Icon(Icons.arrow_back)),
                              spaceWidthWidget(10),
                              Text(
                                S.of(context).pleaseChoosePlace,
                                style: GoogleFonts.quicksand(
                                    fontSize: 18, fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                          spaceHeightWidget(10),
                          Wrap(
                              spacing: 10,
                              runSpacing: 5,
                              children: cubit.locationList
                                  .map((e) => ChoiceChip(
                                        backgroundColor:
                                            AppColor.orange300Color,
                                        selectedColor:
                                            cubit.selectedId == e.countryStateId
                                                ? AppColor
                                                    .buttonOrangeBackGroundColor
                                                : null,
                                        selected: cubit.selectedId ==
                                            e.countryStateId,
                                        label: Text(
                                          e.name ?? '',
                                          style: TextStyle(
                                              color: cubit.selectedId ==
                                                      e.countryStateId
                                                  ? AppColor.white
                                                  : AppColor.textBlackColor),
                                        ),
                                        onSelected: ((value) {
                                          cubit.onSelectLocation(
                                              e.countryStateId!);
                                        }),
                                      ))
                                  .toList()),
                        ],
                      ),
                    ));
              },
            );
          });
    });
  }

  Widget sangathanGridView(SangathanDetailsCubit cubit) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: BlocConsumer<SangathanDetailsCubit, SangathanDetailsState>(
        listener: (context, state) {
          if (state is ErrorState) {
            EasyLoading.showError(state.error);
          }
        },
        builder: (context, state) {
          if (state is DataLevelFetchedState) {
            if (state.data.data != null) {
              cubit.sangathanDataList = state.data.data!;
            }
          } else if (state is LoadingState) {
            return Shimmer.fromColors(
              baseColor: AppColor.greyColor.withOpacity(0.3),
              highlightColor: Colors.grey.withOpacity(0.1),
              child: GridView.builder(
                  shrinkWrap: true,
                  itemCount: 9,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 33,
                      mainAxisSpacing: 16),
                  itemBuilder: ((context, index) {
                    return Container(
                      height: MediaQuery.of(context).size.height * 0.2,
                      width: MediaQuery.of(context).size.width * 0.2,
                      decoration: BoxDecoration(
                          color: AppColor.white,
                          borderRadius: BorderRadius.circular(20)),
                    );
                  })),
            );
          }
          return cubit.sangathanDataList.isNotEmpty
              ? GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: cubit.sangathanDataList.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 33,
                      mainAxisSpacing: 16),
                  itemBuilder: ((context, index) {
                    final data = cubit.sangathanDataList[index];
                    return InkWell(
                      onTap: (() {
                        // Navigator.pushNamed(context, RoutePath.addEntryScreen,
                        //     arguments: data[index]['text']);

                        Navigator.pushNamed(context, RoutePath.zilaDataPage,
                            arguments: ZilaDataScreen(
                              type: data.name,
                              id: cubit.selectedId,
                            ));
                      }),
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            gradient: const LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  Color(0xFFE6E5FD),
                                  Color(0xFFFFE3D3),
                                ])),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            data.iconUrl != null
                                ? Image.network(
                                    data.iconUrl!,
                                    height: 32,
                                  )
                                : const SizedBox.shrink(),
                            spaceHeightWidget(4),
                            FittedBox(
                              child: Text(
                                data.name!,
                                style: GoogleFonts.quicksand(
                                    fontSize: 10, fontWeight: FontWeight.w600),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  }))
              : Center(
                  child: Text(S.of(context).noOrganizationsAvailable,
                      style: GoogleFonts.quicksand(
                          fontSize: 20, fontWeight: FontWeight.w400)));
        },
      ),
    );
  }

  Container sangathanReportCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: AppColor.orange100,
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Sangathan Reports',
              style: GoogleFonts.quicksand(
                  color: AppColor.purpleColor,
                  fontSize: 20,
                  fontWeight: FontWeight.w600),
            ),
            spaceHeightWidget(20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                customColumnWidget(title: '543', subtitle: 'Lok Sabha'),
                customColumnWidget(title: '994', subtitle: 'Zila'),
                customColumnWidget(title: '4111', subtitle: 'Vidhan Sabha  '),
              ],
            ),
            spaceHeightWidget(28),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                customColumnWidget(title: '15710', subtitle: 'Mandal'),
                customColumnWidget(title: '44210', subtitle: 'Shaktikendra'),
                customColumnWidget(title: '10,50,558', subtitle: 'Booth'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Column customColumnWidget({required String title, required String subtitle}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          title,
          textAlign: TextAlign.center,
          style: GoogleFonts.quicksand(
              color: AppColor.textBlackColor,
              fontSize: 16,
              fontWeight: FontWeight.w700),
        ),
        spaceHeightWidget(4),
        Text(
          subtitle,
          style: GoogleFonts.quicksand(
              color: AppColor.greyColor,
              fontSize: 12,
              fontWeight: FontWeight.w600),
        )
      ],
    );
  }

  Widget appbar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Stack(
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: AppColor.buttonOrangeBackGroundColor,
                child: Text(
                  'A',
                  style: GoogleFonts.quicksand(
                      color: AppColor.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w700),
                ),
              ),
              spaceWidthWidget(16),
              Text(
                'Namaskar Anirudh ji',
                style: GoogleFonts.quicksand(
                    color: AppColor.textBlackColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w600),
              ),
              const Spacer(),
              Image.asset(
                AppIcons.customerService,
                height: 24,
              ),
            ],
          ),
          Positioned(
            left: 30,
            top: 10,
            child: Container(
              padding: const EdgeInsets.all(6),
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, color: AppColor.white),
              child: Image.asset(
                AppIcons.drawerIcon,
                height: 7,
              ),
            ),
          )
        ],
      ),
    );
  }
}
