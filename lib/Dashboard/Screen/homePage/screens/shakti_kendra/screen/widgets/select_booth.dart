import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sangathan/Dashboard/Screen/homePage/screens/shakti_kendra/screen/cubit/edit_shakti_kendr_cubit.dart';
import 'package:sangathan/Values/space_width_widget.dart';
import 'package:sangathan/common/common_button.dart';

import '../../../../../../../Values/app_colors.dart';
import '../../../../../../../Values/space_height_widget.dart';
import '../../../../../../../generated/l10n.dart';

class SelectBooth extends StatelessWidget {
  EditShaktiKendrCubit cubit;

  SelectBooth({Key? key, required this.cubit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
      child: Container(
          decoration: const BoxDecoration(
              color: AppColor.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(28.0),
                  topRight: Radius.circular(28.0))),
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
                child: BlocBuilder<EditShaktiKendrCubit, EditShaktiKendrState>(
                    builder: (context, state) {
                  return ListView.builder(
                      shrinkWrap: true,
                      itemCount: cubit.boothData.data?.length,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Checkbox(
                                      checkColor: Colors.green,
                                      activeColor: AppColor.white,
                                      side: MaterialStateBorderSide.resolveWith(
                                            (states) => BorderSide(width: 1.0, color: AppColor.naturalBlackColor),
                                      ),
                                      value: cubit.chekedValue.contains(cubit.boothData.data?[index].id),
                                      onChanged: (value) {

                                        if(cubit.chekedValue.contains(cubit.boothData.data?[index].id)){
                                          cubit.chekedValue.removeAt(index);
                                        }else{
                                          cubit.chekedValue.add(cubit.boothData.data?[index].id ?? 0);
                                        }
                                        cubit.emitState();
                                      }),
                                  Container(
                                    margin: EdgeInsets.only(top: 1),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(11),
                                        color: index == 2 ? AppColor.orange :AppColor.blue),
                                    child: Text(
                                      cubit.boothData.data?[index].number ?? '',
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.poppins(
                                          color: AppColor.white, fontSize: 12),
                                    ),
                                  ),
                                  spaceWidthWidget(10),
                                  Expanded(
                                    child: Text(
                                      cubit.boothData.data?[index].name ?? '',
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 3,
                                      textAlign: TextAlign.left,
                                      style: GoogleFonts.poppins(
                                          color:
                                              AppColor.black.withOpacity(0.8),
                                          fontSize: 13),
                                    ),
                                  ),
                                ],
                              ),
                              spaceHeightWidget(5),
                              const Divider(
                                color: AppColor.borderColor,
                              ),
                              spaceHeightWidget(5),
                            ],
                          ),
                        );
                      });
                }),
              ),
              CommonButton(
                  borderRadius: 0,
                  title: S.of(context).addBooth,
                  onTap: (){
                    Navigator.pop(context);
                    print("========================  ${cubit.chekedValue}");
                  },
                  width: MediaQuery.of(context).size.width,
                  style:
                      GoogleFonts.poppins(color: AppColor.white, fontSize: 14),
                  padding: const EdgeInsets.symmetric(vertical: 14)),
            ],
          )),
    );
  }
}
