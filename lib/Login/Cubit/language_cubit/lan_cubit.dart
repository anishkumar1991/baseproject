import 'dart:ui';

import 'package:flutter_bloc/flutter_bloc.dart';

class LanguageCubit extends Cubit<Locale> {
  LanguageCubit() : super(const Locale('hi'));

  void changeLang(context, String data) async {
    emit(Locale('lang', data));
  }
}