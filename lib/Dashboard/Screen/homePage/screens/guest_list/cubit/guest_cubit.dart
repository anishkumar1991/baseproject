import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

part 'guest_state.dart';

class GuestCubit extends Cubit<GuestState> {
  GuestCubit() : super(GuestInitial());

  TextEditingController nameCtr = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController position = TextEditingController();

}
