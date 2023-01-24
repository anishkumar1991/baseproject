
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'pravas_list_state.dart';

class PravasListCubit extends Cubit<PravasListState> {
  PravasListCubit() : super(PravasListInitial());
}
