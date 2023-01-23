import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'pravas_list_state.dart';

class PravasListCubit extends Cubit<PravasListState> {
  PravasListCubit() : super(PravasListInitial());
}
