import 'package:flutter_bloc/flutter_bloc.dart';
import 'DatePicState.dart';

class DatePicCubit extends Cubit<DatePicState> {
  DatePicCubit() : super(InitialDatePicState());

  void datePicked(datePicked) {
    emit(DatePickedStateState(datePicked));
  }

  void dateRemoved() {
    emit(InitialDatePicState());
  }
}
