import 'package:sangathan/mannkibaat/lib/attendeesformpage/review/network/model/SendEventDetails.dart';

abstract class SendEventState {}

class InitialState extends SendEventState {}

class EventSendState extends SendEventState {}

class EventErrorState extends SendEventState {
  final String error;

  EventErrorState(this.error);
}

class EventSendingState extends SendEventState{}
