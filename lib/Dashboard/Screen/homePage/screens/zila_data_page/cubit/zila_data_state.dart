import 'package:equatable/equatable.dart';
import 'package:sangathan/Dashboard/Screen/homePage/screens/zila_data_page/network/model/filter_data_model.dart';
import 'package:sangathan/Dashboard/Screen/homePage/screens/zila_data_page/network/model/zila_model.dart';

import '../network/model/data_entry_model.dart';

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
}

class ZilaChangedState extends ZilaDataState {}

class PartyZilaSelectedState extends ZilaDataState {
  final ZilaModel data;
  PartyZilaSelectedState(this.data);
}

class FilterDataFetchedState extends ZilaDataState {
  final FilterDataModel filterdata;
  FilterDataFetchedState(this.filterdata);
}

class FilterDataSelectedState extends ZilaDataState{
  
}
