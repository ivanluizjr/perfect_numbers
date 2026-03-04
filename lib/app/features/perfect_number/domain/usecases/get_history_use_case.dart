import 'package:perfect_numbers/app/core/errors/errors.dart';
import 'package:perfect_numbers/app/features/perfect_number/domain/entities/history_entry.dart';
import 'package:perfect_numbers/app/features/perfect_number/domain/repositories/history_repository.dart';

abstract class IGetHistoryUseCase {
  Future<Either<Failure, List<HistoryEntry>>> call();
}

class GetHistoryUseCaseImpl implements IGetHistoryUseCase {
  final HistoryRepository repository;

  const GetHistoryUseCaseImpl(this.repository);

  @override
  Future<Either<Failure, List<HistoryEntry>>> call() => repository.getAll();
}
