import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../../Storage/AttendeesFormStorage.dart';
import '../../values/AppColors.dart';
import '../cubit/AttendeeFormCubit.dart';
import '../cubit/AttendeeFormState.dart';
import 'ImageUploadSelector.dart';

class ImageBox extends StatelessWidget {
  File? convertedImage1;
  File? convertedImage2;
  String? downloadUrlImage1;
  String? downloadUrlImage2;
  int? temp;
  XFile? selectedImage;

  ImageBox({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AttendeeFormCubit>();

    return BlocConsumer<AttendeeFormCubit, AttendeeFormState>(
      listener: (context, state) {
        if (state is Image1SelectedState) {
          downloadUrlImage1 = cubit.tempimage1;
          AttendeeStorageService.setimage1url(downloadUrlImage1.toString());
        }
        if (state is Image2SelectedState) {
          downloadUrlImage2 = cubit.tempimage2;
          AttendeeStorageService.setimage2url(downloadUrlImage2.toString());

        }
      },
      builder: (context, state) {
        return SizedBox(
          height: 200,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Flexible(
                fit: FlexFit.tight,
                child: CupertinoButton(
                    onPressed: () async {
                      image1Upload(context);
                    },
                    padding: EdgeInsets.zero,
                    child: (downloadUrlImage1 != null)
                        ? Image.network(downloadUrlImage1!)
                        : BlocBuilder<AttendeeFormCubit, AttendeeFormState>(
                            builder: (context, state) {
                              if (state is Image1UploadingState) {
                                return const CircularProgressIndicator();
                              }
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.image,
                                      color: AppColor().buttonColor),
                                  const SizedBox(height: 5),

                                  Text(
                                    "अपलोड",
                                    style:
                                        TextStyle(color: AppColor().textColor),
                                  )
                                ],
                              );
                            },
                          )),
              ),
              const SizedBox(width: 10),
              Flexible(
                fit: FlexFit.tight,
                child: CupertinoButton(
                    onPressed: () async {
                      image2Upload(context);
                    },
                    padding: EdgeInsets.zero,
                    child: (downloadUrlImage2 != null)
                        ? Image.network(downloadUrlImage2!)
                        : BlocBuilder<AttendeeFormCubit, AttendeeFormState>(
                            builder: (context, state) {
                              if (state is Image2UploadingState) {
                                return const CircularProgressIndicator();
                              }
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.image,
                                    color: AppColor().buttonColor,
                                  ),
                                  const SizedBox(height: 5),
                                  Text("अपलोड",
                                      style: TextStyle(
                                          color: AppColor().textColor))
                                ],
                              );
                            },
                          )),
              ),
            ],
          ),
        );
      },
    );
  }
}
