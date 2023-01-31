import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

import '../../../../../../Storage/user_storage_service.dart';
import '../network/api/user_detail_api.dart';
import '../network/model/user_detail_model.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());

  UserDetailModel? userDetails;
  bool showAddress = false;
  bool showEducation = false;
  bool showBusiness = false;

  final api = UserDetailApi(Dio(BaseOptions(
      contentType: 'application/json', validateStatus: ((status) => true))));

  emitState() {
    return emit(ProfileInitial());
  }

  Future getUserDetails() async {
    try {
      emit(ProfileInitial());
      StorageService.getUserAuthToken();
      var res =
          await api.getDataLevel('Bearer ${StorageService.userAuthToken}');
      print('sangathan Data =${res.response.statusCode}');
      print('sangathan Data =${StorageService.userAuthToken}');
      if (res.response.statusCode == 200) {
        print(res.response.data);
        UserDetailModel data = UserDetailModel.fromJson(res.response.data);
        emit(UserDetailFetchedState(data));
      } else {
        print('error=${res.data['message']}');
        emit(ErrorState(res.data['message']));
      }
    } catch (e) {
      emit(ErrorState('Something Went Wrong'));
    }
  }
}
