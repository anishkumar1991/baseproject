import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sangathan/Dashboard/Screen/homePage/screens/zila_data_page/cubit/zila_data_cubit.dart';

import '../../../../../../Values/app_colors.dart';
import '../../../../../../generated/l10n.dart';
import '../cubit/zila_data_state.dart';

class FilterOptions extends StatelessWidget {
  const FilterOptions({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<ZilaDataCubit>();
    return BlocBuilder<ZilaDataCubit, ZilaDataState>(
      builder: (context, state) {
        return Container(
          height: 32,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColor.greyColor.withOpacity(0.5))),
          child: IntrinsicHeight(
            child: Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: (() {
                      cubit.onTapFilterOptions(0);
                      cubit.filterData();
                    }),
                    child: Container(
                      decoration: BoxDecoration(
                          color: cubit.selectedFilterIndex == 0
                              ? AppColor.navyBlue400
                              : AppColor.white,
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(20),
                              bottomLeft: Radius.circular(20))),
                      height: 32,
                      child: Center(
                        child: Text(
                          S.of(context).newEntry,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              color: cubit.selectedFilterIndex == 0
                                  ? AppColor.white
                                  : AppColor.textBlackColor),
                        ),
                      ),
                    ),
                  ),
                ),
                const VerticalDivider(
                  width: 1,
                  color: AppColor.greyColor,
                ),
                Expanded(
                  child: InkWell(
                    onTap: (() {
                      cubit.onTapFilterOptions(1);
                      cubit.filterData();
                    }),
                    child: Container(
                      height: 32,
                      color: cubit.selectedFilterIndex == 1
                          ? AppColor.navyBlue400
                          : AppColor.white,
                      child: Center(
                        child: Text(
                          S.of(context).post,
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              color: cubit.selectedFilterIndex == 1
                                  ? AppColor.white
                                  : AppColor.textBlackColor),
                        ),
                      ),
                    ),
                  ),
                ),
                const VerticalDivider(
                  width: 1,
                  color: AppColor.greyColor,
                ),
                Expanded(
                  child: InkWell(
                    onTap: (() {
                      cubit.onTapFilterOptions(2);
                      cubit.filterData();
                    }),
                    child: Container(
                      height: 32,
                      decoration: BoxDecoration(
                          color: cubit.selectedFilterIndex == 2
                              ? AppColor.navyBlue400
                              : AppColor.white,
                          borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(20),
                              bottomRight: Radius.circular(20))),
                      child: Center(
                        child: Text(
                          'A to Z',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              color: cubit.selectedFilterIndex == 2
                                  ? AppColor.white
                                  : AppColor.textBlackColor),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
