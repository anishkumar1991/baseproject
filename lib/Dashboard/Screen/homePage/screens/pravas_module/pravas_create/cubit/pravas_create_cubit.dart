import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../../../../../../Storage/user_storage_service.dart';
import '../network/api/create_pravas_api.dart';
import '../network/model/create_pravas_and_function_model.dart';

part 'pravas_create_state.dart';

class PravasCreateCubit extends Cubit<PravasCreateState> {
  PravasCreateCubit() : super(PravasCreateInitial());
  final api = CreatePravas(Dio(BaseOptions(
      contentType: 'application/json', validateStatus: ((status) => true))));

  String startDate = '';
  DateTime dateTimeStart = DateTime.now();
  String endDate = '';
  DateTime endTimeStart = DateTime.now();
  PickerDateRange? temp;
  int? statusCode;
  CreatePravasAndFunctionModel createPravasModel =
      CreatePravasAndFunctionModel();
  TextEditingController prvasNameCtr = TextEditingController();
  TextEditingController pravasSubjectCtr = TextEditingController();

  final FocusNode pravasNameFocusNode = FocusNode();
  final FocusNode subjectFocusNode = FocusNode();

  Future PravasCreate() async {
    emit(CreatePravasLoadingState());
    try {
      StorageService.getUserAuthToken();
      final res = await api.pravasCreate(prvasNameCtr.text, startDate, endDate,
          pravasSubjectCtr.text, StorageService.userAuthToken ?? '');
      print(
          "------------------------------------ Create Pravas data  ----------------------------");
      print("Status code : ${res.response.statusCode}");
      print("Response :${res.data}");
      print(
          "------------------------------------ ------------------------ ----------------------------");
      statusCode = res.response.statusCode;
      if (res.response.statusCode == 200) {
        CreatePravasAndFunctionModel data =
            CreatePravasAndFunctionModel.fromJson(res.data);
        emit(CreatePravasFatchDataState(data: data));
      } else {
        print('error=${res.data['message']}');
        emit(CreatePravasErrorState(error: res.data['message']));
      }
    } catch (e) {
      print(e);
      emit(CreatePravasErrorState(error: 'Something Went Wrong'));
    }
  }

  Future<void> pravasStartDate(BuildContext context) async {
    emit(StartDateLoadingState());
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(
            DateTime.now().year - 1, DateTime.now().month, DateTime.now().day),
        lastDate: DateTime(
            DateTime.now().year, DateTime.now().month, DateTime.now().day));
    if (picked != null && picked != dateTimeStart) {
      dateTimeStart = picked;
      startDate = ddMMMYYYYfromDateTime(dateTimeStart);
      print(startDate);
      emit(StartDateOfTour(startDate));
    }
    // showDialog(
    //   context: context,
    //   barrierDismissible: false,
    //   builder: (BuildContext context) {
    //     return  const RangePickerDialog();
    //   },
    // ).then((value) =>  emit(StartDateOfTour(startDate)));
  }

  Future<void> pravasEndDate(BuildContext context) async {
    emit(EndDateLoadingState());
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(
            dateTimeStart.year, dateTimeStart.month, dateTimeStart.day),
        lastDate: DateTime(2050, 12, 1));
    if (picked != null && picked != endTimeStart) {
      endTimeStart = picked;
      endDate = ddMMMYYYYfromDateTime(endTimeStart);
      print(endDate);
      emit(EndDateOfTour(endDate));
    }
    // showDialog(
    //   context: context,
    //   barrierDismissible: false,
    //   builder: (BuildContext context) {
    //     return  const RangePickerDialog();
    //   },
    // ).then((value) =>  emit(StartDateOfTour(startDate)));
  }

  static String ddMMMYYYYfromDateTime(DateTime date) {
    return DateFormat('dd/MM/yyyy').format(date);
  }
}
