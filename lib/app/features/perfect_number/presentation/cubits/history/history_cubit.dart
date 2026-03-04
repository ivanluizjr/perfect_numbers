import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:perfect_numbers/app/features/perfect_number/domain/usecases/clear_history_use_case.dart';
import 'package:perfect_numbers/app/features/perfect_number/domain/usecases/delete_history_entry_use_case.dart';
import 'package:perfect_numbers/app/features/perfect_number/domain/usecases/get_history_use_case.dart';
import 'package:perfect_numbers/app/features/perfect_number/domain/usecases/toggle_favorite_use_case.dart';
import 'package:perfect_numbers/app/features/perfect_number/presentation/cubits/history/history_state.dart';

class HistoryCubit extends Cubit<HistoryState> {
  final IGetHistoryUseCase _getHistory;
  final IDeleteHistoryEntryUseCase _delete;
  final IToggleFavoriteUseCase _toggleFavorite;
  final IClearHistoryUseCase _clearAll;

  HistoryCubit(
    this._getHistory,
    this._delete,
    this._toggleFavorite,
    this._clearAll,
  ) : super(const HistoryInitial());

  Future<void> load() async {
    emit(const HistoryLoading());
    final either = await _getHistory();
    either.fold((failure) => emit(HistoryError(failure.message)), (entries) {
      if (entries.isEmpty) {
        emit(const HistoryEmpty());
      } else {
        emit(
          HistoryLoaded(
            entries: entries,
            favorites: entries.where((e) => e.isFavorite).toList(),
          ),
        );
      }
    });
  }

  Future<void> delete(String id) async {
    final either = await _delete(id);
    if (either.isLeft) {
      emit(HistoryError(either.leftOrNull!.message));
      return;
    }
    await load();
  }

  Future<void> toggleFavorite(String id) async {
    final either = await _toggleFavorite(id);
    if (either.isLeft) {
      emit(HistoryError(either.leftOrNull!.message));
      return;
    }
    await load();
  }

  Future<void> clearAll() async {
    final either = await _clearAll();
    either.fold(
      (failure) => emit(HistoryError(failure.message)),
      (_) => emit(const HistoryEmpty()),
    );
  }
}
