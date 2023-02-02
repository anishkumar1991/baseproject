import 'package:flutter/material.dart';
import 'package:sangathan/AddEntry/Screen/add_entry_screen.dart';
import 'package:sangathan/Dashboard/Screen/Dashboard/dashboard_screen.dart';
import 'package:sangathan/Dashboard/Screen/homePage/screens/sangathan_details/sangathan_deatils_page.dart';
import 'package:sangathan/Dashboard/Screen/homePage/screens/zila_data_page/zila_data_screen.dart';
import 'package:sangathan/Login/Screens/LoginScreen/login_page.dart';
import 'package:sangathan/Login/Screens/VerifyOtp/verify_otp.dart';
import 'package:sangathan/route/route_path.dart';

import '../AddEntry/Screen/add_entry_preview_submit_screen.dart';
import '../Dashboard/Screen/homePage/screens/create_function_page/create_function_page.dart';
import '../Dashboard/Screen/homePage/screens/edit_date/edit_date_screen.dart';
import '../Dashboard/Screen/homePage/screens/guest_list/guest_list_screen.dart';
import '../Dashboard/Screen/homePage/screens/pravas_create/create_pravas_screen.dart';
import '../Dashboard/Screen/homePage/screens/pravas_list/pravas_list_screen.dart';
import '../Dashboard/Screen/homePage/screens/stay_and_program_list/stay_and_program_list_screen.dart';
import '../Dashboard/Screen/menuPage/screens/edit_address/edit_address_screen.dart';
import '../Dashboard/Screen/menuPage/screens/edit_business/edit_business_screen.dart';
import '../Dashboard/Screen/menuPage/screens/edit_education/edit_education_screen.dart';
import '../Dashboard/Screen/menuPage/screens/personal_info/personal_information_screen.dart';
import '../Dashboard/Screen/menuPage/screens/profile_screen/network/model/user_detail_model.dart';
import '../Dashboard/Screen/menuPage/screens/profile_screen/profile_screen.dart';
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
            return const SangathanDetailsPage();
          },
        );
      case RoutePath.addEntryScreen:
        return MaterialPageRoute(
          settings: RouteSettings(name: settings.name),
          builder: (context) {
            AddEntryPage data = args as AddEntryPage;
            return AddEntryPage(
              type: data.type,
              leaveId: data.leaveId,
              unitId: data.unitId,
              subUnitId: data.subUnitId,
              countryStateId: data.countryStateId,
              personData: data.personData,
              levelName: data.levelName,
              personID: data.personID,
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
            ZilaDataScreen data = args as ZilaDataScreen;
            return ZilaDataScreen(
              type: data.type,
              countryStateId: data.countryStateId,
              dataLevelId: data.dataLevelId,
            );
          },
        );
      case RoutePath.pravasCreateScreen:
        return MaterialPageRoute(
          settings: RouteSettings(name: settings.name),
          builder: (context) {
            return const PrvasCreateScreen();
          },
        );
      case RoutePath.pravasEditTimeScreen:
        return MaterialPageRoute(
            settings: RouteSettings(name: settings.name),
            builder: (context) {
              return const EditDateScreen();
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
            Map<String, dynamic>? map = {};
            bool? isEdit = false;
            bool? isView = false;
            if (settings.arguments != null) {
              map = settings.arguments as Map<String, dynamic>;
              isEdit = map['isEdit'];
              isView = map['isView'];
            }
            return CreateFunctionScreen(
                isView: isView ?? false, isEdit: isEdit ?? false);
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

      case RoutePath.profileScreen:
        return MaterialPageRoute(
          settings: RouteSettings(name: settings.name),
          builder: (context) {
            return const ProfileScreen();
          },
        );
      case RoutePath.personalInformationScreen:
        return MaterialPageRoute(
          settings: RouteSettings(name: settings.name),
          builder: (context) {
            Map<String, dynamic> data =
                settings.arguments as Map<String, dynamic>;
            UserDetailModel model = UserDetailModel.fromJson(data);
            return PersonalInformationScreen(userDetails: model);
          },
        );
      case RoutePath.editAddressScreen:
        return MaterialPageRoute(
          settings: RouteSettings(name: settings.name),
          builder: (context) {
            Map<String, dynamic>? map = {};
            int? index;
            List<Addresses>? addresses;
            bool? isNew;
            if (settings.arguments != null) {
              map = settings.arguments as Map<String, dynamic>;
              index = map['index'];
              addresses = map['addresses'];
              isNew = map['isNew'];
            }
            return EditAddressScreen(
              index: index,
              addresses: addresses,
              isNew: isNew
            );
          },
        );

      case RoutePath.addEntryPreviewSubmit:
        return MaterialPageRoute(
          settings: RouteSettings(name: settings.name),
          builder: (context) {
            return const AddEntryPreviewSubmit();
          },
        );
      case RoutePath.editEducationScreen:
        return MaterialPageRoute(
          settings: RouteSettings(name: settings.name),
          builder: (context) {
            Map<String, dynamic>? map = {};
            int? index;
            List<EducationalDetails>? educationalDetails;
            bool? isNew;
            if (settings.arguments != null) {
              map = settings.arguments as Map<String, dynamic>;
              index = map['index'];
              educationalDetails = map['educationalDetails'];
              isNew = map['isNew'];
            }
            return EditEducationScreen(
              index: index,
              educationalDetails: educationalDetails,
              isNew: isNew
            );
          },
        );
      case RoutePath.editBusinessScreen:
        return MaterialPageRoute(
          settings: RouteSettings(name: settings.name),
          builder: (context) {
            Map<String, dynamic>? map = {};
            int? index;
            List<ProfessionalDetails>? professionalDetails;
            bool? isNew;
            if (settings.arguments != null) {
              map = settings.arguments as Map<String, dynamic>;
              index = map['index'];
              professionalDetails = map['professionalDetails'];
              isNew = map['isNew'];
            }
            return EditBusinessScreen(
              index: index,
              professionalDetails: professionalDetails,
              isNew: isNew,
            );
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
