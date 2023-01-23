

import 'package:equatable/equatable.dart';

import '../../../Network/model/data_entry_model.dart';

abstract class ZilaDataState extends Equatable {
  List<Object> get props => [];
}

class ZilaDataInitialStateState extends ZilaDataState{}
class LoadingState extends ZilaDataState{}
class DataFetchingLoadingState extends ZilaDataState{}
class EntryDataFetchedState extends ZilaDataState {
  DataEntryModel data;
  EntryDataFetchedState(this.data);
}

class ErrorState extends ZilaDataState {
  String error;
  ErrorState(this.error);
}

class ZilaChangedState extends ZilaDataState {}
