import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

import '../../../../../../AddEntry/network/model/category_model.dart';
import '../../../../../../Storage/user_storage_service.dart';
import '../network/api/user_detail_api.dart';
import '../network/model/user_detail_model.dart';

part 'profile_state.dart';
DropdownValueModel? dropDownValue;

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());

  UserDetailModel? userDetails;
  bool showAddress = false;
  bool showEducation = false;
  bool showBusiness = false;

  final api = UserDetailApi(Dio(BaseOptions(
      contentType: 'application/json', validateStatus: ((status) => true))));

  emitState() {
    emit(ProfileInitial());
  }

  Future getUserDetails() async {
    try {
      emit(ProfileLoadingState());
      StorageService.getUserAuthToken();
      var res =
          await api.getDataLevel('Bearer ${StorageService.userAuthToken}');
      print(
          "------------------------------------ User profile data  ----------------------------");
      print("token  :${StorageService.userAuthToken}");
      print("Status code : ${res.response.statusCode}");
      print("Response :${res.data}");
      print(
          "------------------------------------ ------------------------ ----------------------------");
      if (res.response.statusCode == 200) {
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

  Future getDropdownData() async {
    try {
      emit(ProfileInitial());
      final res = await api.getDropdownValues(
        'Bearer ${StorageService.userAuthToken}',
      );
      print('dropdown res =${res.response}');
      if (res.response.statusCode == 200) {
        DropdownValueModel data = DropdownValueModel.fromJson(res.data);
        dropDownValue = data;
        emit(DropDownFetchedState(data));
      } else {
        Map<String, dynamic>? msg = res.data;
        emit(DropDownErrorState(msg?['errors'] ?? ''));
      }
    } catch (e) {
      emit(DropDownErrorState('Something Went Wrong'));
    }
  }


}
