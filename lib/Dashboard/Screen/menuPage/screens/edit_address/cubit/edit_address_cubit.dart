import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
}
