import 'dart:io';

import 'package:dio/dio.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../../AddEntry/network/model/category_model.dart';
import '../../../../../../Storage/user_storage_service.dart';
import '../../../../../../generated/l10n.dart';
import '../../personal_info/cubit/personal_info_cubit.dart';
import '../network/api/user_detail_api.dart';
import '../network/model/user_detail_model.dart';
import '../widgets/photo_selction_bottom_sheet.dart';

part 'profile_state.dart';

DropdownValueModel? dropDownValue;

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());

  UserDetailModel? userDetails;
  File? imageFile;
  XFile? image;
  UploadTask? task;
  String? urlDownload;
  bool showAddress = false;
  bool showEducation = false;
  bool showBusiness = false;
  GetStorage box = GetStorage();

  final api = UserDetailApi(Dio(BaseOptions(
      contentType: 'application/json', validateStatus: ((status) => true))));

  emitState() {
    emit(ProfileInitial());
  }

  Future<void> selectImageForProfile({int? id, BuildContext? context}) async {
    emit(ProfileInitial());
    await selectOption(context: context!);
    emit(ImageSelectForProfileSuccess());
  }

  uploadImageToFirebase({required BuildContext context}) async {
    EasyLoading.show(status: S.of(context).uploading);
    final imageTemp = File(image!.path);
    imageFile = imageTemp;
    final destination =
        '${userDetails?.data?.id}/${userDetails?.data?.id}_userProfile';
    task = FirebaseApi.uploadFile(destination, imageFile!);
    final snapshot = await task!.whenComplete(() {
      EasyLoading.dismiss();
    });
    urlDownload = await snapshot.ref.getDownloadURL();
    print('Image Download-Link: $urlDownload');
    if (urlDownload != null) {
      Future.delayed(Duration.zero).then((value) {
        context.read<PersonalInfoCubit>().updatePersonalDetails(data: {
          "avatar": urlDownload,
        }, isProfile: true);
      });
    }
    EasyLoading.dismiss();
    EasyLoading.showSuccess("Photo Uploaded",
        duration: const Duration(milliseconds: 500));
    Future.delayed(Duration.zero).then((value) {
      Navigator.pop(context);
    });
  }

  Future getUserDetails({bool? isAddress, BuildContext? context}) async {
    try {
      emit(ProfileLoadingState());
      StorageService.getUserAuthToken();
      var res =
          await api.getDataLevel('Bearer ${StorageService.userAuthToken}');
      print(
          "------------------------------------ User profile data  ----------------------------");
      print("token  :${StorageService.userAuthToken}");
      print("Status code : ${res.response.statusCode}");
      print("Response :${res.data}");
      print(
          "------------------------------------ ------------------------ ----------------------------");
      if (res.response.statusCode == 200) {
        UserDetailModel data = UserDetailModel.fromJson(res.response.data);
        // if (isAddress == true) {
        //   print(
        //       "**********************************************************************************************************************");
        //   context?.read<UserProfileCubit>().getUserProfileData();
        // }
        emit(UserDetailFetchedState(data));
      } else {
        print('error=${res.data['message']}');
        emit(ErrorState(res.data['message']));
      }
    } catch (e) {
      emit(ErrorState('Something Went Wrong'));
    }
  }

  Future getDropdownData() async {
    try {
      emit(ProfileInitial());
      final res = await api.getDropdownValues(
        'Bearer ${StorageService.userAuthToken}',
      );
      print('dropdown res =${res.response}');
      if (res.response.statusCode == 200) {
        DropdownValueModel data = DropdownValueModel.fromJson(res.data);
        dropDownValue = data;
        emit(DropDownFetchedState(data));
      } else {
        Map<String, dynamic>? msg = res.data;
        emit(DropDownErrorState(msg?['errors'] ?? ''));
      }
    } catch (e) {
      emit(DropDownErrorState('Something Went Wrong'));
    }
  }
}
