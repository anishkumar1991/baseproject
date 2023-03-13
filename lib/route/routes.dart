import 'package:flutter/material.dart';
import 'package:sangathan/route/route_path.dart';
import 'package:sangathan/scanner/screens/ScannerMainScreen.dart';
import '../Login/Screens/LoginScreen/login_page.dart';
import '../Login/Screens/VerifyOtp/verify_otp.dart';
import '../splash_screen/screen/splash_screen.dart';

class RouteGenerator {
  static Route<dynamic>? generatorRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case RoutePath.loginScreen:
        return MaterialPageRoute(
          settings: RouteSettings(name: settings.name),
          builder: (context) {
            return LoginScreen();
          },
        );

      case RoutePath.scannerMainScreen:
        return MaterialPageRoute(
          settings: RouteSettings(name: settings.name),
          builder: (context) {
            return const ScannerMainScreen();
          },
        );
      case RoutePath.verifyOtpScreen:
        return MaterialPageRoute(
          settings: RouteSettings(name: settings.name),
          builder: (context) {
            return VerifyOtpScreen(number: settings.arguments as String);
          },
        );
      case RoutePath.splashScreenPage:
        return MaterialPageRoute(
          settings: RouteSettings(name: settings.name),
          builder: (context) {
            return const SplashScreen();
          },
        );

      case RoutePath.scannerMainScreen:
        return MaterialPageRoute(
          settings: RouteSettings(name: settings.name),
          builder: (context) {
            return const ScannerMainScreen();
          },
        );

      // case RoutePath.homeScreenRoute:
      //   return MaterialPageRoute(
      //     settings: RouteSettings(name: settings.name),
      //     builder: (context) {
      //       return
      //     },
      //   );

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
