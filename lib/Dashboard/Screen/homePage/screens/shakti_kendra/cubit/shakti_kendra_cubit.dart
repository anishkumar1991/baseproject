import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

import '../../../../../../Storage/user_storage_service.dart';
import '../../../../../../generated/l10n.dart';
import '../network/api/vidhanSabha_api.dart';
import '../network/model/vidhanSabha_model.dart';

part 'shakti_kendra_state.dart';
VidhanSabha vidhanSabha = VidhanSabha();
class ShaktiKendraCubit extends Cubit<ShaktiKendraState> {
  ShaktiKendraCubit() : super(ShaktiKendraInitial());

  String zilaSelected = "First";
  int isSelectedIndex = 0;
  bool isExpanded = false;
  List<String> partyzilaList = ["First","Seconf","Thiurs"];
  List<String> filterList = ["नवीन एंट्री","मंडल","A - Z"];

  final api = GetDropDownValue(Dio(BaseOptions(
      contentType: 'application/json', validateStatus: ((status) => true))));

  emitState(){
    emit(LoadingShaktiKendraState());
  }

  Future getDropDownValueOfVidhanSabha({required int id}) async {
    try {
      emit(LoadingShaktiKendraState());
      StorageService.getUserAuthToken();
      var res =
      await api.getVidhanSabhaValue('Bearer ${StorageService.userAuthToken}',id);
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
      } else {
        print('error=${res.data['message']}');
      }
    } catch (e) {
      print('error=$e');
    }
  }

  void onChnageZila(String? value) {
    emit(LoadingShaktiKendraState());
    zilaSelected = value!;
    emit(ZilaChangedShaktiKendraState());
  }

  changeFilter(){
    emit(LoadingShaktiKendraState());
    // emit(FilterChangeState());
  }
}
