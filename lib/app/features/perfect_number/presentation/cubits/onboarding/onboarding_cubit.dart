import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:perfect_numbers/app/features/perfect_number/data/datasources/history_local_data_source.dart';

class OnboardingCubit extends Cubit<int> {
  final HistoryLocalDataSource _dataSource;

  OnboardingCubit(this._dataSource) : super(0);

  void nextPage() => emit(state + 1);
  void setPage(int page) => emit(page);

  Future<void> complete() async {
    await _dataSource.markOnboardingSeen();
  }
}
