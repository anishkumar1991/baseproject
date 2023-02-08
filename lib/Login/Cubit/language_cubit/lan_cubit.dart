import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';

part "language_state.dart";

class LanguageCubit extends Cubit<LanguageState> {
  LanguageCubit() : super(LanguageInitial());

  String? lang = 'hi';

  changeStartLang() async {
    GetStorage box = GetStorage();
    String langCode = box.read('lang');
    if (langCode != '') {
      lang = langCode;
      emit(LanguageLoadingState());
    } else {
      lang = 'hi';
      emit(LanguageLoadingState());
    }
  }

  void changeLang(context) async {
    Locale myLocale = Localizations.localeOf(context);
    if (myLocale.toString() == 'hi') {
      lang = 'en';
    } else {
      lang = 'hi';
    }
    emit(LanguageLoadingState());
    GetStorage box = GetStorage();
    box.write('lang', lang);
  }
}
