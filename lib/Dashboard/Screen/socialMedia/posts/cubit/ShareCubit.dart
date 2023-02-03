import 'package:flutter_bloc/flutter_bloc.dart';

import 'ShareState.dart';

class ShareCubit extends Cubit<ShareState> {
  ShareCubit() : super(InitialShareState());

  void shareToAll(int index) {
    emit(ShareToAllState(index));
  }
}
