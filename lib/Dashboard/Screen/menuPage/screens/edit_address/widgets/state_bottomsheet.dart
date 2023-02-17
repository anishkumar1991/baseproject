import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../../Values/app_colors.dart';
import '../../../../../../Values/space_height_widget.dart';
import '../../../../../../generated/l10n.dart';
import '../cubit/edit_address_cubit.dart';

class StateBottomSheet extends StatelessWidget {
  const StateBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<EditAddressCubit>();
    return BlocBuilder<EditAddressCubit, EditAddressState>(
      builder: (context, state){
        if(state is GetStateLoadingState){
          return shimmerWidget(context: context);
        }else if(state is GetStateFatchDataState){
          cubit.countryState = state.data;
        }else if(state is GetStateErrorState){
          EasyLoading.showToast(state.error ?? '');
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
                      S.of(context).state,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                          color: AppColor.borderColor, fontSize: 16),
                    ),
                    spaceHeightWidget(30),
                    Expanded(
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: cubit.countryState.length,
                          itemBuilder: (context, index) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                InkWell(
                                  onTap: () {
                                    // if (text == S.of(context).category) {
                                    //   controller.text = list?[index].name ?? '';
                                    //   Navigator.pop(context);
                                    // } else {
                                    //   controller.text = list?[index].name ?? '';
                                    //   Navigator.pop(context);
                                    // }
                                  },
                                  child: SizedBox(
                                    width: double.infinity,
                                    child: Text(
                                      cubit.countryState[index].subcountry ?? '',
                                      textAlign: TextAlign.left,
                                      style: GoogleFonts.poppins(
                                          color: AppColor.black, fontSize: 16),
                                    ),
                                  ),
                                ),
                                spaceHeightWidget(15),
                                const Divider(
                                  color: AppColor.borderColor,
                                ),
                                spaceHeightWidget(15),
                              ],
                            );
                          }),
                    )
                  ],
                ),
              )),
        );
      },
    );
  }

  shimmerWidget({required BuildContext context}){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          spaceHeightWidget(30),
          Text(
            S.of(context).state,
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
                color: AppColor.borderColor, fontSize: 16),
          ),
          spaceHeightWidget(30),
          Expanded(
            child: Shimmer.fromColors(
              baseColor: AppColor.greyColor.withOpacity(0.3),
              highlightColor: Colors.grey.withOpacity(0.1),
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: double.infinity,
                          height: 25,
                          color: AppColor.white,
                        ),
                        spaceHeightWidget(15),
                        const Divider(
                          color: AppColor.borderColor,
                        ),
                        spaceHeightWidget(15),
                      ],
                    );
                  }),
            ),
          )
        ],
      ),
    );
  }
}
