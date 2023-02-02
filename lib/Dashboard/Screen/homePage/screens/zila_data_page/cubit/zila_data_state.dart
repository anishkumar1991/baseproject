import 'package:equatable/equatable.dart';
import 'package:sangathan/Dashboard/Screen/homePage/screens/zila_data_page/network/model/data_unit_model.dart';
import 'package:sangathan/Dashboard/Screen/homePage/screens/zila_data_page/network/model/zila_model.dart';

import '../network/model/data_entry_model.dart';
import '../network/model/delete_reason_model.dart';

abstract class ZilaDataState extends Equatable {
  @override
  List<Object> get props => [];
}

class ZilaDataInitialStateState extends ZilaDataState {}

class LoadingState extends ZilaDataState {}

class DataFetchingLoadingState extends ZilaDataState {}

class EntryDataFetchedState extends ZilaDataState {
  final DataEntryModel data;
  EntryDataFetchedState(this.data);
}

class ErrorState extends ZilaDataState {
  final String error;
  ErrorState(this.error);
}class GetPartZilaErrorState extends ZilaDataState {
  final String error;
  GetPartZilaErrorState(this.error);
}
class GetDataUnitErrorState extends ZilaDataState {
  final String error;
  GetDataUnitErrorState(this.error);
}
class DeleteReasonErrorState extends ZilaDataState {
  final String error;
  DeleteReasonErrorState(this.error);
}
class DeletePersonErrorState extends ZilaDataState {
  final String error;
  DeletePersonErrorState(this.error);
}
class ZilaChangedState extends ZilaDataState {}

class PartyZilaSelectedState extends ZilaDataState {
  final ZilaModel data;
  PartyZilaSelectedState(this.data);
}

class UnitDataFetchedState extends ZilaDataState {
  final DataUnitModel dataUnit;
  UnitDataFetchedState(this.dataUnit);
}

class ChangeUnitData extends ZilaDataState {}

class DeleteReasonFetchedState extends ZilaDataState {
  final DeleteReasonModel deleteReason;
  DeleteReasonFetchedState(this.deleteReason);
}

class DeleteReasonSeletcedState extends ZilaDataState {}

class DeletePersonSuccessState extends ZilaDataState {
  final String message;
  DeletePersonSuccessState(this.message);
}
