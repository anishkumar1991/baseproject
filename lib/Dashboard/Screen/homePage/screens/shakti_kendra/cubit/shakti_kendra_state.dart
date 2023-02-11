part of 'shakti_kendra_cubit.dart';

@immutable
abstract class ShaktiKendraState {}

class ShaktiKendraInitial extends ShaktiKendraState {}

class LoadingShaktiKendraState extends ShaktiKendraInitial {}

class FatchDataVidhanSabhaState extends ShaktiKendraInitial {
  final VidhanSabha data;

  FatchDataVidhanSabhaState(this.data);
}

class ErrorVidhanSabhaState extends ShaktiKendraInitial {
  final String error;

  ErrorVidhanSabhaState({required this.error});
}

class LoadingShaktiKendraDetailState extends ShaktiKendraInitial {}

class ZilaChangedShaktiKendraState extends ShaktiKendraInitial {}

class FilterChangeState extends ShaktiKendraInitial {}

class ShaktiKendraErrorState extends ShaktiKendraInitial {
  final String error;

  ShaktiKendraErrorState(this.error);
}
class DeleteDataShaktiKendraLoadingState extends ShaktiKendraInitial {}


class DeleteShaktiKendraErrorState extends ShaktiKendraInitial {
  final String error;

  DeleteShaktiKendraErrorState(this.error);
}

class DeleteShaktiKendraFatchDataState extends ShaktiKendraInitial {
  final DeleteModel data;

  DeleteShaktiKendraFatchDataState(this.data);
}



class ShaktiKendraFatchData extends ShaktiKendraInitial {
  final ShaktiKendr data;

  ShaktiKendraFatchData(this.data);
}
