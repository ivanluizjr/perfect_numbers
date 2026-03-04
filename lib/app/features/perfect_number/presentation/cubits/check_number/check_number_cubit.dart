import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:perfect_numbers/app/features/perfect_number/domain/entities/history_entry.dart';
import 'package:perfect_numbers/app/features/perfect_number/domain/usecases/check_perfect_number_use_case.dart';
import 'package:perfect_numbers/app/features/perfect_number/domain/usecases/save_history_entry_use_case.dart';
import 'package:perfect_numbers/app/features/perfect_number/presentation/cubits/check_number/check_number_state.dart';
import 'package:uuid/uuid.dart';

class CheckNumberCubit extends Cubit<CheckNumberState> {
  final ICheckPerfectNumberUseCase _checkUseCase;
  final ISaveHistoryEntryUseCase _saveUseCase;

  CheckNumberCubit(this._checkUseCase, this._saveUseCase)
    : super(const CheckNumberInitial());

  Future<void> check(String input) async {
    final n = int.tryParse(input.trim());
    if (n == null) {
      emit(
        const CheckNumberError('Por favor, insira um número inteiro válido.'),
      );
      return;
    }

    emit(const CheckNumberLoading());
    await Future.delayed(const Duration(milliseconds: 300));

    final either = _checkUseCase(n);
    either.fold(
      (failure) => emit(CheckNumberError(failure.message)),
      (result) => emit(CheckNumberSuccess(result)),
    );

    final result = either.rightOrNull;
    if (result != null) {
      await _saveUseCase(
        HistoryEntry(
          id: const Uuid().v4(),
          type: HistoryEntryType.singleCheck,
          timestamp: DateTime.now(),
          singleResult: result,
        ),
      );
    }
  }

  void reset() => emit(const CheckNumberInitial());
}
