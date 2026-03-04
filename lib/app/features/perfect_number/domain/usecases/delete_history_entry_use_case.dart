import 'package:perfect_numbers/app/core/errors/errors.dart';
import 'package:perfect_numbers/app/features/perfect_number/domain/repositories/history_repository.dart';

abstract class IDeleteHistoryEntryUseCase {
  Future<Either<Failure, Unit>> call(String id);
}

class DeleteHistoryEntryUseCaseImpl implements IDeleteHistoryEntryUseCase {
  final HistoryRepository repository;

  const DeleteHistoryEntryUseCaseImpl(this.repository);

  @override
  Future<Either<Failure, Unit>> call(String id) => repository.delete(id);
}
