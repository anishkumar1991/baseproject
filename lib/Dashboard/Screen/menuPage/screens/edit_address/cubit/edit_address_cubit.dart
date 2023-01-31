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

  emitState(){
    emit(EditAddressInitial());
  }

}
