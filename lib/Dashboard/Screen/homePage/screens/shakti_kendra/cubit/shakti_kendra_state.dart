part of 'shakti_kendra_cubit.dart';

@immutable
abstract class ShaktiKendraState {}

class ShaktiKendraInitial extends ShaktiKendraState {}

class LoadingShaktiKendraState extends ShaktiKendraInitial {}

class ZilaChangedShaktiKendraState extends ShaktiKendraInitial {}

class FilterChangeState extends ShaktiKendraInitial {}

class ShaktiKendraErrorState extends ShaktiKendraInitial {
  final String error;

  ShaktiKendraErrorState(this.error);
}

class DeleteShaktiKendraErrorState extends ShaktiKendraInitial {
  final String data;

  DeleteShaktiKendraErrorState(this.data);
}

class ShaktiKendraFatchData extends ShaktiKendraInitial {
  final ShaktiKendr data;

  ShaktiKendraFatchData(this.data);
}
