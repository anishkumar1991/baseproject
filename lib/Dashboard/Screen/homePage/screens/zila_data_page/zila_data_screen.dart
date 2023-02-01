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
import 'package:sangathan/storage/user_storage_service.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../AddEntry/Screen/add_entry_screen.dart';
import '../../../../../AddEntry/cubit/add_entry_cubit.dart';
import 'cubit/zila_data_state.dart';
import 'network/model/data_unit_model.dart';

class ZilaDataScreen extends StatefulWidget {
  const ZilaDataScreen(
      {super.key, required this.type, this.countryStateId, this.dataLevelId});

  final String? type;
  final int? countryStateId;
  final int? dataLevelId;

  @override
  State<ZilaDataScreen> createState() => _ZilaDataScreenState();
}

class _ZilaDataScreenState extends State<ZilaDataScreen> {
  @override
  void initState() {
    context.read<ZilaDataCubit>().getPartyZila(
        id: widget.countryStateId ??
            StorageService.userData!.user!.countryStateId!);
    print('data_leve${widget.dataLevelId}');
    print('country_state_id${widget.countryStateId}');
    context.read<ZilaDataCubit>().getUnitData(data: {
      "type": "Unit",
      "data_level": widget.dataLevelId,
      "country_state_id":
          widget.countryStateId ?? StorageService.userData?.user?.countryStateId
    });
    print('unitId=${context.read<ZilaDataCubit>().unitId}');

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
                  dataUnit(cubit),
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
            context.read<AddEntryCubit>().cleanAllVariableData();
            Navigator.pushNamed(context, RoutePath.addEntryScreen,
                arguments: AddEntryPage(
                  type: widget.type!,
                  leaveId: widget.dataLevelId ?? 0,
                  unitId: cubit.unitId,
                  subUnitId: cubit.subUnitId,
                  countryStateId: widget.countryStateId,
                  personData: null,
                ));
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

  SizedBox dataUnit(ZilaDataCubit cubit) {
    return SizedBox(
      height: 44,
      child: BlocConsumer<ZilaDataCubit, ZilaDataState>(
        listener: (context, state) {
          if (state is ErrorState) {
            EasyLoading.showError(state.error);
          }
        },
        builder: (context, state) {
          if (state is UnitDataFetchedState) {
            if (state.dataUnit.data!.isNotEmpty) {
              cubit.dataUnitList = state.dataUnit.data!;
              cubit.unitId = cubit.dataUnitList.first.id;
              print('first unit id=${cubit.unitId}');
              context.read<ZilaDataCubit>().getEntryData(data: {
                "level": widget.dataLevelId,
                "unit": cubit.unitId,

                /// TODO: level_name need to make dynamic
                "level_name": 348
              });
              cubit.name =
                  List.generate(cubit.dataUnitList.length, (index) => null);
            }
          }
          if (state is LoadingState) {
            return Shimmer.fromColors(
                baseColor: AppColor.greyColor.withOpacity(0.3),
                highlightColor: Colors.grey.withOpacity(0.1),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(
                        3,
                        (index) => Container(
                              margin: const EdgeInsets.only(right: 20),
                              height: 30,
                              width: 140,
                              color: AppColor.white,
                            )).toList(),
                  ),
                ));
          }
          return ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: cubit.dataUnitList.length,
              itemBuilder: ((context, index) {
                final data = cubit.dataUnitList[index];
                if (cubit.name[index] == null) {
                  cubit.name[index] = SubUnits(
                      name: data.name, id: data.id, iconUrl: data.iconUrl);
                }

                return InkWell(
                  onTap: (() async {
                    cubit.onTapFilterData(index: index, id: data.id ?? 0);
                    await context.read<ZilaDataCubit>().getEntryData(data: {
                      "level": widget.dataLevelId,
                      "unit": cubit.unitId,

                      ///TODO: Level name is static need to dynamic
                      "level_name": 348
                    });
                  }),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    margin: const EdgeInsets.only(right: 16),
                    decoration: BoxDecoration(
                      color: cubit.filterDtaSelectedIndex == index
                          ? AppColor.buttonOrangeBackGroundColor
                          : AppColor.orange300Color,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          cubit.name[index]?.name ?? '',
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w500,
                              fontSize: 18,
                              color: cubit.filterDtaSelectedIndex == index
                                  ? AppColor.white
                                  : AppColor.greyColor),
                        ),
                        data.subUnits?.isEmpty ?? false
                            ? const SizedBox.shrink()
                            : PopupMenuButton(
                                enabled: cubit.filterDtaSelectedIndex == index,
                                splashRadius: 3,
                                initialValue: cubit.name[index],
                                icon: Icon(
                                  Icons.arrow_drop_down,
                                  color: cubit.filterDtaSelectedIndex == index
                                      ? AppColor.white
                                      : AppColor.greyColor,
                                ),
                                itemBuilder: ((context) {
                                  return data.subUnits!
                                      .map((e) => PopupMenuItem(
                                          value: e, child: Text(e.name ?? '')))
                                      .toList();
                                }),
                                onSelected: ((value) {
                                  cubit.onChangeUnitData(
                                      value, value.id, index);
                                }),
                              )
                      ],
                    ),
                  ),
                );
              }));
        },
      ),
    );
  }

  Widget entryDetails(ZilaDataCubit cubit) {
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
          return cubit.dataList.isEmpty
              ? Center(
                  heightFactor: MediaQuery.of(context).size.height * 0.02,
                  child: Text(
                    S.of(context).noDataAvailable,
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: AppColor.black),
                  ))
              : ListView.separated(
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
                          backgroundColor: AppColor.greenshade100,
                          foregroundColor: AppColor.greenshade900,
                          icon: Icons.verified_user,
                          label: S.of(context).verified,
                        ),
                        SlidableAction(
                          padding: EdgeInsets.zero,
                          onPressed: ((context) {
                            print(data.toJson());
                            context
                                .read<AddEntryCubit>()
                                .cleanAllVariableData();
                            Navigator.pushNamed(
                                context, RoutePath.addEntryScreen,
                                arguments: AddEntryPage(
                                  type: widget.type!,
                                  leaveId: widget.dataLevelId ?? 0,
                                  unitId: cubit.unitId,
                                  subUnitId: cubit.subUnitId,
                                  countryStateId: widget.countryStateId,
                                  personData: data.toJson(),
                                ));
                          }),
                          backgroundColor: AppColor.white,
                          icon: Icons.edit,
                          label: S.of(context).edit,
                        ),
                        SlidableAction(
                          padding: EdgeInsets.zero,
                          onPressed: ((context) {}),
                          backgroundColor: AppColor.redShade100,
                          foregroundColor: AppColor.redShade600,
                          icon: Icons.delete_outline,
                          label: S.of(context).delete,
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
                                      child: const Icon(
                                        Icons.person,
                                        color: AppColor.white,
                                        size: 28,
                                      ),
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
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
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
                          spaceWidthWidget(4)
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
                S.of(context).newEntry,
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
                    S.of(context).post,
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
                      hint: Text('Select ${widget.type}',
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
