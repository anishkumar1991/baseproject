import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sangathan/Dashboard/Screen/homePage/screens/zila_data_page/cubit/zila_data_cubit.dart';
import 'package:sangathan/Values/app_colors.dart';
import 'package:sangathan/Values/icons.dart';
import 'package:sangathan/Values/space_height_widget.dart';
import 'package:sangathan/Values/space_width_widget.dart';
import 'package:sangathan/generated/l10n.dart';
import 'package:sangathan/route/route_path.dart';
import 'package:shimmer/shimmer.dart';

import 'cubit/zila_data_state.dart';

class ZilaDataScreen extends StatefulWidget {
  const ZilaDataScreen(
      {super.key, required this.type, this.id, this.dataLevelId});
  final String? type;
  final int? id;
  final int? dataLevelId;
  @override
  State<ZilaDataScreen> createState() => _ZilaDataScreenState();
}

class _ZilaDataScreenState extends State<ZilaDataScreen> {
  @override
  void initState() {
    context
        .read<ZilaDataCubit>()
        .getEntryData(data: {"level": 4, "unit": 25, "level_name": 348});
    if (widget.id != null) {
      context.read<ZilaDataCubit>().getPartyZila(id: widget.id!);
    }
    print(widget.dataLevelId);
    context.read<ZilaDataCubit>().getFilterOptions(data: {
      "type": "Designation",
      "data_level": widget.dataLevelId.toString(),
      "country_state_id": 3,
      "unit_id": 25,
      "sub_unit_id": 58
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<ZilaDataCubit>();
    return Scaffold(
      body: SafeArea(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(
          children: [
            IconButton(
                splashRadius: 20,
                onPressed: (() {
                  Navigator.pop(context);
                }),
                icon: const Icon(Icons.arrow_back)),
            Text(
              '${widget.type} ${S.of(context).dataEntry}',
              style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  color: AppColor.textBlackColor),
            )
          ],
        ),
        spaceHeightWidget(20),
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      spaceWidthWidget(8),
                      const Icon(
                        Icons.location_on_outlined,
                        color: AppColor.textBlackColor,
                      ),
                      spaceWidthWidget(8),
                      dropdownLocation(),
                    ],
                  ),
                  const Divider(
                    thickness: 1.2,
                    color: AppColor.textBlackColor,
                  ),
                  spaceHeightWidget(13),
                  SizedBox(
                    height: 44,
                    child: BlocConsumer<ZilaDataCubit, ZilaDataState>(
                      listener: (context, state) {
                        if (state is ErrorState) {
                          EasyLoading.showError(state.error);
                        }
                      },
                      builder: (context, state) {
                        if (state is FilterDataFetchedState) {
                          if (state.filterdata.data!.isNotEmpty) {
                            cubit.filterDataList = state.filterdata.data!;
                          }
                        }
                        return ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: cubit.filterDataList.length,
                            itemBuilder: ((context, index) {
                              final data = cubit.filterDataList[index];
                              return InkWell(
                                onTap: (() {
                                  cubit.onTapFilterData(index);
                                }),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                  margin: const EdgeInsets.only(right: 16),
                                  decoration: BoxDecoration(
                                    color: cubit.filterDtaSelectedIndex == index
                                        ? AppColor.buttonOrangeBackGroundColor
                                        : AppColor.orange300Color,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Center(
                                    child: Text(
                                      data.name ?? '',
                                      style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 18,
                                          color: cubit.filterDtaSelectedIndex ==
                                                  index
                                              ? AppColor.white
                                              : AppColor.greyColor),
                                    ),
                                  ),
                                ),
                              );
                            }));
                      },
                    ),
                  ),
                  spaceHeightWidget(20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(S.of(context).entry,
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                          )),
                      Text("${S.of(context).total}:80",
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                              color: AppColor.greyColor))
                    ],
                  ),
                  spaceHeightWidget(10),
                  entryFilterWidget(),
                  spaceHeightWidget(20),
                  entryDetails(cubit)
                ],
              ),
            ),
          ),
        )
      ])),
      floatingActionButton: FloatingActionButton.extended(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          backgroundColor: AppColor.buttonOrangeBackGroundColor,
          onPressed: (() {
            Navigator.pushNamed(context, RoutePath.addEntryScreen,
                arguments: widget.type);
          }),
          icon: const Icon(Icons.add),
          label: Text(
            'Add Entry',
            style: GoogleFonts.roboto(
                fontWeight: FontWeight.w500,
                fontSize: 14,
                color: AppColor.white),
          )),
    );
  }

  BlocListener<ZilaDataCubit, ZilaDataState> entryDetails(ZilaDataCubit cubit) {
    return BlocListener<ZilaDataCubit, ZilaDataState>(
      listener: (context, state) {
        if (state is ErrorState) {
          EasyLoading.showError(state.error);
        }
      },
      child: BlocBuilder<ZilaDataCubit, ZilaDataState>(
        builder: (context, state) {
          if (state is EntryDataFetchedState) {
            if (state.data.data != null) {
              cubit.dataList = state.data.data!.data!;
            }
          }
          if (state is DataFetchingLoadingState) {
            return shimmerWidget();
          }
          return ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: cubit.dataList.length,
              separatorBuilder: ((context, index) => spaceHeightWidget(18)),
              itemBuilder: ((context, index) {
                final data = cubit.dataList[index];
                return Slidable(
                  key: UniqueKey(),
                  endActionPane:
                      ActionPane(motion: const ScrollMotion(), children: [
                    SlidableAction(
                      padding: EdgeInsets.zero,
                      onPressed: ((context) {}),
                      backgroundColor: Colors.green.shade100,
                      foregroundColor: Colors.green.shade900,
                      icon: Icons.verified_user,
                      label: 'Verify',
                    ),
                    SlidableAction(
                      padding: EdgeInsets.zero,
                      onPressed: ((context) {}),
                      backgroundColor: AppColor.white,
                      icon: Icons.edit,
                      label: 'Edit',
                    ),
                    SlidableAction(
                      padding: EdgeInsets.zero,
                      onPressed: ((context) {}),
                      backgroundColor: Colors.red.shade100,
                      foregroundColor: Colors.red.shade600,
                      icon: Icons.delete_outline,
                      label: 'Delete',
                    ),
                  ]),
                  child: Row(
                    children: [
                      ClipRRect(
                          borderRadius: BorderRadius.circular(80),
                          child: Image.network(
                            data.photo ?? '',
                            height: 56,
                            width: 56,
                            fit: BoxFit.cover,
                            errorBuilder: ((context, error, stackTrace) =>
                                Container(
                                  height: 56,
                                  width: 56,
                                  color: AppColor.navyBlue,
                                )),
                          )),
                      spaceWidthWidget(16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              AutoSizeText(
                                data.name ?? '',
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w600,
                                    color: AppColor.textBlackColor),
                              ),
                              spaceWidthWidget(5),
                              Image.asset(
                                AppIcons.verifyIcon,
                                height: 10,
                              )
                            ],
                          ),
                          Text(
                            data.designationName ?? '',
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w500,
                                fontSize: 10,
                                color: AppColor.greyColor),
                          ),
                          Text(
                            "+91- ${data.phone ?? ''}",
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w600,
                                fontSize: 12,
                                color: AppColor.greyColor),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Image.asset(
                        AppIcons.callIcon,
                        height: 20,
                      ),
                      spaceWidthWidget(10)
                    ],
                  ),
                );
              }));
        },
      ),
    );
  }

  Widget shimmerWidget() {
    return ListView.separated(
      separatorBuilder: ((context, index) => spaceHeightWidget(10)),
      itemCount: 10,
      shrinkWrap: true,
      itemBuilder: ((context, index) {
        return Shimmer.fromColors(
          baseColor: AppColor.greyColor.withOpacity(0.3),
          highlightColor: Colors.grey.withOpacity(0.1),
          child: Row(
            children: [
              Container(
                height: 60,
                width: 60,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: Colors.white),
              ),
              spaceWidthWidget(20),
              Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: double.infinity,
                        height: 8.0,
                        color: Colors.white,
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 2.0),
                      ),
                      Container(
                        width: double.infinity,
                        height: 8.0,
                        color: Colors.white,
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 2.0),
                      ),
                      Container(
                        width: 50.0,
                        height: 8.0,
                        color: Colors.white,
                      ),
                    ]),
              ),
              const Spacer(),
              Container(
                height: 20,
                width: 20,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: Colors.white),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget entryFilterWidget() {
    return Container(
      height: 32,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColor.greyColor.withOpacity(0.5))),
      child: IntrinsicHeight(
        child: Row(
          children: [
            Expanded(
              child: Text(
                'नवीन एंट्री',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    color: AppColor.textBlackColor),
              ),
            ),
            Expanded(
              child: Container(
                height: 32,
                color: AppColor.navyBlue400,
                child: Center(
                  child: Text(
                    'पद',
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: AppColor.white),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Text(
                'A to Z',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    color: AppColor.textBlackColor),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget dropdownLocation() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${widget.type}',
            style: GoogleFonts.roboto(
                color: AppColor.greyColor,
                fontWeight: FontWeight.w400,
                fontSize: 14),
          ),
          BlocConsumer<ZilaDataCubit, ZilaDataState>(
            listener: ((context, state) {
              if (state is ErrorState) {
                EasyLoading.showError(state.error);
              }
            }),
            builder: (context, state) {
              final cubit = BlocProvider.of<ZilaDataCubit>(context);
              if (state is PartyZilaSelectedState) {
                cubit.zilaSelected = null;
                cubit.partyzilaList = state.data.data!;
              }
              return DropdownButtonHideUnderline(
                  child: DropdownButton(
                      isDense: true,
                      hint: Text('Select Zila',
                          style: GoogleFonts.roboto(
                              fontWeight: FontWeight.w400,
                              color: AppColor.greyColor,
                              fontSize: 16)),
                      value: cubit.zilaSelected,
                      icon: const Icon(
                        Icons.expand_more,
                        color: AppColor.textBlackColor,
                        size: 24,
                      ),
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          color: AppColor.textBlackColor),
                      isExpanded: true,
                      items: cubit.partyzilaList
                          .map((e) => DropdownMenuItem(
                              value: e,
                              child: Text(
                                e.name ?? '',
                                style: GoogleFonts.roboto(
                                    fontWeight: FontWeight.w400, fontSize: 16),
                              )))
                          .toList(),
                      onChanged: ((value) {
                        cubit.onChnageZila(value);
                      })));
            },
          ),
        ],
      ),
    );
  }
}
