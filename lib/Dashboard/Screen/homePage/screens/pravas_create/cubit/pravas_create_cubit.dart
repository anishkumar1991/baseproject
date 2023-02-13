import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sangathan/Dashboard/Screen/homePage/screens/pravas_create/widgets/range_picker_dialog.dart';
import 'package:sangathan/Values/string.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../../../../../Storage/user_storage_service.dart';
import '../network/api/create_pravas_api.dart';
import '../network/model/create_pravas_and_function_model.dart';

part 'pravas_create_state.dart';

class PravasCreateCubit extends Cubit<PravasCreateState> {
  PravasCreateCubit() : super(PravasCreateInitial());

  final api = CreatePravas(Dio(BaseOptions(
      contentType: 'application/json', validateStatus: ((status) => true))));

  String startDate = '';
  String endDate = '';
  PickerDateRange? temp;
  int? statusCode;
  CreatePravasAndFunctionModel createPravasModel = CreatePravasAndFunctionModel();
  TextEditingController prvasNameCtr = TextEditingController();
  TextEditingController pravasSubjectCtr = TextEditingController();

  Future PravasCreate({required Map<String, dynamic> data}) async {
    emit(CreatePravasLoadingState());
    try {
      StorageService.getUserAuthToken();
      final res = await api.PravasCreate(AppStrings.apiKey,AppStrings.pravasUserToken, data);
      print(
          "------------------------------------ Create Pravas data  ----------------------------");
      print("token  :${StorageService.userAuthToken}");
      print("Status code : ${res.response.statusCode}");
      print("Header : ${res.response.headers.map}");
      print("Response :${res.data}");
      print(
          "------------------------------------ ------------------------ ----------------------------");
      statusCode = res.response.statusCode;
      if (res.response.statusCode == 200) {
        CreatePravasAndFunctionModel data = CreatePravasAndFunctionModel.fromJson(res.data);
        emit(CreatePravasFatchDataState(data: data));
      } else {
        print('error=${res.data['message']}');
        emit(CreatePravasErrorState(error: res.data['message']));
      }
    }  catch (e) {
      print(e);
      emit(CreatePravasErrorState(error: 'Something Went Wrong'));
    }
  }

  Future<void> startToEndDate(BuildContext context) async {
    emit(AddEntryLoadingState());
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return  const RangePickerDialog();
      },
    ).then((value) =>  emit(StartDateOfTour(startDate)));
  }
}
