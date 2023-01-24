import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:sangathan/splash_screen/cubit/user_profile_cubit.dart';
import 'package:sangathan/storage/user_storage_service.dart';
import 'package:sangathan/Values/icons.dart';
import 'package:sangathan/route/route_path.dart';

import '../cubit/user_profile_state.dart';

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
        Navigator.pushNamedAndRemoveUntil(
          context,
          RoutePath.loginScreen,
          (route) => false,
        );
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
            Navigator.pushNamedAndRemoveUntil(
              context,
              RoutePath.dashBoardScreen,
              (route) => false,
            );
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
