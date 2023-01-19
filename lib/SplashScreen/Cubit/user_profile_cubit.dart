import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sangathan/SplashScreen/Cubit/user_profile_state.dart';
import 'package:sangathan/SplashScreen/Network/api/user_profile_api.dart';
import 'package:sangathan/SplashScreen/Network/model/user_profile_model.dart';
import 'package:sangathan/Storage/user_storage_service.dart';

class UserProfileCubit extends Cubit<UserProfileState> {
  UserProfileCubit() : super(UserProfileInitialState());

  final api = UserProfileApi(Dio(BaseOptions(
      contentType: 'application/json', validateStatus: ((status) => true))));
  Future getUserProfileData() async {
    try {
      emit(UserProfileLoadigState());
      String? token = StorageService.getUserAuthToken();
      final res = await api.getUserProfileDetails('Bearer $token');
      print('profile res =${res.response.statusCode}');
      print(res.data);
      if (res.response.statusCode == 200) {
        UserProfileModel data = UserProfileModel.fromJson(res.data);
        emit(UserProfileDataFetchedState(data));
      } else {
        Map<String, dynamic>? msg = res.data;
        emit(UserProfileErrorState(msg?['error'] ?? ''));
      }
    } catch (e) {
      emit(UserProfileErrorState(e.toString()));
    }
  }
}
