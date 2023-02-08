import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:meta/meta.dart';

import '../../../../../../Storage/user_storage_service.dart';
import '../../../../../../generated/l10n.dart';
import '../network/api/vidhanSabha_api.dart';
import '../network/model/shakti_kendr_model.dart';
import '../network/model/vidhanSabha_model.dart';

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
        getShaktiKendra(id: zilaSelected?.id ?? 357);
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

  deleteShaktiKendr({required int id}) async {
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
        EasyLoading.showSuccess("${res.response.data.message}");
      } else {
        emit(DeleteShaktiKendraErrorState(res.data['message']));
        print('error=${res.data['message']}');
      }
    } catch (e) {
      emit(ShaktiKendraErrorState('Something Went Wrong'));
    }
  }

  getBoothId(List<Booths>? booths) {}

  changeFilter() {
    emit(LoadingShaktiKendraState());
    // emit(FilterChangeState());
  }
}
