import 'package:perfect_numbers/app/core/errors/errors.dart';
import 'package:perfect_numbers/app/features/perfect_number/domain/repositories/history_repository.dart';

abstract class IToggleFavoriteUseCase {
  Future<Either<Failure, Unit>> call(String id);
}

class ToggleFavoriteUseCaseImpl implements IToggleFavoriteUseCase {
  final HistoryRepository repository;

  const ToggleFavoriteUseCaseImpl(this.repository);

  @override
  Future<Either<Failure, Unit>> call(String id) =>
      repository.toggleFavorite(id);
}
