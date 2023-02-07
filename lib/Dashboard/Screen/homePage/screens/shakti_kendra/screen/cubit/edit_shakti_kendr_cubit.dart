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

  List<String> partyzilaList = ["First","Seconf","Thiurs"];
  String zilaSelected = "First";
  String mandalSelected = "First";
  String boothSelected = "First";
  Mandal mandal = Mandal();

  List chekedValue = [
    BoothSelection(id: 0,number: "125",booth: "Govt. Upper Primary School, 4-5 NWD",isCheck: false),
    BoothSelection(id: 1,number: "126",booth: "Govt. Aadarsh senior secondary school,right part sardarpura khalsa",isCheck: false),
    BoothSelection(id: 2,number: "127",booth: "Govt. Aadarsh senior secondary school,right part sardarpura khalsa",isCheck: false),
    BoothSelection(id: 3,number: "128",booth: "Govt. Aadarsh senior secondary school,right part sardarpura khalsa 2",isCheck: false),
    BoothSelection(id: 4,number: "129",booth: "Booth 2",isCheck: false),
    BoothSelection(id: 5,number: "130",booth: "Govt. Upper Primary School, 4-5 NWD",isCheck: false),
    BoothSelection(id: 6,number: "131",booth: "Govt. Upper Primary School, 4-5 NWD",isCheck: false),
  ];

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


  emitState(){
    emit(LoadingEditShaktiKendraState());
  }
}
