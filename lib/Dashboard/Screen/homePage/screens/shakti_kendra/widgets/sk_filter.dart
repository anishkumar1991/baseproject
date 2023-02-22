import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sangathan/Dashboard/Screen/homePage/screens/shakti_kendra/network/model/shakti_kendr_model.dart';

import '../../../../../../Values/app_colors.dart';
import '../../../../../../Values/space_height_widget.dart';
import '../../../../../../Values/space_width_widget.dart';
import '../../../../../../generated/l10n.dart';
import '../cubit/shakti_kendra_cubit.dart';
import '../screen/cubit/edit_shakti_kendr_cubit.dart';

class SKFilter extends StatefulWidget {
  const SKFilter({Key? key}) : super(key: key);

  @override
  State<SKFilter> createState() => _SKFilterState();
}

class _SKFilterState extends State<SKFilter> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShaktiKendraCubit, ShaktiKendraState>(
      builder: (context, state) {
        final cubit = BlocProvider.of<ShaktiKendraCubit>(context);
        return Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: AppColor.pravasCradColor.withOpacity(0.3)),
          child: Column(
            children: [
              InkWell(
                onTap: () {
                  cubit.isExpanded = !cubit.isExpanded;
                  cubit.emitState();
                },
                child: Row(
                  children: [
                    const Icon(
                      Icons.filter_list,
                      color: AppColor.naturalBlackColor,
                      size: 22,
                    ),
                    spaceWidthWidget(10),
                    Text(
                      S.of(context).filter,
                      style: GoogleFonts.poppins(color: AppColor.naturalBlackColor, fontWeight: FontWeight.w400, fontSize: 14),
                    ),
                    const Spacer(),
                    Icon(
                      !cubit.isExpanded ? Icons.keyboard_arrow_down : Icons.keyboard_arrow_up_sharp,
                      color: AppColor.naturalBlackColor,
                    )
                  ],
                ),
              ),
              spaceHeightWidget(cubit.isExpanded ? 10 : 0),
              cubit.isExpanded
                  ? SizedBox(
                      height: cubit.isSelectedIndex == 1 ? MediaQuery.of(context).size.height * 0.11 : MediaQuery.of(context).size.height * 0.06,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 35,
                            child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: cubit.filterList.length,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () {
                                      cubit.isSelectedIndex = index;
                                      cubit.changeFilter();
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.all(5),
                                      width: MediaQuery.of(context).size.width * 0.25,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(8),
                                          color: cubit.isSelectedIndex == index ? AppColor.blue.withOpacity(0.8) : AppColor.white,
                                          border: Border.all(color: cubit.isSelectedIndex == index ? Colors.transparent : AppColor.dividerColor)),
                                      child: Center(
                                        child: Text(
                                          cubit.filterList[index],
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.poppins(color: cubit.isSelectedIndex == index ? AppColor.white : AppColor.naturalBlackColor, fontWeight: FontWeight.w400, fontSize: 14),
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                          ),
                          cubit.isSelectedIndex == 1
                              ? BlocBuilder<EditShaktiKendrCubit, EditShaktiKendrState>(
                                  builder: (context, editShaktiKendrState) {
                                    if (editShaktiKendrState is FatchDataMandalEditShaktiKendraState) {
                                      cubit.mandalFilterData = editShaktiKendrState.data;
                                      if (cubit.mandalFilterData[0].name != "All") {
                                        cubit.mandalFilterData.insert(0, Mandal(name: "All", id: 0));
                                      }
                                    }
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 8),
                                      child: SizedBox(
                                        height: 35,
                                        child: ListView.builder(
                                            shrinkWrap: true,
                                            scrollDirection: Axis.horizontal,
                                            itemCount: cubit.mandalFilterData.length,
                                            itemBuilder: (context, index) {
                                              return InkWell(
                                                onTap: () {
                                                  cubit.selectedMandal = cubit.mandalFilterData[index].name ?? "";
                                                  cubit.filterBasedOnMandal();
                                                },
                                                child: Container(
                                                  margin: const EdgeInsets.all(5),
                                                  padding: const EdgeInsets.symmetric(horizontal: 10),
                                                  decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(8),
                                                      color: cubit.selectedMandal == cubit.mandalFilterData[index].name ? AppColor.blue.withOpacity(0.8) : AppColor.white,
                                                      border: Border.all(color: cubit.selectedMandal == cubit.mandalFilterData[index].name ? Colors.transparent : AppColor.dividerColor)),
                                                  child: Center(
                                                    child: Text(
                                                      cubit.mandalFilterData[index].name ?? "",
                                                      textAlign: TextAlign.center,
                                                      style: GoogleFonts.poppins(
                                                          color: cubit.selectedMandal == cubit.mandalFilterData[index].name ? AppColor.white : AppColor.naturalBlackColor,
                                                          fontWeight: FontWeight.w400,
                                                          fontSize: 14),
                                                    ),
                                                  ),
                                                ),
                                              );
                                            }),
                                      ),
                                    );
                                  },
                                )
                              : const SizedBox()
                        ],
                      ),
                    )
                  : const SizedBox.shrink()
            ],
          ),
        );
      },
    );
  }
}
