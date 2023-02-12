
abstract class NotificationState {}

class InitialNotificationState extends NotificationState {}

class NotificationFetchingState extends NotificationState{}

class NotificationFetchedState extends NotificationState{}

class NotificationErrorState extends NotificationState {
  final String error;
  NotificationErrorState (this.error);
}