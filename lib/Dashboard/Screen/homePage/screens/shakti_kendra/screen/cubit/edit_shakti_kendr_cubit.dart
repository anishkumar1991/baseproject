import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sangathan/Dashboard/Screen/homePage/screens/shakti_kendra/screen/network/api/mandal_api.dart';
import 'package:sangathan/Dashboard/Screen/homePage/screens/shakti_kendra/screen/network/model/mandal_model.dart'
    as mandalModel;

import '../../../../../../../Storage/user_storage_service.dart';
import '../../network/model/shakti_kendr_model.dart' as shaktiKendr;
import '../model/booth_selection_model.dart' as booth;
import '../model/booth_selection_model.dart';

part 'edit_shakti_kendr_state.dart';

class EditShaktiKendrCubit extends Cubit<EditShaktiKendrState> {
  EditShaktiKendrCubit() : super(EditShaktiKendrInitial());

  String zilaSelected = '';
  int? shaktiKendrId;
  int? zilaId;
  int? mandalId;
  String zilaSelectedName = "";
  String mandalSelected = "";
  String boothSelected = "";
  mandalModel.Mandal mandal = mandalModel.Mandal();
  Booth boothData = Booth();
  TextEditingController shaktiKendrCtr = TextEditingController();
  List<booth.Data> selectedBoothDetails = [];

  List<booth.Data> chekedValue = [];
  List<int> selectedBooth = [];
  List<shaktiKendr.Booths> alreadyExitBooth = [];

  final api = GetDropDownValue(Dio(BaseOptions(
      contentType: 'application/json', validateStatus: ((status) => true))));

  alreadyExitBoothInOtherSk(
      {required int boothId,
      required bool isAdd,
      required List<shaktiKendr.Data> shaktiKendrDataList}) {
    for (int i = 0; i < shaktiKendrDataList.length; i++) {
      for (int j = 0; j < (shaktiKendrDataList[i].booths?.length ?? 0); j++) {
        if (shaktiKendrDataList[i].booths?[j].id == boothId) {
          if (isAdd == true) {
            alreadyExitBooth.add(shaktiKendrDataList[i].booths![j]);
            emit(AlreadyExistBoothFatchDataState());
          } else {
            alreadyExitBooth.remove(shaktiKendrDataList[i].booths![j]);
            emit(AlreadyExistBoothFatchDataState());
          }
        }
      }
    }
  }

  removeSelectedBooth({required booth.Data showSelectedBooth}) {
    chekedValue.removeWhere((element) => element.id == showSelectedBooth.id);
    alreadyExitBooth
        .removeWhere((element) => element.id == showSelectedBooth.id);
    selectedBooth.removeWhere(((element) => element == showSelectedBooth.id));
    emit(AlreadyExistBoothFatchDataState());
  }

  removeExistBooth({required dynamic booth}) {
    chekedValue.removeWhere((element) => element.number == booth.number);
    alreadyExitBooth.removeWhere((element) => element.id == booth.id);
    selectedBooth.removeWhere(((element) => element == booth.id));
    emit(AlreadyExistBoothFatchDataState());
  }

  Future getDropDownValueOfmandal({required int id, bool? isEdit}) async {
    try {
      emit(LoadingMandalEditShaktiKendraState());
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
        mandalModel.Mandal data =
            mandalModel.Mandal.fromJson(res.response.data);
        if (isEdit == true) {
          getBoothValuew(id: id);
        }
        emit(FatchDataMandalEditShaktiKendraState(data: data));
      } else {
        emit(ErrorMandalEditShaktiKendraState(
            error: "Something went wrong mandal"));
        print('error=${res.data['message']}');
      }
    } catch (e) {
      emit(ErrorMandalEditShaktiKendraState(error: e.toString()));
      print('error123456789=$e');
    }
  }

  getBoothValuew({required int id}) async {
    try {
      emit(LoadingBoothEditShaktiKendraState());
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
        emit(FatchDataBoothEditShaktiKendraState(data: data));
      } else {
        emit(ErrorBoothEditShaktiKendraState(
            error: "Something went wrong booth"));
        print('error=${res.data['message']}');
      }
    } catch (e) {
      emit(ErrorBoothEditShaktiKendraState(error: e.toString()));
      print('error=$e');
    }
  }

  createAndEditShaktiKendr(
      {int? vidhanSabhaId,
      int? mandalId,
      String? skName,
      List? booth,
      bool? isEdit,
      required BuildContext context}) async {
    try {
      emit(LoadingEditAndCreateEditShaktiKendraState());
      StorageService.getUserAuthToken();
      var res = await apiCalling(
          isEdit: isEdit,
          booth: booth,
          mandalId: mandalId,
          vidhanSabhaId: vidhanSabhaId,
          skName: skName);
      print(
          "------------------------------------ createShaktiKendr DropDownValue  ----------------------------");
      print("token  :${StorageService.userAuthToken}");
      print("Status code : ${res.response.statusCode}");
      print("Response :${res.data}");
      print(
          "------------------------------------ ------------------------ ----------------------------");
      if (res.response.statusCode == 200) {
        Booth data = Booth.fromJson(res.response.data);
        emit(FatchDataEditAndCreateEditShaktiKendraState(data: data));
      } else {
        emit(ErrorEditAndCreateEditShaktiKendraState(
            error: "Somethinfg went wrong create"));
        print('error=${res.data['message']}');
      }
    } catch (e) {
      emit(ErrorEditAndCreateEditShaktiKendraState(error: e.toString()));
      print('error=$e');
    }
  }

  apiCalling(
      {int? vidhanSabhaId,
      int? mandalId,
      String? skName,
      List? booth,
      bool? isEdit}) async {
    if (isEdit == true) {
      print(
          "=================================================== $shaktiKendrId");
      return await api
          .createAndEditShaktiKendr('Bearer ${StorageService.userAuthToken}', {
        "ac": vidhanSabhaId,
        "mandal": mandalId,
        "sk_name": skName,
        "booths": booth,
        "sk": shaktiKendrId
      });
    } else {
      return await api.createAndEditShaktiKendr(
          'Bearer ${StorageService.userAuthToken}', {
        "ac": vidhanSabhaId,
        "mandal": mandalId,
        "sk_name": skName,
        "booths": booth
      });
    }
  }

  emitState() {
    emit(LoadingEditShaktiKendraState());
  }
}
