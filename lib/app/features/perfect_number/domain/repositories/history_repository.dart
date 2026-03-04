import 'package:perfect_numbers/app/core/errors/errors.dart';
import 'package:perfect_numbers/app/features/perfect_number/domain/entities/history_entry.dart';

abstract class HistoryRepository {
  Future<Either<Failure, List<HistoryEntry>>> getAll();
  Future<Either<Failure, Unit>> save(HistoryEntry entry);
  Future<Either<Failure, Unit>> delete(String id);
  Future<Either<Failure, Unit>> toggleFavorite(String id);
  Future<Either<Failure, Unit>> clearAll();
}
