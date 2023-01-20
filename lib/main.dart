import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sangathan/AddEntry/Cubit/add_entry_cubit.dart';
import 'package:sangathan/Dashboard/Cubit/dashboard_cubit.dart';
import 'package:sangathan/Dashboard/Screen/homePage/cubit/home_page_cubit.dart';
import 'package:sangathan/Login/Cubit/login_cubit.dart';
import 'package:sangathan/SplashScreen/Cubit/user_profile_cubit.dart';
import 'package:sangathan/Utils/ConnectivityCheck/cubit/connectivity_cubit.dart';
import 'package:sangathan/Values/string.dart';
import 'package:sangathan/route/route_path.dart';
import 'package:sangathan/route/routes.dart';

void main() async {
  await GetStorage.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => InternetCubit()),
        BlocProvider(create: (context) => DashBoardCubit()),
        BlocProvider(create: (context) => HomePageCubit()),
        BlocProvider(create: (context) => LoginCubit()),
        BlocProvider(create: (context) => AddEntryCubit()),
        BlocProvider(create: (context) => UserProfileCubit())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        useInheritedMediaQuery: true,
        title: AppStrings.appTitle,
        builder: EasyLoading.init(),
        onGenerateRoute: RouteGenerator.generatorRoute,
        initialRoute: RoutePath.splashScreenPage,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
      ),
    );
  }
}
