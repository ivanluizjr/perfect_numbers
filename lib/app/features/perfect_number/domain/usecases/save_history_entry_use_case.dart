import 'package:perfect_numbers/app/core/errors/errors.dart';
import 'package:perfect_numbers/app/features/perfect_number/domain/entities/history_entry.dart';
import 'package:perfect_numbers/app/features/perfect_number/domain/repositories/history_repository.dart';

abstract class ISaveHistoryEntryUseCase {
  Future<Either<Failure, Unit>> call(HistoryEntry entry);
}

class SaveHistoryEntryUseCaseImpl implements ISaveHistoryEntryUseCase {
  final HistoryRepository repository;

  const SaveHistoryEntryUseCaseImpl(this.repository);

  @override
  Future<Either<Failure, Unit>> call(HistoryEntry entry) =>
      repository.save(entry);
}
