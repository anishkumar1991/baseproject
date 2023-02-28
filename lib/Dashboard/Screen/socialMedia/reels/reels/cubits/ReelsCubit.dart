import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../Storage/user_storage_service.dart';
import '../network/model/ReelsModel.dart';
import '../network/services/ReelsAPI.dart';
import 'ReelsState.dart';

class ReelsCubit extends Cubit<ReelsState> {
  ReelsModel? model;

  ReelsCubit() : super(ReelsInitialState());

  final api = ReelsAPI(Dio(BaseOptions(
      contentType: 'application/json', validateStatus: ((status) => true))));

  Future getReelsData() async {
    emit(ReelsLoadingState());
    try {
      final res =
          await api.getReels('Bearer ${StorageService.userAuthToken}', "30");
      if (res.response.statusCode == 200) {
        model = ReelsModel.fromJson(res.data);

        emit(ReelsFetchedState(model!));
      } else {
        emit(ReelsErrorState());
      }
    } catch (e) {
      emit(ReelsErrorState());
    }
  }
}
