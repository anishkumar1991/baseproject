import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sangathan/Dashboard/Screen/homePage/screens/shakti_kendra/screen/network/api/mandal_api.dart';

import '../../../../../../../Storage/user_storage_service.dart';
import '../../network/model/shakti_kendr_model.dart';
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
  List<Mandal>? mandalDropDownList;
  BoothListData boothData = BoothListData();
  TextEditingController shaktiKendrCtr = TextEditingController();
  List<Booth> selectedBoothDetails = [];

  List<Booth> chekedValue = [];
  List<int> selectedBooth = [];
  List<Booth> alreadyExitBooth = [];

  final api = GetDropDownValue(Dio(BaseOptions(contentType: 'application/json', validateStatus: ((status) => true))));

  alreadyExitBoothInOtherSk(
      {required Booth? booth, required bool isAdd, required List<ShaktiKendrData> shaktiKendrDataList}) {
    for (int i = 0; i < shaktiKendrDataList.length; i++) {
      for (int j = 0; j < (shaktiKendrDataList[i].booths?.length ?? 0); j++) {
        if (shaktiKendrDataList[i].booths?[j].id == booth?.id) {
          if (isAdd == true) {
            alreadyExitBooth.add(booth ?? Booth());
            emit(AlreadyExistBoothFatchDataState());
          } else {
            alreadyExitBooth.remove(booth);
            emit(AlreadyExistBoothFatchDataState());
          }
        }
      }
    }
  }

  removeSelectedBooth({required Booth showSelectedBooth}) {
    chekedValue.removeWhere((element) => element.id == showSelectedBooth.id);
    alreadyExitBooth.removeWhere((element) => element.id == showSelectedBooth.id);
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
      var res = await api.getMandalValue('Bearer ${StorageService.userAuthToken}', id);
      print("------------------------------------ Mandal DropDownValue  ----------------------------");
      print(res.response.realUri);
      print("token  :${StorageService.userAuthToken}");
      print("Status code : ${res.response.statusCode}");
      print("Response :${res.data}");
      print("------------------------------------ ------------------------ ----------------------------");
      if (res.response.statusCode == 200) {
        if (res.data["data"] != null) {
          List data = res.data["data"];
          var dataMandal = data.map((data) => Mandal.fromJson(data)).toList();
          /*if (isEdit == true) {
            await getBoothValuew(id: id);
          }*/
          emit(FatchDataMandalEditShaktiKendraState(data: dataMandal));
        } else {
          emit(ErrorMandalEditShaktiKendraState(error: "Something went wrong"));
        }
      } else {
        emit(ErrorMandalEditShaktiKendraState(error: "Something went wrong"));
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
      var res = await api.getBooth('Bearer ${StorageService.userAuthToken}', id);
      print("------------------------------------ booth DropDownValue  ----------------------------");
      print(res.response.realUri);
      print("token  :${StorageService.userAuthToken}");
      print("Status code : ${res.response.statusCode}");
      print("Response :${res.data}");
      print("------------------------------------ ------------------------ ----------------------------");
      if (res.response.statusCode == 200) {
        BoothListData data = BoothListData.fromJson(res.response.data);
        // boothData = data;
        emit(FatchDataBoothEditShaktiKendraState(data: data));
      } else {
        emit(ErrorBoothEditShaktiKendraState(error: "Something went wrong booth"));
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
          isEdit: isEdit, booth: booth, mandalId: mandalId, vidhanSabhaId: vidhanSabhaId, skName: skName);
      print("------------------------------------ createShaktiKendr DropDownValue  ----------------------------");
      print("token  :${StorageService.userAuthToken}");
      print("Status code : ${res.response.statusCode}");
      print("Response :${res.data}");
      print("------------------------------------ ------------------------ ----------------------------");
      if (res.response.statusCode == 200) {
        BoothListData data = BoothListData.fromJson(res.response.data);
        emit(FatchDataEditAndCreateEditShaktiKendraState(data: data));
      } else {
        emit(ErrorEditAndCreateEditShaktiKendraState(error: "Somethinfg went wrong create"));
        print('error=${res.data['message']}');
      }
    } catch (e) {
      emit(ErrorEditAndCreateEditShaktiKendraState(error: e.toString()));
      print('error=$e');
    }
  }

  apiCalling({int? vidhanSabhaId, int? mandalId, String? skName, List? booth, bool? isEdit}) async {
    if (isEdit == true) {
      print("=================================================== $shaktiKendrId");
      return await api.createAndEditShaktiKendr('Bearer ${StorageService.userAuthToken}',
          {"ac": vidhanSabhaId, "mandal": mandalId, "sk_name": skName, "booths": booth, "sk": shaktiKendrId});
    } else {
      return await api.createAndEditShaktiKendr('Bearer ${StorageService.userAuthToken}',
          {"ac": vidhanSabhaId, "mandal": mandalId, "sk_name": skName, "booths": booth});
    }
  }

  emitState() {
    emit(LoadingEditShaktiKendraState());
  }
}
