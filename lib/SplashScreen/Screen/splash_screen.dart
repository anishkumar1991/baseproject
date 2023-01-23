import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:sangathan/SplashScreen/Cubit/user_profile_cubit.dart';
import 'package:sangathan/SplashScreen/Cubit/user_profile_state.dart';
import 'package:sangathan/Storage/user_storage_service.dart';
import 'package:sangathan/Values/icons.dart';
import 'package:sangathan/route/route_path.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3), (() {
      String? token = StorageService.getUserAuthToken();
      if (token != null) {
        context.read<UserProfileCubit>().getUserProfileData();
      } else {
        Navigator.pushNamed(context, RoutePath.loginScreen);
      }
    }));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<UserProfileCubit, UserProfileState>(
        listener: (context, state) {
          if (state is UserProfileDataFetchedState) {
            Navigator.pushNamed(context, RoutePath.dashBoardScreen);
          } else if (state is UserProfileErrorState) {
            EasyLoading.showError(state.error);
          }
        },
        child: Center(
          child: Image.asset(AppIcons.sangathanLogo),
        ),
      ),
    );
  }
}
