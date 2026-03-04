import 'package:perfect_numbers/app/core/errors/errors.dart';
import 'package:perfect_numbers/app/features/perfect_number/domain/repositories/history_repository.dart';

abstract class IClearHistoryUseCase {
  Future<Either<Failure, Unit>> call();
}

class ClearHistoryUseCaseImpl implements IClearHistoryUseCase {
  final HistoryRepository repository;

  const ClearHistoryUseCaseImpl(this.repository);

  @override
  Future<Either<Failure, Unit>> call() => repository.clearAll();
}
