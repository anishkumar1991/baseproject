import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../../../Values/app_colors.dart';
import '../cubit/edit_shakti_kendr_cubit.dart';

class SelectedBooth extends StatelessWidget {
  EditShaktiKendrCubit cubit;

  SelectedBooth(
      {Key? key,required this.cubit})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        itemCount: cubit.chekedValue.length,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return Card(
            shape: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none),
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: ListTile(
                horizontalTitleGap: 10,
                shape: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none),
                dense: true,
                contentPadding: EdgeInsets.only(left: 10, right: 10),
                leading: Container(
                  width: 35,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(11),
                      color: AppColor.orange),
                  child: Text(
                    cubit.chekedValue[index].number ?? '',
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style:
                        GoogleFonts.poppins(color: AppColor.white, fontSize: 12),
                  ),
                ),
                title: Text(
                  cubit.chekedValue[index].name ?? '',
                  style: GoogleFonts.poppins(
                      color: AppColor.black700,
                      fontWeight: FontWeight.w400,
                      fontSize: 12),
                ),
                trailing: SizedBox(
                  height: double.infinity,
                  child: InkWell(
                    onTap: (){
                      cubit.removeSelectedBooth(selectedBooth: cubit.chekedValue[index]);
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
            ),
          );
        });
  }
}
