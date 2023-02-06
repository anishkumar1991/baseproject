import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../../../generated/l10n.dart';

part 'shakti_kendra_state.dart';

class ShaktiKendraCubit extends Cubit<ShaktiKendraState> {
  ShaktiKendraCubit() : super(ShaktiKendraInitial());

  String zilaSelected = "First";
  int isSelectedIndex = 0;
  bool isExpanded = false;
  List<String> partyzilaList = ["First","Seconf","Thiurs"];
  List<String> filterList = ["नवीन एंट्री","मंडल","A - Z"];

  emitState(){
    emit(LoadingShaktiKendraState());
  }

  void onChnageZila(String? value) {
    emit(LoadingShaktiKendraState());
    zilaSelected = value!;
    emit(ZilaChangedShaktiKendraState());
  }

  changeFilter(){
    emit(LoadingShaktiKendraState());
    // emit(FilterChangeState());
  }
}
