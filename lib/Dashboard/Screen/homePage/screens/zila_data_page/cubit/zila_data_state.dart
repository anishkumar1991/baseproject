

import 'package:equatable/equatable.dart';

import '../network/model/data_entry_model.dart';

abstract class ZilaDataState extends Equatable {
  @override
  List<Object> get props => [];
}

class ZilaDataInitialStateState extends ZilaDataState{}
class LoadingState extends ZilaDataState{}
class DataFetchingLoadingState extends ZilaDataState{}
class EntryDataFetchedState extends ZilaDataState {
 final DataEntryModel data;
  EntryDataFetchedState(this.data);
}

class ErrorState extends ZilaDataState {
 final String error;
  ErrorState(this.error);
}

class ZilaChangedState extends ZilaDataState {}
