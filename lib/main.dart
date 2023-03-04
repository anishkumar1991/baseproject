import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sangathan/AddEntry/VerifyPerson/cubit/verify_person_cubit.dart';
import 'package:sangathan/Dashboard/Cubit/dashboard_cubit.dart';
import 'package:sangathan/Dashboard/Screen/homePage/cubit/home_page_cubit.dart';
import 'package:sangathan/Dashboard/Screen/homePage/screens/sangathan_details/cubit/sangathan_detail_cubit.dart';
import 'package:sangathan/Dashboard/Screen/homePage/screens/zila_data_page/cubit/zila_data_cubit.dart';
import 'package:sangathan/Dashboard/Screen/notification/cubit/DatePicCubit.dart';
import 'package:sangathan/Dashboard/Screen/notification/cubit/NotificationCubit.dart';
import 'package:sangathan/Dashboard/Screen/socialMedia/posts/cubit/PollsCubit.dart';
import 'package:sangathan/Dashboard/Screen/socialMedia/posts/cubit/SendFcmTokenCubit.dart';
import 'package:sangathan/Dashboard/Screen/socialMedia/reels/horizontaltile/cubit/HorizontalTileCubit.dart';
import 'package:sangathan/Dashboard/Screen/socialMedia/reels/reels/cubits/ReelsCubit.dart';
import 'package:sangathan/Login/Cubit/login_cubit.dart';
import 'package:sangathan/Utils/ConnectivityCheck/cubit/connectivity_cubit.dart';
import 'package:sangathan/Values/app_colors.dart';
import 'package:sangathan/Values/string.dart';

// import 'mannkibaat/lib/attendeesformpage/cubit/FetchCubit.dart';
// import 'mannkibaat/lib/reportedprogramspage/cubit/DashCubit.dart';
import 'package:sangathan/mannkibaat/lib/attendeesformpage/cubit/FetchCubit.dart';
import 'package:sangathan/mannkibaat/lib/attendeesformpage/review/cubit/SendEventCubit.dart';
import 'package:sangathan/mannkibaat/lib/generateauthtoken/cubit/SendCubit.dart';
import 'package:sangathan/mannkibaat/lib/reportedprogramspage/cubit/DashCubit.dart';
import 'package:sangathan/route/route_path.dart';
import 'package:sangathan/route/routes.dart';

import 'AddEntry/Cubit/add_entry_cubit.dart';
import 'Dashboard/Screen/homePage/screens/pravas_module/create_function_page/create_function_cubit/create_function_cubit.dart';
import 'Dashboard/Screen/homePage/screens/pravas_module/edit_date/cubit/edit_date_cubit.dart';
import 'Dashboard/Screen/homePage/screens/pravas_module/guest_list/cubit/guest_cubit.dart';
import 'Dashboard/Screen/homePage/screens/pravas_module/pravas_create/cubit/pravas_create_cubit.dart';
import 'Dashboard/Screen/homePage/screens/pravas_module/pravas_list/pravas_cubit/pravas_list_cubit.dart';
import 'Dashboard/Screen/homePage/screens/shakti_kendra/cubit/shakti_kendra_cubit.dart';
import 'Dashboard/Screen/homePage/screens/shakti_kendra/screen/cubit/edit_shakti_kendr_cubit.dart';
import 'Dashboard/Screen/menuPage/cubit/menu_screen_cubit.dart';
import 'Dashboard/Screen/menuPage/screens/edit_address/cubit/edit_address_cubit.dart';
import 'Dashboard/Screen/menuPage/screens/edit_business/cubit/edit_business_cubit.dart';
import 'Dashboard/Screen/menuPage/screens/edit_education/cubit/edit_education__cubit.dart';
import 'Dashboard/Screen/menuPage/screens/personal_info/cubit/personal_info_cubit.dart';
import 'Dashboard/Screen/menuPage/screens/profile_screen/cubit/profile_cubit.dart';
import 'Dashboard/Screen/socialMedia/posts/cubit/FetchPostCubit.dart';
import 'Dashboard/Screen/socialMedia/posts/cubit/ReactionCubit.dart';
import 'Dashboard/Screen/socialMedia/posts/cubit/ShareCubit.dart';
import 'Dashboard/Screen/socialMedia/reels/reels/cubits/ReelShareCubit.dart';
import 'Login/Cubit/language_cubit/lan_cubit.dart';
import 'generated/l10n.dart';
import 'notification_handler/firebase_notification_handler.dart';
import 'notification_handler/local_notification_handler.dart';
import 'splash_screen/cubit/user_profile_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  await GetStorage.init();
  runApp(const MyApp());
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    FirebaseMessaging.instance
        .subscribeToTopic("sangathan")
        .then((value) => debugPrint("subscribed to sangathan"));
    LocalNotificationService.initialize(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => SendFcmTokenCubit()),
        BlocProvider(create: (context) => ReelShareCubit()),
        BlocProvider(create: (context) => DatePicCubit()),
        BlocProvider(create: (context) => ReactionCubit()),
        BlocProvider(create: (context) => NotificationCubit()),
        BlocProvider(create: (context) => LanguageCubit()),
        BlocProvider(create: (context) => HorizontalTileCubit()),
        BlocProvider(create: (context) => PollCubit()),
        BlocProvider(create: (context) => ShareCubit()),
        BlocProvider(create: (context) => ReelsCubit()),
        BlocProvider(create: (context) => PostsCubit()),
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
        BlocProvider(create: (context) => PersonalInfoCubit()),
        BlocProvider(create: (context) => EditAddressCubit()),
        BlocProvider(create: (context) => ProfileCubit()),
        BlocProvider(create: (context) => EditEducationCubit()),
        BlocProvider(create: (context) => EditBusinessCubit()),
        BlocProvider(create: (context) => MenuScreenCubit()),
        BlocProvider(create: (context) => ShaktiKendraCubit()),
        BlocProvider(create: (context) => EditShaktiKendrCubit()),
        BlocProvider(create: (context) => SangathanDetailsCubit()),
        BlocProvider(create: (context) => ShareCubit()),
        BlocProvider(create: (context) => VerifyPersonCubit()),
        BlocProvider(create: (context) => SendEventCubit()),
        BlocProvider(create: (context) => DashCubit()),
        BlocProvider(create: (context) => FetchCubit()),
        BlocProvider(create: (context) => GenerateMannKiBaatAuthCubit()),
      ],
      child: BlocBuilder<LanguageCubit, LanguageState>(
        builder: (context, lang) {
          final cubit = context.read<LanguageCubit>();
          currentLanguage = cubit.lang ?? "hi";
          return MaterialApp(
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
            locale: Locale.fromSubtags(languageCode: cubit.lang!),
            // locale: lang,
            onGenerateRoute: RouteGenerator.generatorRoute,
            // home: NotificationMainScreen(),
            initialRoute: RoutePath.splashScreenPage,
            theme: Theme.of(context).copyWith(
                colorScheme: Theme.of(context)
                    .colorScheme
                    .copyWith(primary: AppColor.primaryColor)),
          );
        },
      ),
    );
  }
}
