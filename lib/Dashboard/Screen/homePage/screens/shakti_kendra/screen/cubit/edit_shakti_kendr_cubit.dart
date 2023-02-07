import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'edit_shakti_kendr_state.dart';

class EditShaktiKendrCubit extends Cubit<EditShaktiKendrState> {
  EditShaktiKendrCubit() : super(EditShaktiKendrInitial());

  List<String> partyzilaList = ["First","Seconf","Thiurs"];
  String zilaSelected = "First";
  String mandalSelected = "First";
  String boothSelected = "First";

  emitState(){
    emit(LoadingEditShaktiKendraState());
  }
}
