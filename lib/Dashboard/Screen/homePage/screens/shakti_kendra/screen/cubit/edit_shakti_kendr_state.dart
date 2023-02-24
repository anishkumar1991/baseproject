part of 'edit_shakti_kendr_cubit.dart';

@immutable
abstract class EditShaktiKendrState {}

class EditShaktiKendrInitial extends EditShaktiKendrState {}

class LoadingEditShaktiKendraState extends EditShaktiKendrInitial {}

class LoadingMandalEditShaktiKendraState extends EditShaktiKendrInitial {}

class FatchDataMandalEditShaktiKendraState extends EditShaktiKendrInitial {
  final List<Mandal> data;

  FatchDataMandalEditShaktiKendraState({required this.data});
}

class ErrorMandalEditShaktiKendraState extends EditShaktiKendrInitial {
  final String error;

  ErrorMandalEditShaktiKendraState({required this.error});
}

class LoadingBoothEditShaktiKendraState extends EditShaktiKendrInitial {}

class FatchDataBoothEditShaktiKendraState extends EditShaktiKendrInitial {
  final BoothListData data;

  FatchDataBoothEditShaktiKendraState({required this.data});
}

class ErrorBoothEditShaktiKendraState extends EditShaktiKendrInitial {
  final String error;

  ErrorBoothEditShaktiKendraState({required this.error});
}

class LoadingEditAndCreateEditShaktiKendraState extends EditShaktiKendrInitial {}

class FatchDataEditAndCreateEditShaktiKendraState extends EditShaktiKendrInitial {
  final BoothListData data;

  FatchDataEditAndCreateEditShaktiKendraState({required this.data});
}

class ErrorEditAndCreateEditShaktiKendraState extends EditShaktiKendrInitial {
  final String error;

  ErrorEditAndCreateEditShaktiKendraState({required this.error});
}

class AlreadyExistBoothFatchDataState extends EditShaktiKendrInitial {}
