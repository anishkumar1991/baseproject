import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:sangathan/Storage/mannkibaat.dart';
import '../../../../Values/string.dart';
import '../network/model/Booth.dart';
import '../network/model/VidhanSabhaModel.dart';
import '../network/services/FetchAPI.dart';
import 'FetchStates.dart';

class FetchCubit extends Cubit<FetchStates> {
  final api = FetchAPI(Dio(BaseOptions(
      contentType: 'application/json', validateStatus: ((status) => true))));



  FetchCubit() : super(InitialState());
  static String vidhanSabhaName = "vidhanSabhaName";
  static String acId = "acId";
  static String skId = "skId";
  static String boothName = "boothName";
  String vidhansabhaname = " ";
  String boothname = " ";
  int? boothid ;
  List<ApiDataList> acList = [];
  List<Datum> boothList = [];
  Datum? boothSelected;
  ApiDataList? vidhanSabhaSelected;

  void onChangeVidhanSabha(ApiDataList vidhanSabhaName) {
    emit(FetchingState());
    vidhanSabhaSelected = vidhanSabhaName;
    vidhansabhaname = vidhanSabhaSelected!.name;
    boothSelected = null;
    fetchBooth(vidhanSabhaSelected!.id.toString());
    emit(DropDownSelected());
  }

  void onChangeBooth(Datum boothName) {
    emit(FetchingState());
    boothSelected = boothName;
    boothname = boothSelected!.name;
    boothid = boothSelected!.id;
    emit(DropDownSelected());
  }

  Future fetchAcId() async {
    try {
      String? _auth =
          "eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxfQ.1aBzmXruUAVV7ancpI1gu6GhOSso9xUqONf2DZ9ICmA";
      print(_auth);
      final res = await api.fetchAc(_auth, AppStrings.countrystateid);
      if (res.response.statusCode == 200) {
        print("FetchAcId working");
        States model = States.fromJson(res.data);
        print('profile res = ${res.response.statusCode}');
        print(res.response.data);
        // print("232ejri3or "+model.data.first.name);
        var jsonsDataString = json.decode(json.encode(res.response
            .data)); // toString of Response's body is assigned to jsonDataString
        emit(FetchedState(model));
        return res;
      } else {
        print("not api FetchAcId working");
        // State? model = States.fromJson(res.data);
        // emit(LoginFaieldState(model.message ?? ''));
      }
    } on Exception catch (e) {
      print(e.toString());
      // LoginFaieldState(e.toString());
    }
  }

  Future fetchBooth(String boothAcId) async {
    try {
      String? _auth =
          MKBStorageService.userAuthToken;
      print(_auth);
      final res = await api.fetchBooth(_auth, boothAcId);
      if (res.response.statusCode == 200) {
        print("booth fetching working");
        Booth model = Booth.fromJson(res.data);
        print('profile res =${res.response.statusCode}');
        // print("232ejri3or "+model.data.first.name);
        print(res.response.data);
        emit(BoothFetchedState(model));
        var jsonsDataString = json.decode(json.encode(res.response
            .data)); // toString of Response's body is assigned to jsonDataString

        return res;
      } else {
        print("booth fetching not working");
        // State? model = States.fromJson(res.data);
        // emit(LoginFaieldState(model.message ?? ''));
      }
    } on Exception catch (e) {
      print(e.toString());
      // LoginFaieldState(e.toString());
    }
  }
}
