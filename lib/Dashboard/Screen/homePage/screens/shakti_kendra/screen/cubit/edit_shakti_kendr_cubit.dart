import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:meta/meta.dart';
import 'package:sangathan/Dashboard/Screen/homePage/screens/shakti_kendra/screen/network/api/mandal_api.dart';
import 'package:sangathan/Dashboard/Screen/homePage/screens/shakti_kendra/screen/network/model/mandal_model.dart';
import 'package:sangathan/Dashboard/Screen/homePage/screens/shakti_kendra/screen/model/booth_selection_model.dart'
    as data;
import '../../../../../../../Storage/user_storage_service.dart';
import '../model/booth_selection_model.dart';

part 'edit_shakti_kendr_state.dart';

class EditShaktiKendrCubit extends Cubit<EditShaktiKendrState> {
  EditShaktiKendrCubit() : super(EditShaktiKendrInitial());

  String zilaSelected = '';

  int? zilaId;
  int? mandalId;
  String zilaSelectedName = "";
  String mandalSelected = "";
  String boothSelected = "";
  Mandal mandal = Mandal();
  Booth boothData = Booth();
  TextEditingController shaktiKendrCtr = TextEditingController();

  List<int> chekedValue = [];
  List<data.Data> selectedBooth = [];

  final api = GetDropDownValue(Dio(BaseOptions(
      contentType: 'application/json', validateStatus: ((status) => true))));

  Future getDropDownValueOfmandal({required int id}) async {
    try {
      emit(LoadingEditShaktiKendraState());
      StorageService.getUserAuthToken();
      var res = await api.getMandalValue(
          'Bearer ${StorageService.userAuthToken}', id);
      print(
          "------------------------------------ Mandal DropDownValue  ----------------------------");
      print("token  :${StorageService.userAuthToken}");
      print("Status code : ${res.response.statusCode}");
      print("Response :${res.data}");
      print(
          "------------------------------------ ------------------------ ----------------------------");
      if (res.response.statusCode == 200) {
        Mandal data = Mandal.fromJson(res.response.data);
        mandal = data;
      } else {
        print('error=${res.data['message']}');
      }
    } catch (e) {
      print('error123456789=$e');
    }
  }

  getBoothValuew({required int id}) async {
    try {
      emit(LoadingEditShaktiKendraState());
      StorageService.getUserAuthToken();
      var res =
          await api.getBooth('Bearer ${StorageService.userAuthToken}', id);
      print(
          "------------------------------------ booth DropDownValue  ----------------------------");
      print("token  :${StorageService.userAuthToken}");
      print("Status code : ${res.response.statusCode}");
      print("Response :${res.data}");
      print(
          "------------------------------------ ------------------------ ----------------------------");
      if (res.response.statusCode == 200) {
        Booth data = Booth.fromJson(res.response.data);
        boothData = data;
      } else {
        print('error=${res.data['message']}');
      }
    } catch (e) {
      print('error=$e');
    }
  }

  createAndEditShaktiKendr(
      {int? vidhanSabhaId, int? mandalId, String? skName, List? booth}) async {
    try {
      EasyLoading.show();
      emit(LoadingEditShaktiKendraState());
      StorageService.getUserAuthToken();
      var res = await api.createAndEditShaktiKendr(
          'Bearer ${StorageService.userAuthToken}', {
        "ac": vidhanSabhaId,
        "mandal": mandalId,
        "sk_name": skName,
        "booths": booth
      });
      print(
          "------------------------------------ booth DropDownValue  ----------------------------");
      print("token  :${StorageService.userAuthToken}");
      print("Status code : ${res.response.statusCode}");
      print("Response :${res.data}");
      print(
          "------------------------------------ ------------------------ ----------------------------");
      if (res.response.statusCode == 200) {
        Booth data = Booth.fromJson(res.response.data);
        boothData = data;
        EasyLoading.dismiss();
        EasyLoading.showToast(data.message ?? '',
            toastPosition: EasyLoadingToastPosition.top);
      } else {
        EasyLoading.dismiss();
        EasyLoading.showToast("${res.data['message']}",
            toastPosition: EasyLoadingToastPosition.top);
        print('error=${res.data['message']}');
      }
    } catch (e) {
      EasyLoading.dismiss();
      EasyLoading.showToast("Something Went Wrong");
      print('error=$e');
    }
  }

  emitState() {
    emit(LoadingEditShaktiKendraState());
  }
}
