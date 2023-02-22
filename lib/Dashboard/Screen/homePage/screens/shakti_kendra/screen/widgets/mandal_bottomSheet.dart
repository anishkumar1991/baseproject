import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../../../Values/app_colors.dart';
import '../../../../../../../Values/space_height_widget.dart';
import '../../../../../../../generated/l10n.dart';
import '../cubit/edit_shakti_kendr_cubit.dart';

class MandalBottomSheet extends StatelessWidget {
  EditShaktiKendrCubit cubit;
  String? text;

  MandalBottomSheet({Key? key, this.text, required this.cubit})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditShaktiKendrCubit, EditShaktiKendrState>(
      builder: (context, state) {
        if (state is LoadingMandalEditShaktiKendraState) {
          return listTileShimmerEffect(context: context);
        } else if (state is FatchDataMandalEditShaktiKendraState) {
          context.read<EditShaktiKendrCubit>().mandalDropDownList = state.data;
        } else if (state is ErrorMandalEditShaktiKendraState) {
          EasyLoading.showToast(state.error);
        }
        return Container(
          color: Colors.transparent,
          child: Container(
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(28.0),
                      topRight: Radius.circular(28.0))),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    spaceHeightWidget(30),
                    Text(
                      text ?? '',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                          color: AppColor.borderColor, fontSize: 16),
                    ),
                    spaceHeightWidget(30),
                    Expanded(
                      child: cubit.mandalDropDownList?.isNotEmpty ?? false
                          ? ListView.builder(
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              itemCount: cubit.mandalDropDownList?.length,
                              physics: const BouncingScrollPhysics(),
                              itemBuilder: (context, index) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        cubit.mandalSelected = cubit
                                                .mandalDropDownList?[index]
                                                .name ??
                                            '';
                                        cubit.mandalId =
                                            cubit.mandalDropDownList?[index].id;
                                        cubit.emitState();
                                        Navigator.pop(context);
                                      },
                                      child: SizedBox(
                                        width: double.infinity,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 8.0),
                                          child: Text(
                                            cubit.mandalDropDownList?[index]
                                                    .name ??
                                                '',
                                            textAlign: TextAlign.left,
                                            style: GoogleFonts.poppins(
                                                color: AppColor.black,
                                                fontSize: 16),
                                          ),
                                        ),
                                      ),
                                    ),
                                    index + 1 ==
                                            cubit.mandalDropDownList?.length
                                        ? const SizedBox.shrink()
                                        : const Divider(
                                            color: AppColor.borderColor,
                                          ),
                                  ],
                                );
                              })
                          : Text(
                              S.of(context).noDataAvailable,
                              textAlign: TextAlign.left,
                              style: GoogleFonts.poppins(
                                  color: AppColor.black, fontSize: 16),
                            ),
                    )
                  ],
                ),
              )),
        );
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
              text ?? '',
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                  color: AppColor.borderColor, fontSize: 16),
            ),
            spaceHeightWidget(30),
            Expanded(
                child: ListView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    itemCount: cubit.mandalDropDownList?.length,
                    physics: const BouncingScrollPhysics(),
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
                          index + 1 == cubit.mandalDropDownList?.length
                              ? const SizedBox.shrink()
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
