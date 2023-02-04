import 'package:bloc/bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:meta/meta.dart';

part 'menu_screen_state.dart';

class MenuScreenCubit extends Cubit<MenuScreenState> {
  MenuScreenCubit() : super(MenuScreenInitial());

   GetStorage storage = GetStorage();
   String? supportNumber;

   getSupportNumber() async {
    supportNumber = storage.read('supportNumber');
  }

}
