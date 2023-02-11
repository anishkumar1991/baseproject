import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sangathan/Values/space_height_widget.dart';

import '../../../../../../../Values/app_colors.dart';
import '../cubit/edit_shakti_kendr_cubit.dart';

class WarningBooth extends StatelessWidget {
  final String? shaktiKendrName;
  EditShaktiKendrCubit cubit;

  WarningBooth(
      {Key? key,
      this.shaktiKendrName,
      required this.cubit})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        itemCount: cubit.alreadyExitBooth.length,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 2),
            child: DottedBorder(
              color: AppColor.blue,
              strokeWidth: 1,
              borderType: BorderType.RRect,
              radius: const Radius.circular(12),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColor.pravasCradColor.withOpacity(0.2),
                ),
                child: Column(
                  children: [
                    ListTile(
                      horizontalTitleGap: 10,
                      shape: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none),
                      dense: true,
                      contentPadding: const EdgeInsets.only(left: 10, right: 10),
                      leading: Container(
                        width: 35,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(11),
                            color: AppColor.orange),
                        child: Text(
                          cubit.alreadyExitBooth[index].number ?? '',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                              color: AppColor.white, fontSize: 12),
                        ),
                      ),
                      title: Text(
                        cubit.alreadyExitBooth[index].name ?? '',
                        style: GoogleFonts.poppins(
                            color: AppColor.black700,
                            fontWeight: FontWeight.w400,
                            fontSize: 12),
                      ),
                      trailing: SizedBox(
                        height: double.infinity,
                        child: InkWell(
                          onTap: () {
                            cubit.removeExistBooth(booth: cubit.alreadyExitBooth[index]);
                          },
                          child: Container(
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle, color: AppColor.red),
                            child: const Padding(
                              padding: EdgeInsets.all(5.0),
                              child: Icon(
                                Icons.close,
                                color: AppColor.white,
                                size: 13,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Divider(
                      color: AppColor.naturalBlackColor.withOpacity(0.8),
                      indent: 15,
                      endIndent: 15,
                    ),
                    Text(
                      shaktiKendrName ?? '',
                      style: GoogleFonts.poppins(
                          color: AppColor.black700,
                          fontWeight: FontWeight.w400,
                          fontSize: 10),
                    ),
                    spaceHeightWidget(10)
                  ],
                ),
              ),
            ),
          );
        });
  }
}
