import 'package:flutter_bloc/flutter_bloc.dart';

class MainCubit extends Cubit<int> {
  MainCubit(super.initialIndex);

  void selectTab(int index) => emit(index);
}
