import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../../../Values/app_colors.dart';
import '../../../../../../../Values/space_height_widget.dart';
import '../../../../../../../generated/l10n.dart';
import '../../cubit/shakti_kendra_cubit.dart';
import '../cubit/edit_shakti_kendr_cubit.dart';

class VidhanSabhaBottomSheet extends StatelessWidget {
  BuildContext? context;
  EditShaktiKendrCubit cubit;
  String? text;

  VidhanSabhaBottomSheet(
      {Key? key, this.context, this.text, required this.cubit})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                  child: vidhanSabha.data?.locations?.isNotEmpty ?? false
                      ? ListView.builder(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          itemCount: vidhanSabha.data?.locations?.length,
                          physics: BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                InkWell(
                                  onTap: () {
                                    cubit.chekedValue = [];
                                    cubit.mandalSelected = '';
                                    cubit.zilaSelected = vidhanSabha
                                            .data?.locations?[index].name ??
                                        '';
                                    cubit.zilaId =
                                        vidhanSabha.data?.locations?[index].id;
                                    cubit.getBoothValuew(
                                        id: cubit.zilaId ?? 236);
                                    cubit.getDropDownValueOfmandal(
                                        id: cubit.zilaId ?? 236);
                                    Navigator.pop(context);
                                  },
                                  child: SizedBox(
                                    width: double.infinity,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                                      child: Text(
                                        vidhanSabha
                                                .data?.locations?[index].name ??
                                            '',
                                        textAlign: TextAlign.left,
                                        style: GoogleFonts.poppins(
                                            color: AppColor.black, fontSize: 16),
                                      ),
                                    ),
                                  ),
                                ),
                                index + 1 == vidhanSabha.data?.locations?.length
                                    ? SizedBox.shrink()
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
  }
}
