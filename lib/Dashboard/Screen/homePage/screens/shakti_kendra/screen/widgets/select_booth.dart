import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sangathan/Dashboard/Screen/homePage/screens/shakti_kendra/screen/cubit/edit_shakti_kendr_cubit.dart';
import 'package:sangathan/Values/space_width_widget.dart';
import 'package:sangathan/common/common_button.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../../../Values/app_colors.dart';
import '../../../../../../../Values/space_height_widget.dart';
import '../../../../../../../generated/l10n.dart';
import '../../network/model/shakti_kendr_model.dart' as shaktiKendr;

class SelectBooth extends StatelessWidget {
  EditShaktiKendrCubit cubit;
  List<shaktiKendr.Data> shaktiKendrDataList;

  SelectBooth({Key? key, required this.cubit,required this.shaktiKendrDataList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditShaktiKendrCubit, EditShaktiKendrState>(
      builder: (context,state){
        if(state is LoadingBoothEditShaktiKendraState){
          return listTileShimmerEffect(context: context);
        } else if (state is FatchDataBoothEditShaktiKendraState) {
          cubit.boothData = state.data;
          print("======================= boothData length ==> ${cubit.boothData.data?.length}");
        } else if (state is ErrorBoothEditShaktiKendraState) {
          EasyLoading.showToast(state.error);
        }
        return Container(
            decoration: const BoxDecoration(
                color: AppColor.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0))),
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(28.0),
                  topRight: Radius.circular(28.0)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  spaceHeightWidget(20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      S.of(context).boothSelect,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                          color: AppColor.borderColor, fontSize: 16),
                    ),
                  ),
                  spaceHeightWidget(20),
                  Expanded(
                    child:
                    BlocBuilder<EditShaktiKendrCubit, EditShaktiKendrState>(
                        builder: (context, state) {
                          return cubit.boothData.data?.isNotEmpty ?? false
                              ? ListView.builder(
                              shrinkWrap: true,
                              itemCount: cubit.boothData.data?.length,
                              physics: const BouncingScrollPhysics(),
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      InkWell(
                                        onTap: () async {
                                          if (cubit.chekedValue.contains(cubit.boothData.data![index])) {
                                            cubit.chekedValue.remove(cubit.boothData.data![index]);
                                            cubit.selectedBooth.remove(cubit.boothData.data?[index].id);
                                            await cubit.alreadyExitBoothInOtherSk(isAdd: false,boothId: cubit.boothData.data?[index].id ?? 0,shaktiKendrDataList: shaktiKendrDataList);
                                          } else {
                                            cubit.chekedValue.add(cubit.boothData.data![index]);
                                            cubit.selectedBooth.add(cubit.boothData.data?[index].id ?? 0);
                                            print(cubit.boothData.data?[index].id);
                                            await cubit.alreadyExitBoothInOtherSk(isAdd: true,boothId: cubit.boothData.data?[index].id ?? 0,shaktiKendrDataList: shaktiKendrDataList);
                                          }
                                          cubit.emitState();
                                        },
                                        child: Row(
                                          children: [
                                            IgnorePointer(
                                              child: Checkbox(
                                                  checkColor: Colors.green,
                                                  activeColor: AppColor.white,
                                                  side: MaterialStateBorderSide
                                                      .resolveWith(
                                                        (states) => const BorderSide(
                                                        width: 1.0,
                                                        color: AppColor
                                                            .naturalBlackColor),
                                                  ),
                                                  value: cubit.chekedValue.contains(cubit.boothData.data![index]),
                                                  onChanged: (value) {
                                                  }),
                                            ),
                                            Container(
                                              width: 35,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                  BorderRadius.circular(11),
                                                  color: AppColor
                                                      .boothContainerColour),
                                              child: Text(
                                                cubit.boothData.data?[index]
                                                    .number ??
                                                    '',
                                                textAlign: TextAlign.center,
                                                style: GoogleFonts.poppins(
                                                    color: AppColor.white,
                                                    fontSize: 12),
                                              ),
                                            ),
                                            spaceWidthWidget(10),
                                            Expanded(
                                              child: Text(
                                                cubit.boothData.data?[index].name ??
                                                    '',
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 3,
                                                textAlign: TextAlign.left,
                                                style: GoogleFonts.poppins(
                                                    color: AppColor.black
                                                        .withOpacity(0.8),
                                                    fontSize: 13),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      index + 1 == cubit.boothData.data?.length
                                          ? SizedBox.shrink()
                                          : const Divider(
                                        color: AppColor.borderColor,
                                      ),
                                    ],
                                  ),
                                );
                              })
                              : Center(
                            child: Text(
                              S.of(context).noDataAvailable,
                              style: GoogleFonts.poppins(
                                  color: AppColor.black, fontSize: 14),
                            ),
                          );
                        }),
                  ),
                  cubit.boothData.data?.isNotEmpty ?? false
                      ? CommonButton(
                      borderRadius: 0,
                      title: S.of(context).addBooth,
                      onTap: () {
                        Navigator.pop(context);
                        print(
                            "========================  ${cubit.chekedValue}");
                      },
                      width: MediaQuery.of(context).size.width,
                      style: GoogleFonts.poppins(
                          color: AppColor.white, fontSize: 14),
                      padding: const EdgeInsets.symmetric(vertical: 14))
                      : SizedBox.shrink(),
                ],
              ),
            ));
      },
    );
  }

  Widget listTileShimmerEffect({required BuildContext context}) {
    return Shimmer.fromColors(
      baseColor: AppColor.greyColor.withOpacity(0.3),
      highlightColor: Colors.grey.withOpacity(0.1),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            spaceHeightWidget(30),
            Text(
              S.of(context).boothSelect,
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                  color: AppColor.borderColor, fontSize: 16),
            ),
            spaceHeightWidget(30),
            Expanded(
                child: ListView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    itemCount: cubit.mandal.data?.length,
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: double.infinity,
                            child: Padding(
                              padding:
                              const EdgeInsets.symmetric(vertical: 8.0),
                              child: Container(
                                height: 30,
                                width: MediaQuery.of(context).size.width * 0.9,
                                color: AppColor.white,
                              ),
                            ),
                          ),
                          index + 1 == cubit.mandal.data?.length
                              ? SizedBox.shrink()
                              : const Divider(
                            color: AppColor.borderColor,
                          ),
                        ],
                      );
                    }))
          ],
        ),
      ),
    );
  }
}
