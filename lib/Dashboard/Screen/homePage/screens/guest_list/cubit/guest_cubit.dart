import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'guest_state.dart';

class GuestCubit extends Cubit<GuestState> {
  GuestCubit() : super(GuestInitial());

  TextEditingController nameCtr = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController position = TextEditingController();

}
