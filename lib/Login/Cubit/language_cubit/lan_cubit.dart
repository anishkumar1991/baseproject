import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';

part "language_state.dart";

String currentLanguage = "hi";

class LanguageCubit extends Cubit<LanguageState> {
  LanguageCubit() : super(LanguageInitial());

  String? lang = 'hi';

  changeStartLang() async {
    GetStorage box = GetStorage();
    String langCode = box.read('lang') ?? 'hi';
    if (langCode != null) {
      lang = langCode;
      emit(LanguageLoadingState());
    } else {
      lang = 'hi';
      emit(LanguageLoadingState());
    }
  }

  void changeLang(context, String langString) async {
    lang = langString;
    emit(LanguageLoadingState());
    GetStorage box = GetStorage();
    box.write('lang', lang);
  }
}
