import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'menu_screen_state.dart';

class MenuScreenCubit extends Cubit<MenuScreenState> {
  MenuScreenCubit() : super(MenuScreenInitial());
}
