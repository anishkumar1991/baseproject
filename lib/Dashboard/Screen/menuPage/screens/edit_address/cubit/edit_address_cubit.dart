import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../network/api/state_api.dart';
import '../network/model/state_model.dart';

part 'edit_address_state.dart';

class EditAddressCubit extends Cubit<EditAddressState> {
  EditAddressCubit() : super(EditAddressInitial());

  final TextEditingController flatDesCtr = TextEditingController();
  final TextEditingController areaDesCtr = TextEditingController();
  final TextEditingController pinCodeCtr = TextEditingController();
  final TextEditingController townCtr = TextEditingController();
  final TextEditingController stateCtr = TextEditingController();

  String? addressFor;
  final formKey = GlobalKey<FormState>();
  List<CountryState> countryState = [];

  final api = GetStateAPi(Dio(BaseOptions(
      contentType: 'application/json', validateStatus: ((status) => true))));

  clearData(){
    flatDesCtr.clear();
    areaDesCtr.clear();
    pinCodeCtr.clear();
    townCtr.clear();
    stateCtr.clear();
    addressFor = null;
  }
  bool checkIfEmpty() {
    bool isEmpty = false;
    if (flatDesCtr.text.isEmpty) {
      if(areaDesCtr.text.isEmpty){
        if(pinCodeCtr.text.isEmpty){
          if(townCtr.text.isEmpty){
            if(stateCtr.text.isEmpty){
              isEmpty = true;
            }
          }
        }
      }
    }
    return isEmpty;
  }

  emitState(){
    emit(EditAddressInitial());
  }

  Future getState() async {
    try {
      emit(GetStateLoadingState());
      var res =
      await api.getCountyState();
      print(
          "------------------------------------ County State data  ----------------------------");
      print("Status code : ${res.response.statusCode}");
      print("Response :${res.data}");
      print(
          "------------------------------------ ------------------------ ----------------------------");
      if (res.response.statusCode == 200) {
        List data = jsonDecode(res.response.data);
        print("=============>> data    $data");
        var dataLocation =
        data.map((data) => CountryState.fromJson(data)).toList();
        List<CountryState> sortedIndiaStateList = [];
        if(dataLocation.isNotEmpty || dataLocation != null){
          for(int i = 0; i < dataLocation.length ; i++){
            if(dataLocation[i].country == 'India'){
              sortedIndiaStateList.add(dataLocation[i]);
            }
          }
        }
        emit(GetStateFatchDataState(sortedIndiaStateList));
      } else {
        print('error=${res.data['message']}');
        emit(GetStateErrorState(res.data['message']));
      }
    } catch (e) {
      emit(GetStateErrorState('Something Went Wrong'));
    }
  }

}
