part of 'guest_cubit.dart';

@immutable
abstract class GuestState {}

class GuestInitial extends GuestState {}

/// create guest
class CreateGuestLoadingState extends GuestInitial {}
class CreateGuestFatchDataState extends GuestInitial {
  CreatePravasAndFunctionModel? data;
  CreateGuestFatchDataState({this.data});
}
class CreateGuestErrorState extends GuestInitial {
  String? error;
  CreateGuestErrorState({this.error});
}

/// get guest
class GetGuestLoadingState extends GuestInitial {}
class GetGuestFatchDataState extends GuestInitial {
  GuestList? data;
  GetGuestFatchDataState({this.data});
}
class GetGuestErrorState extends GuestInitial {
  String? error;
  GetGuestErrorState({this.error});
}