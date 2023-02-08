import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:sangathan/Dashboard/Screen/homePage/screens/shakti_kendra/screen/network/api/mandal_api.dart';
import 'package:sangathan/Dashboard/Screen/homePage/screens/shakti_kendra/screen/network/model/mandal_model.dart';

import '../../../../../../../Storage/user_storage_service.dart';
import '../model/booth_selection_model.dart';

part 'edit_shakti_kendr_state.dart';

class EditShaktiKendrCubit extends Cubit<EditShaktiKendrState> {
  EditShaktiKendrCubit() : super(EditShaktiKendrInitial());

  String zilaSelected = '' ;
  int? zilaId;
  String zilaSelectedName = "";
  String mandalSelected = "";
  String boothSelected = "";
  Mandal mandal = Mandal();
  Booth boothData = Booth();

  List<int> chekedValue = [  ];

  final api = GetDropDownValue(Dio(BaseOptions(
      contentType: 'application/json', validateStatus: ((status) => true))));


  Future getDropDownValueOfmandal({required int id,required int zilaId}) async {
    try {
      emit(LoadingEditShaktiKendraState());
      StorageService.getUserAuthToken();
      var res =
      await api.getMandalValue('Bearer ${StorageService.userAuthToken}',id,zilaId);
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
      print('error=$e');
    }
  }

  getBoothValuew({required int id}) async {
    try {
      emit(LoadingEditShaktiKendraState());
      StorageService.getUserAuthToken();
      var res =
          await api.getBooth('Bearer ${StorageService.userAuthToken}',id);
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


  emitState(){
    emit(LoadingEditShaktiKendraState());
  }
}
