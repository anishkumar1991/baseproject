import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../../Values/app_colors.dart';
import '../../../../../../generated/l10n.dart';
import '../cubit/zila_data_cubit.dart';
import '../cubit/zila_data_state.dart';

class PannaNoListBottomSheetWidget extends StatefulWidget {
  final int acId;
  final int boothID;

  const PannaNoListBottomSheetWidget(
      {Key? key, required this.acId, required this.boothID})
      : super(key: key);

  @override
  State<PannaNoListBottomSheetWidget> createState() =>
      _PannaNoListBottomSheetWidgetState();
}

class _PannaNoListBottomSheetWidgetState
    extends State<PannaNoListBottomSheetWidget> {
  @override
  Widget build(BuildContext context) {
    var cubit = context.read<ZilaDataCubit>();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 10,
          ),
          Text(S.of(context).pannaKramaank,
              style: GoogleFonts.poppins(
                color: AppColor.borderColor,
                fontWeight: FontWeight.w500,
                fontSize: 18,
              )),
          const Divider(
            color: AppColor.borderColor,
          ),
          Expanded(
            child: BlocBuilder<ZilaDataCubit, ZilaDataState>(
              builder: (context, state) {
                if (state is PannaKramaankErrorState) {
                  return Center(
                      heightFactor: MediaQuery.of(context).size.height * 0.02,
                      child: Text(
                        "Oops, something went wrong. Please try again later",
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: AppColor.black),
                      ));
                }
                if (state is PannaKramaankLoadingState) {
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return listTileShimmerEffect();
                    },
                  );
                }

                return cubit.pannaKramaankListData == null
                    ? Center(
                        heightFactor: MediaQuery.of(context).size.height * 0.02,
                        child: Text(
                          S.of(context).noDataAvailable,
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: AppColor.black),
                        ))
                    : cubit.pannaKramaankListData.isEmpty
                        ? Center(
                            heightFactor:
                                MediaQuery.of(context).size.height * 0.02,
                            child: Text(
                              S.of(context).noDataAvailable,
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                  color: AppColor.black),
                            ))
                        : ListView.builder(
                            shrinkWrap: true,
                            itemCount: cubit.pannaKramaankListData.length,
                            itemBuilder: (context, index) {
                              var data = cubit.pannaKramaankListData[index];
                              return listTilePanna(
                                index: data.number ?? 0,
                                name: data.name ?? "",
                                onTap: () {
                                  cubit.selectedPannaNo =
                                      cubit.pannaKramaankListData[index];
                                  print(cubit.pannaKramaankListData[index]
                                      .toJson());

                                  Navigator.pop(context);
                                  cubit.onDataFound();
                                },
                              );
                            },
                          );
              },
            ),
          )
        ],
      ),
    );
  }

  Widget listTilePanna(
      {required int index,
      required String name,
      final GestureTapCallback? onTap}) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: SizedBox(
            height: 60,
            width: double.infinity,
            child: Row(children: [
              Container(
                height: 40,
                width: 40,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7),
                  color: AppColor.dividerColor,
                ),
                child: Text("${index + 1}",
                    style: GoogleFonts.poppins(
                      color: AppColor.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    )),
              ),
              const SizedBox(
                width: 100,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("पन्ना प्रमुख",
                        style: GoogleFonts.poppins(
                          color: AppColor.black,
                          fontWeight: FontWeight.w400,
                          fontSize: 13,
                        )),
                    Text(name,
                        style: GoogleFonts.poppins(
                          color: AppColor.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ))
                  ],
                ),
              ),
            ]),
          ),
        ),
      ],
    );
  }

  Widget listTileShimmerEffect() {
    return Shimmer.fromColors(
      baseColor: AppColor.greyColor.withOpacity(0.3),
      highlightColor: Colors.grey.withOpacity(0.1),
      child: Column(
        children: [
          SizedBox(
            height: 60,
            width: double.infinity,
            child: Row(children: [
              Container(
                height: 40,
                width: 40,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7),
                  color: AppColor.dividerColor,
                ),
              ),
              const SizedBox(
                width: 100,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("पन्ना प्रमुख",
                        style: GoogleFonts.poppins(
                          color: AppColor.black,
                          fontWeight: FontWeight.w400,
                          fontSize: 13,
                        )),
                    Text("अनिरुद्ध पुरोहित",
                        style: GoogleFonts.poppins(
                          color: AppColor.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ))
                  ],
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
