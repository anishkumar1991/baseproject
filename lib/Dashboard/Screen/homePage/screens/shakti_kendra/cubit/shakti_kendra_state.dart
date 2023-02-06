part of 'shakti_kendra_cubit.dart';

@immutable
abstract class ShaktiKendraState {}

class ShaktiKendraInitial extends ShaktiKendraState {}
class LoadingShaktiKendraState extends ShaktiKendraInitial {}
class ZilaChangedShaktiKendraState extends ShaktiKendraInitial {}
class FilterChangeState extends ShaktiKendraInitial {}
