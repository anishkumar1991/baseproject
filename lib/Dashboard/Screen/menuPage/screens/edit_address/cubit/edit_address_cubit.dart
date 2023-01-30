import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'edit_address_state.dart';

class EditAddressCubit extends Cubit<EditAddressState> {
  EditAddressCubit() : super(EditAddressInitial());

  final TextEditingController flatDesCtr = TextEditingController();
  final TextEditingController areaDesCtr = TextEditingController();
  final TextEditingController pinCodeCtr = TextEditingController();
  final TextEditingController townCtr = TextEditingController();
  final TextEditingController stateCtr = TextEditingController();

  emitState(){
    emit(EditAddressInitial());
  }

}
