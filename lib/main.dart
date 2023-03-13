import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sangathan/Login/Cubit/login_cubit.dart';
import 'package:sangathan/Utils/ConnectivityCheck/cubit/connectivity_cubit.dart';
import 'package:sangathan/Values/app_colors.dart';
import 'package:sangathan/Values/string.dart';

// import 'mannkibaat/lib/attendeesformpage/cubit/FetchCubit.dart';
// import 'mannkibaat/lib/reportedprogramspage/cubit/DashCubit.dart';
import 'package:sangathan/route/route_path.dart';
import 'package:sangathan/route/routes.dart';

import 'Login/Cubit/language_cubit/lan_cubit.dart';
import 'generated/l10n.dart';

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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LanguageCubit()),
        BlocProvider(create: (context) => InternetCubit()),
        BlocProvider(create: (context) => LoginCubit()),
        BlocProvider(create: (context) => UserProfileCubit()),
        BlocProvider(create: (context) => UserProfileCubit()),
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
