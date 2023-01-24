import 'package:flutter/material.dart';
import 'package:sangathan/AddEntry/Screen/add_entry_screen.dart';
import 'package:sangathan/Dashboard/Screen/Dashboard/dashboard_screen.dart';
import 'package:sangathan/Dashboard/Screen/homePage/screens/stay_and_program_list/stay_and_program_list_screen.dart';
import 'package:sangathan/Dashboard/Screen/homePage/widget/sangathan_deatils_page.dart';
import 'package:sangathan/Dashboard/Screen/homePage/screens/zila_data_page/zila_data_screen.dart';
import 'package:sangathan/Login/Screens/LoginScreen/login_page.dart';
import 'package:sangathan/Login/Screens/VerifyOtp/verify_otp.dart';
import 'package:sangathan/SplashScreen/Screen/splash_screen.dart';
import 'package:sangathan/route/route_path.dart';
import '../Dashboard/Screen/homePage/screens/edit_date/edit_date_screen.dart';
import '../Dashboard/Screen/homePage/screens/guest_list/guest_list_screen.dart';
import '../Dashboard/Screen/homePage/screens/pravas_create/create_pravas_screen.dart';
import '../Dashboard/Screen/homePage/screens/create_function_page/create_function_page.dart';
import '../Dashboard/Screen/homePage/screens/pravas_list/pravas_list_screen.dart';

class RouteGenerator {
  static Route<dynamic>? generatorRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutePath.loginScreen:
        return MaterialPageRoute(
          settings: RouteSettings(name: settings.name),
          builder: (context) {
            return LoginScreen();
          },
        );

      case RoutePath.dashBoardScreen:
        return MaterialPageRoute(
          settings: RouteSettings(name: settings.name),
          builder: (context) {
            return const DashBoardScreen();
          },
        );
      case RoutePath.verifyOtpScreen:
        return MaterialPageRoute(
          settings: RouteSettings(name: settings.name),
          builder: (context) {
            return VerifyOtpScreen(number: settings.arguments as String);
          },
        );
      case RoutePath.sangathanDetailsScreen:
        return MaterialPageRoute(
          settings: RouteSettings(name: settings.name),
          builder: (context) {
            return SangathanDetailsPage();
          },
        );
      case RoutePath.addEntryScreen:
        return MaterialPageRoute(
          settings: RouteSettings(name: settings.name),
          builder: (context) {
            return AddEntryPage(
              type: settings.arguments as String,
            );
          },
        );
      case RoutePath.splashScreenPage:
        return MaterialPageRoute(
          settings: RouteSettings(name: settings.name),
          builder: (context) {
            return const SplashScreen();
          },
        );
      case RoutePath.zilaDataPage:
        return MaterialPageRoute(
          settings: RouteSettings(name: settings.name),
          builder: (context) {
            return ZilaDataScreen(type: settings.arguments as String);
          },
        );
      case RoutePath.pravasCreateScreen:
        return MaterialPageRoute(
          settings: RouteSettings(name: settings.name),
          builder: (context) {
            return PrvasCreateScreen();
          },
        );
      case RoutePath.pravasEditTimeScreen:
        return MaterialPageRoute(
            settings: RouteSettings(name: settings.name),
            builder: (context) {
              return EditDateScreen();
            });
      case RoutePath.pravasListScreen:
        return MaterialPageRoute(
          settings: RouteSettings(name: settings.name),
          builder: (context) {
            return PravasListScreen();
          },
        );
      case RoutePath.createFunctionScreen:
        return MaterialPageRoute(
          settings: RouteSettings(name: settings.name),
          builder: (context) {
            Map<String, dynamic>? map =
            settings.arguments as Map<String, dynamic>;
            bool? isEdit = map['isEdit'] ?? false;
            bool? isView = map['isView'] ?? false;
            return  CreateFunctionScreen(isView: isView,isEdit: isEdit);
          },
        );
        case RoutePath.stayAndProgramListScreen:
        return MaterialPageRoute(
          settings: RouteSettings(name: settings.name),
          builder: (context) {
            return const StayAndProgramListScreen();
          },
        );
        case RoutePath.guestListScreen:
        return MaterialPageRoute(
          settings: RouteSettings(name: settings.name),
          builder: (context) {
            return const GuestListScreen();
          },
        );

      default:
        return MaterialPageRoute(
          settings: RouteSettings(name: settings.name),
          builder: (context) {
            return LoginScreen();
          },
        );
    }
  }
}
