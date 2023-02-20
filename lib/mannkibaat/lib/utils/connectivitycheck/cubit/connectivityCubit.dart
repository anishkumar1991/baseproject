import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum InternetState { initial, connected, disconnected }

class InternetCubit extends Cubit<InternetState> {
  final Connectivity _connectivity = Connectivity();
  StreamSubscription? connectivitysubscription;

  InternetCubit() : super(InternetState.initial) {
    connectivitysubscription =
        _connectivity.onConnectivityChanged.listen((result) {
      if (result == ConnectivityResult.mobile || result == ConnectivityResult.wifi || result== ConnectivityResult.ethernet) {
        emit(InternetState.connected);
      } else {
        emit(InternetState.disconnected);
      }
    });
  }

  @override
  Future<void> close() {
    connectivitysubscription?.cancel();
    return super.close();
  }
}
