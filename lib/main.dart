import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sangathan/AddEntry/Cubit/add_entry_cubit.dart';
import 'package:sangathan/Dashboard/Cubit/dashboard_cubit.dart';
import 'package:sangathan/Dashboard/Screen/homePage/cubit/home_page_cubit.dart';
import 'package:sangathan/Dashboard/Screen/homePage/screens/pravas_create/cubit/pravas_create_cubit.dart';
import 'package:sangathan/Dashboard/Screen/homePage/screens/sangathan_details/cubit/sangathan_detail_cubit.dart';
import 'package:sangathan/Dashboard/Screen/homePage/screens/zila_data_page/cubit/zila_data_cubit.dart';
import 'package:sangathan/Login/Cubit/login_cubit.dart';
import 'package:sangathan/Utils/ConnectivityCheck/cubit/connectivity_cubit.dart';
import 'package:sangathan/Values/app_colors.dart';
import 'package:sangathan/Values/string.dart';
import 'package:sangathan/route/route_path.dart';
import 'package:sangathan/route/routes.dart';

import 'Dashboard/Screen/homePage/screens/create_function_page/create_function_cubit/create_function_cubit.dart';
import 'Dashboard/Screen/homePage/screens/edit_date/cubit/edit_date_cubit.dart';
import 'Dashboard/Screen/homePage/screens/guest_list/cubit/guest_cubit.dart';
import 'Dashboard/Screen/homePage/screens/pravas_list/pravas_cubit/pravas_list_cubit.dart';
import 'generated/l10n.dart';
import 'notification_handler/firebase_notification_handler.dart';
import 'notification_handler/local_notification_handler.dart';
import 'splash_screen/cubit/user_profile_cubit.dart';

Future<void> _firebaseMessagingBackgroundHandler(
  RemoteMessage message,
) async {
  debugPrint(
      "Handling a background message:---------------- ${message.messageId}");
  debugPrint("Handling a background message:-------------- ${message.data}");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    LocalNotificationService.initialize(context);
    firebaseNotification(context);
    super.initState();
  }

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
        BlocProvider(create: (context) => GuestCubit()),
        BlocProvider(create: (context) => ZilaDataCubit()),
        BlocProvider(create: (context) => SangathanDetailsCubit()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        useInheritedMediaQuery: true,
        title: AppStrings.appTitle,
        builder: EasyLoading.init(),
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
        locale: const Locale.fromSubtags(languageCode: 'hi'),
        onGenerateRoute: RouteGenerator.generatorRoute,
        initialRoute: RoutePath.splashScreenPage,
        theme: Theme.of(context).copyWith(
          colorScheme: Theme.of(context).colorScheme.copyWith(
                primary: AppColor.primaryColor,
              ),
        ),
      ),
    );
  }
}
