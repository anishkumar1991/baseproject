import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../../Values/space_height_widget.dart';
import '../cubit/profile_cubit.dart';

Future selectOption({required BuildContext context}){
  return showModalBottomSheet(
      context: context,
      builder: ((context){
        final cubit = context.read<ProfileCubit>();
        return Padding(
          padding: const EdgeInsets
              .symmetric(
              horizontal: 10),
          child: Column(
            crossAxisAlignment:
            CrossAxisAlignment
                .start,
            mainAxisSize:
            MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment:
                MainAxisAlignment
                    .spaceBetween,
                children: [
                  Text(
                    'Choose',
                    style: GoogleFonts
                        .quicksand(
                        fontSize:
                        20,
                        fontWeight:
                        FontWeight
                            .w800),
                  ),
                  IconButton(
                      onPressed: (() async {
                        Navigator.pop(
                            context);
                      }),
                      icon: const Icon(
                        Icons.close,
                        size: 25,
                      ))
                ],
              ),
              const Divider(),
              ListTile(
                onTap: (() async {
                  Navigator.pop(
                      context);
                  try {
                    cubit.image = await ImagePicker().pickImage(source: ImageSource.camera);
                    if (cubit.image == null) return;
                    final imageTemp = File(cubit.image!.path);
                    cubit.imageFile = imageTemp;
                    print("Image Path : ${cubit.imageFile}");
                    cubit.emitState();
                    // cubit.uploadImageToFirebase(context: context);
                    // if(cubit.imageFile != null){
                    //   cubit.uploadImageToFirebase(context: context);
                    //   cubit.emitState();
                    // }
                  } catch (e) {
                    print('Failed to pick image: $e');
                  }
                }),
                title: Text(
                  'Camera',
                  style: GoogleFonts
                      .quicksand(
                      fontSize: 16,
                      fontWeight:
                      FontWeight
                          .w500),
                ),
              ),
              const Divider(),
              ListTile(
                onTap: (() async {
                  Navigator.pop(
                      context);
                  try {
                    cubit.image = await ImagePicker().pickImage(source: ImageSource.gallery);
                    if (cubit.image == null) return;
                    final imageTemp = File(cubit.image!.path);
                    cubit.imageFile = imageTemp;
                    print("Image Path : ${cubit.imageFile}");
                    cubit.emitState();
                    // if(cubit.imageFile != null){
                    //  await cubit.uploadImageToFirebase(context: context);
                    //   cubit.emitState();
                    // }
                  } catch (e) {
                    print('Failed to pick image: $e');
                  }
                }),
                title: Text(
                  'Gallery',
                  style: GoogleFonts
                      .quicksand(
                    fontWeight:
                    FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
              ),
              const Divider(),
              spaceHeightWidget(20)
            ],
          ),
        );
      }));
}