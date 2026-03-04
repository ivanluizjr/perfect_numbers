import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:perfect_numbers/app/features/perfect_number/domain/entities/history_entry.dart';
import 'package:perfect_numbers/app/features/perfect_number/domain/usecases/find_perfect_numbers_in_range_use_case.dart';
import 'package:perfect_numbers/app/features/perfect_number/domain/usecases/save_history_entry_use_case.dart';
import 'package:perfect_numbers/app/features/perfect_number/presentation/cubits/range_search/range_search_state.dart';
import 'package:uuid/uuid.dart';

class RangeSearchCubit extends Cubit<RangeSearchState> {
  final IFindPerfectNumbersInRangeUseCase _findUseCase;
  final ISaveHistoryEntryUseCase _saveUseCase;

  RangeSearchCubit(this._findUseCase, this._saveUseCase)
    : super(const RangeSearchInitial());

  Future<void> search(String startInput, String endInput) async {
    final start = int.tryParse(startInput.trim());
    final end = int.tryParse(endInput.trim());
    if (start == null || end == null) {
      emit(const RangeSearchError('Insira valores numéricos válidos.'));
      return;
    }

    emit(const RangeSearchLoading());
    await Future.delayed(const Duration(milliseconds: 400));

    final either = _findUseCase(start, end);
    either.fold((failure) => emit(RangeSearchError(failure.message)), (
      results,
    ) {
      if (results.isEmpty) {
        emit(RangeSearchEmpty(start, end));
      } else {
        emit(RangeSearchSuccess(results, start, end));
      }
    });

    final results = either.rightOrNull;
    if (results != null) {
      await _saveUseCase(
        HistoryEntry(
          id: const Uuid().v4(),
          type: HistoryEntryType.rangeSearch,
          timestamp: DateTime.now(),
          rangeStart: start,
          rangeEnd: end,
          rangeResults: results,
        ),
      );
    }
  }

  void reset() => emit(const RangeSearchInitial());
}
