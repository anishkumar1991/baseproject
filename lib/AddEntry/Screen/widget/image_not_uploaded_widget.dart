import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sangathan/Values/app_colors.dart';
import 'package:sangathan/Values/icons.dart';
import 'package:sangathan/Values/space_height_widget.dart';
import 'package:sangathan/Values/space_width_widget.dart';

import '../../Cubit/add_entry_cubit.dart';
import '../../Cubit/add_entry_state.dart';

class ImageNotUploaded extends StatelessWidget {
  const ImageNotUploaded({super.key, this.onTap, this.initialUserprofileURL});

  final GestureTapCallback? onTap;
  final String? initialUserprofileURL;

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<AddEntryCubit>(context);
    return BlocBuilder<AddEntryCubit, AddEntryState>(
      builder: (context, state) {
        return GestureDetector(
          onTap: onTap,
          child: Column(
            children: [
              initialUserprofileURL != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Image.network(
                        cubit.initialUserprofileURL ?? "",
                        height: 100,
                        width: 100,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Image.asset(
                            AppIcons.personLogo,
                            height: 68,
                          );
                        },
                      ),
                    )
                  : cubit.file == null
                      ? Image.asset(
                          AppIcons.personLogo,
                          height: 68,
                        )
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: Image.file(
                            cubit.file!,
                            height: 100,
                            width: 100,
                            fit: BoxFit.cover,
                          ),
                        ),
              spaceHeightWidget(8),
              ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Container(
                  width: 105,
                  padding: const EdgeInsets.only(
                      top: 6, bottom: 6, left: 4, right: 4),
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
          ),
        );
      },
    );
  }
}
