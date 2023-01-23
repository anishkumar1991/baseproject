import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sangathan/AddEntry/Cubit/add_entry_cubit.dart';
import 'package:sangathan/Dashboard/Cubit/dashboard_cubit.dart';
import 'package:sangathan/Dashboard/Screen/homePage/cubit/home_page_cubit.dart';
import 'package:sangathan/Dashboard/Screen/homePage/screens/pravas_create/cubit/pravas_create_cubit.dart';
import 'package:sangathan/Dashboard/Screen/homePage/screens/zila_data_page/cubit/zila_data_cubit.dart';
import 'package:sangathan/Login/Cubit/login_cubit.dart';
import 'package:sangathan/SplashScreen/Cubit/user_profile_cubit.dart';
import 'package:sangathan/Utils/ConnectivityCheck/cubit/connectivity_cubit.dart';
import 'package:sangathan/Values/string.dart';
import 'package:sangathan/route/route_path.dart';
import 'package:sangathan/route/routes.dart';
import 'Dashboard/Screen/homePage/screens/edit_date/cubit/edit_date_cubit.dart';
import 'Dashboard/Screen/homePage/screens/create_function_page/create_function_cubit/create_function_cubit.dart';
import 'Dashboard/Screen/homePage/screens/pravas_list/pravas_cubit/pravas_list_cubit.dart';

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
        BlocProvider(create: (context) => PravasCreateCubit()),
        BlocProvider(create: (context) => EditDateCubit()),
        BlocProvider(create: (context) => UserProfileCubit()),
        BlocProvider(create: (context) => UserProfileCubit()),
        BlocProvider(create: (context) => PravasListCubit()),
        BlocProvider(create: (context) => CreateFunctionCubit()),
        BlocProvider(create: (context) => ZilaDataCubit()),
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
