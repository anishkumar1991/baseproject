import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:meta/meta.dart';
import 'package:sangathan/Dashboard/Screen/homePage/screens/shakti_kendra/screen/model/delete_model.dart';

import '../../../../../../Storage/user_storage_service.dart';
import '../../../../../../generated/l10n.dart';
import '../network/api/vidhanSabha_api.dart';
import '../network/model/shakti_kendr_model.dart';
import '../network/model/vidhanSabha_model.dart';
import '../screen/widgets/delete_confirmation_dialog.dart';

part 'shakti_kendra_state.dart';

VidhanSabha vidhanSabha = VidhanSabha();

class ShaktiKendraCubit extends Cubit<ShaktiKendraState> {
  ShaktiKendraCubit() : super(ShaktiKendraInitial());

  Locations? zilaSelected;
  String zilaSelectedName = '';
  int isSelectedIndex = 0;
  bool isExpanded = false;
  List<String> partyzilaList = ["First", "Seconf", "Thiurs"];
  List<String> filterList = ["नवीन एंट्री", "मंडल", "A - Z"];
  ShaktiKendr shaktiKendr = ShaktiKendr();

  final api = GetDropDownValue(Dio(BaseOptions(
      contentType: 'application/json', validateStatus: ((status) => true))));

  emitState() {
    emit(LoadingShaktiKendraState());
  }

  Future getDropDownValueOfVidhanSabha({required int id}) async {
    try {
      emit(LoadingShaktiKendraState());
      StorageService.getUserAuthToken();
      var res = await api.getVidhanSabhaValue(
          'Bearer ${StorageService.userAuthToken}', id);
      print(
          "------------------------------------ VidhanSabha DropDown Value  ----------------------------");
      print("token  :${StorageService.userAuthToken}");
      print("Status code : ${res.response.statusCode}");
      print("Response :${res.data}");
      print(
          "------------------------------------ ------------------------ ----------------------------");
      if (res.response.statusCode == 200) {
        VidhanSabha data = VidhanSabha.fromJson(res.response.data);
        vidhanSabha = data;
        getShaktiKendra(id: vidhanSabha.data?.locations?.first.id ?? 357);
      } else {
        print('error=${res.data['message']}');
      }
    } catch (e) {
      print('error=$e');
    }
  }

  getShaktiKendra({required int id}) async {
    try {
      emit(LoadingShaktiKendraState());
      StorageService.getUserAuthToken();
      var res =
          await api.getShaktiKenr('Bearer ${StorageService.userAuthToken}', id);
      print(
          "------------------------------------ Shakti Kendra Value  ----------------------------");
      print("token  :${StorageService.userAuthToken}");
      print("id  :$id");
      print("Status code : ${res.response.statusCode}");
      print("Response :${res.data}");
      print(
          "------------------------------------ ------------------------ ----------------------------");
      if (res.response.statusCode == 200) {
        ShaktiKendr data = ShaktiKendr.fromJson(res.response.data);
        // shaktiKendr = data;
        emit(ShaktiKendraFatchData(data));
      } else {
        emit(ShaktiKendraErrorState(res.data['message']));
        print('error=${res.data['message']}');
      }
    } catch (e) {
      emit(ShaktiKendraErrorState('Something Went Wrong'));
      print('error=$e');
    }
  }

  deleteShaktiKendr(
      {required int id,
      required BuildContext context,
      bool? isConfirmDelete}) async {
    try {
      EasyLoading.show();
      StorageService.getUserAuthToken();
      var res = await api.deleteShaktiKendr(
          'Bearer ${StorageService.userAuthToken}', id);
      print(
          "------------------------------------ Delete Shakti Kendra Value  ----------------------------");
      print("token  :${StorageService.userAuthToken}");
      print("id  :$id");
      print("Status code : ${res.response.statusCode}");
      print("Response :${res.data}");
      print(
          "------------------------------------ ------------------------ ----------------------------");
      if (res.response.statusCode == 200) {
        EasyLoading.dismiss();
        DeleteModel data = DeleteModel.fromJson(res.response.data);
        if (data.data?.askConfirmation == true) {
          dataEntryDeleteDialog(
            context: context,
            onDelete: () {
              Navigator.pop(context);
              deleteShaktiKendr(
                  id: id, context: context, isConfirmDelete: true);
            },
            title: data.data?.message?.trim().trimLeft(),
            subTitle: '',
          );
          getShaktiKendra(id: zilaSelected?.id ?? 357);
        } else {
          EasyLoading.showSuccess(data.data?.message ?? '');
          getShaktiKendra(id: zilaSelected?.id ?? 357);
        }
      } else {
        emit(DeleteShaktiKendraErrorState(res.data['message']));
        print('error=${res.data['message']}');
      }
    } catch (e) {
      EasyLoading.dismiss();
      emit(ShaktiKendraErrorState('Something Went Wrong'));
    }
  }

  getBoothId(List<Booths>? booths) {}

  changeFilter() {
    emit(LoadingShaktiKendraState());
    // emit(FilterChangeState());
  }
}
