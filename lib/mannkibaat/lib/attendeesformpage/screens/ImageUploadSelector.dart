import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import '../../values/AppColors.dart';
import '../cubit/AttendeeFormCubit.dart';

void image1Upload(BuildContext context) {
  final cubit = context.read<AttendeeFormCubit>();
  showModalBottomSheet(
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20), topRight: Radius.circular(20)),
    ),
    backgroundColor: AppColor().cardBGcolor,
    context: context,
    builder: (BuildContext bc) {
      return SafeArea(
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.15,
          child: Wrap(
            children: <Widget>[
              const SizedBox(
                height: 10,
              ),
              ListTile(
                  leading: Icon(
                    color: AppColor().buttonColor,
                    Icons.photo_library,
                  ),
                  title: Text(
                    'गेलरी',
                    style: GoogleFonts.publicSans(
                        color: AppColor().textColor,
                        fontWeight: FontWeight.w400),
                  ),
                  onTap: () async {
                    Navigator.of(context).pop();

                    XFile? selectedImage = await ImagePicker()
                        .pickImage(source: ImageSource.gallery);
                    if (selectedImage != null) {
                      File convertedImage1 = File(selectedImage!.path);
                      cubit.selectedImage1(convertedImage1);
                    }
                  }),
              ListTile(
                leading: Icon(
                  color: AppColor().buttonColor,
                  Icons.photo_camera,
                ),
                title: Text(
                  'कैमरा',
                  style: GoogleFonts.publicSans(
                      color: AppColor().textColor, fontWeight: FontWeight.w400),
                ),
                onTap: () async {
                  Navigator.of(context).pop();
                  XFile? selectedImage =
                      await ImagePicker().pickImage(source: ImageSource.camera);
                  if (selectedImage != null) {
                    File convertedImage1 = File(selectedImage!.path);
                    cubit.selectedImage1(convertedImage1);
                  }
                },
              ),
            ],
          ),
        ),
      );
    },
  );
}

void image2Upload(BuildContext context) {
  final cubit = context.read<AttendeeFormCubit>();
  showModalBottomSheet(
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20), topRight: Radius.circular(20)),
    ),
    backgroundColor: AppColor().cardBGcolor,
    context: context,
    builder: (BuildContext bc) {
      return SafeArea(
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.15,
          child: Wrap(
            children: <Widget>[
              const SizedBox(
                height: 10,
              ),
              ListTile(
                  leading: Icon(
                    color: AppColor().buttonColor,
                    Icons.photo_library,
                  ),
                  title: Text(
                    'गेलरी',
                    style: GoogleFonts.publicSans(
                        color: AppColor().textColor,
                        fontWeight: FontWeight.w400),
                  ),
                  onTap: () async {
                    Navigator.of(context).pop();

                    XFile? selectedImage = await ImagePicker()
                        .pickImage(source: ImageSource.gallery);
                    if (selectedImage != null) {
                      File convertedImage2 = File(selectedImage!.path);
                      cubit.selectedImage2(convertedImage2);
                    }
                  }),
              ListTile(
                leading: Icon(
                  color: AppColor().buttonColor,
                  Icons.photo_camera,
                ),
                title: Text(
                  'कैमरा',
                  style: GoogleFonts.publicSans(
                      color: AppColor().textColor, fontWeight: FontWeight.w400),
                ),
                onTap: () async {
                  Navigator.of(context).pop();
                  XFile? selectedImage =
                      await ImagePicker().pickImage(source: ImageSource.camera);
                  if (selectedImage != null) {
                    File convertedImage2 = File(selectedImage!.path);
                    cubit.selectedImage2(convertedImage2);
                  }
                },
              ),
            ],
          ),
        ),
      );
    },
  );
}
