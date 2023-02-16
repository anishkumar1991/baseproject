part of 'edit_address_cubit.dart';

@immutable
abstract class EditAddressState {}

class EditAddressInitial extends EditAddressState {}

/// for county state
class GetStateLoadingState extends EditAddressState {}
class GetStateFatchDataState extends EditAddressState {
  List<CountryState> data;
  GetStateFatchDataState(this.data);
}
class GetStateErrorState extends EditAddressState {
  String? error;
  GetStateErrorState(this.error);
}
