import 'package:equatable/equatable.dart';
import 'package:sangathan/Dashboard/Screen/homePage/screens/sangathan_details/network/model/sangathan_data_model.dart';

import '../network/model/alloted_location_model.dart';

abstract class SangathanDetailsState extends Equatable {
  @override
  List<Object> get props => [];
}

class InitialStateState extends SangathanDetailsState {}

class LoadingState extends SangathanDetailsState {}

class DataLevelFetchedState extends SangathanDetailsState {
 final SangthanDataModel data;
  DataLevelFetchedState(this.data);
}

class ErrorState extends SangathanDetailsState {
  final String error;
  ErrorState(this.error);
}

class LocationFetchedState extends SangathanDetailsState {
  final AllotedLocationModel locationData;
  LocationFetchedState(this.locationData);
}

class LocationChoosedState extends SangathanDetailsState{}