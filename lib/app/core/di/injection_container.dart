import 'package:get_it/get_it.dart';
import 'package:perfect_numbers/app/features/perfect_number/data/datasources/history_local_data_source.dart';
import 'package:perfect_numbers/app/features/perfect_number/data/datasources/perfect_number_data_source.dart';
import 'package:perfect_numbers/app/features/perfect_number/data/repositories/history_repository_impl.dart';
import 'package:perfect_numbers/app/features/perfect_number/data/repositories/perfect_number_repository_impl.dart';
import 'package:perfect_numbers/app/features/perfect_number/domain/repositories/history_repository.dart';
import 'package:perfect_numbers/app/features/perfect_number/domain/repositories/perfect_number_repository.dart';
import 'package:perfect_numbers/app/features/perfect_number/domain/usecases/check_perfect_number_use_case.dart';
import 'package:perfect_numbers/app/features/perfect_number/domain/usecases/clear_history_use_case.dart';
import 'package:perfect_numbers/app/features/perfect_number/domain/usecases/delete_history_entry_use_case.dart';
import 'package:perfect_numbers/app/features/perfect_number/domain/usecases/find_perfect_numbers_in_range_use_case.dart';
import 'package:perfect_numbers/app/features/perfect_number/domain/usecases/get_history_use_case.dart';
import 'package:perfect_numbers/app/features/perfect_number/domain/usecases/save_history_entry_use_case.dart';
import 'package:perfect_numbers/app/features/perfect_number/domain/usecases/toggle_favorite_use_case.dart';
import 'package:perfect_numbers/app/features/perfect_number/presentation/cubits/check_number/check_number_cubit.dart';
import 'package:perfect_numbers/app/features/perfect_number/presentation/cubits/history/history_cubit.dart';
import 'package:perfect_numbers/app/features/perfect_number/presentation/cubits/main/main_cubit.dart';
import 'package:perfect_numbers/app/features/perfect_number/presentation/cubits/onboarding/onboarding_cubit.dart';
import 'package:perfect_numbers/app/features/perfect_number/presentation/cubits/range_search/range_search_cubit.dart';
import 'package:perfect_numbers/app/features/perfect_number/presentation/cubits/settings/settings_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  await _core();
  await _datasource();
  await _repositories();
  await _usecases();
  await _cubits();
}

Future<void> _core() async {
  final prefs = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => prefs);
}

Future<void> _datasource() async {
  sl.registerLazySingleton(() => const PerfectNumberDataSource());
  sl.registerLazySingleton(() => HistoryLocalDataSource(sl()));
}

Future<void> _repositories() async {
  sl.registerLazySingleton<PerfectNumberRepository>(
    () => PerfectNumberRepositoryImpl(sl()),
  );
  sl.registerLazySingleton<HistoryRepository>(
    () => HistoryRepositoryImpl(sl()),
  );
}

Future<void> _usecases() async {
  sl.registerLazySingleton<ICheckPerfectNumberUseCase>(
    () => CheckPerfectNumberUseCaseImpl(sl()),
  );
  sl.registerLazySingleton<IFindPerfectNumbersInRangeUseCase>(
    () => FindPerfectNumbersInRangeUseCaseImpl(sl()),
  );
  sl.registerLazySingleton<IGetHistoryUseCase>(
    () => GetHistoryUseCaseImpl(sl()),
  );
  sl.registerLazySingleton<ISaveHistoryEntryUseCase>(
    () => SaveHistoryEntryUseCaseImpl(sl()),
  );
  sl.registerLazySingleton<IDeleteHistoryEntryUseCase>(
    () => DeleteHistoryEntryUseCaseImpl(sl()),
  );
  sl.registerLazySingleton<IToggleFavoriteUseCase>(
    () => ToggleFavoriteUseCaseImpl(sl()),
  );
  sl.registerLazySingleton<IClearHistoryUseCase>(
    () => ClearHistoryUseCaseImpl(sl()),
  );
}

Future<void> _cubits() async {
  sl.registerLazySingleton(() => SettingsCubit());

  sl.registerFactory(() => CheckNumberCubit(sl(), sl()));
  sl.registerFactory(() => RangeSearchCubit(sl(), sl()));
  sl.registerFactory(() => HistoryCubit(sl(), sl(), sl(), sl()));
  sl.registerFactory(() => MainCubit(0));
  sl.registerFactory(() => OnboardingCubit(sl()));
}
