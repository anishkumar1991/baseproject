import 'package:flutter/material.dart';
import 'package:sangathan/Dashboard/Screen/Dashboard/dashboard_screen.dart';
import 'package:sangathan/Login/Screens/SendOtp/login_page.dart';
import 'package:sangathan/Login/Screens/VerifyOtp/verify_otp.dart';
import 'package:sangathan/route/route_path.dart';

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
            return  VerifyOtpScreen(number:settings.arguments as String);
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
