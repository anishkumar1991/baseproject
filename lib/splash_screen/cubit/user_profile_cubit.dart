import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sangathan/splash_screen/cubit/user_profile_state.dart';
import 'package:sangathan/splash_screen/network/api/user_profile_api.dart';

import '../../Dashboard/Screen/menuPage/screens/profile_screen/network/model/user_detail_model.dart';
import '../../Storage/user_storage_service.dart';

UserDetailModel userProfileModel = UserDetailModel();

class UserProfileCubit extends Cubit<UserProfileState> {
  UserProfileCubit() : super(UserProfileInitialState());

  final api = UserProfileApi(Dio(BaseOptions(
      contentType: 'application/json', validateStatus: ((status) => true))));
  Future getUserProfileData() async {
    /* try {*/
    emit(UserProfileLoadigState());
    final res = await api
        .getUserProfileDetails('Bearer ${StorageService.userAuthToken}');
    print('profile res =${res.response.statusCode}');
    print(res.data);
    if (res.response.statusCode == 200) {
      UserDetailModel data = UserDetailModel.fromJson(res.data);
      userProfileModel = data;
      emit(UserProfileDataFetchedState(data));
    } else {
      Map<String, dynamic>? msg = res.data;
      emit(UserProfileErrorState(msg?['error'] ?? ''));
    }
    /*} catch (e) {
      print(e);
      emit(UserProfileErrorState('something went wrong'));
    }*/
  }
}
