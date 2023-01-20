import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sangathan/AddEntry/Cubit/add_entry_cubit.dart';
import 'package:sangathan/AddEntry/Cubit/add_entry_state.dart';
import 'package:sangathan/Values/app_colors.dart';
import 'package:sangathan/Values/icons.dart';
import 'package:sangathan/Values/spaceHeightWidget.dart';
import 'package:sangathan/Values/spaceWidthWidget.dart';

class ImageNotUploaded extends StatelessWidget {
  const ImageNotUploaded({super.key, this.onTap});
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<AddEntryCubit>(context);
    return BlocBuilder<AddEntryCubit, AddEntryState>(
      builder: (context, state) {
        return Column(
          children: [
            cubit.file == null
                ? Image.asset(
                    AppIcons.personLogo,
                    height: 68,
                  )
                : Image.file(
                    cubit.file!,
                    height: 100,
                    width: 100,
                    fit: BoxFit.cover,
                  ),
            spaceHeightWidget(8),
            GestureDetector(
              onTap: (() async {
                await cubit.requestPermission(ImageSource.gallery);
              }),
              child: Container(
                width: 98,
                padding:
                    const EdgeInsets.only(top: 6, bottom: 6, left: 4, right: 4),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: AppColor.orange300Color,
                    border: Border.all(
                        color: AppColor.buttonOrangeBackGroundColor)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.camera_alt_outlined,
                      color: AppColor.buttonOrangeBackGroundColor,
                      size: 16,
                    ),
                    spaceWidthWidget(8),
                    Text(
                      'Add photo',
                      style: GoogleFonts.quicksand(
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                          color: AppColor.buttonOrangeBackGroundColor),
                    )
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
