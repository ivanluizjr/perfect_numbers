import 'package:perfect_numbers/app/core/errors/errors.dart';
import 'package:perfect_numbers/app/features/perfect_number/data/datasources/history_local_data_source.dart';
import 'package:perfect_numbers/app/features/perfect_number/data/models/history_entry_model.dart';
import 'package:perfect_numbers/app/features/perfect_number/domain/entities/history_entry.dart';
import 'package:perfect_numbers/app/features/perfect_number/domain/repositories/history_repository.dart';

class HistoryRepositoryImpl implements HistoryRepository {
  final HistoryLocalDataSource dataSource;

  const HistoryRepositoryImpl(this.dataSource);

  @override
  Future<Either<Failure, List<HistoryEntry>>> getAll() async {
    try {
      return Right(dataSource.getAll());
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message, details: e.details));
    } catch (e) {
      return Left(UnknownFailure(details: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> save(HistoryEntry entry) async {
    try {
      await dataSource.save(HistoryEntryModel.fromEntity(entry));
      return Right(Unit.instance);
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message, details: e.details));
    } catch (e) {
      return Left(UnknownFailure(details: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> delete(String id) async {
    try {
      await dataSource.delete(id);
      return Right(Unit.instance);
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message, details: e.details));
    } catch (e) {
      return Left(UnknownFailure(details: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> toggleFavorite(String id) async {
    try {
      await dataSource.toggleFavorite(id);
      return Right(Unit.instance);
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message, details: e.details));
    } catch (e) {
      return Left(UnknownFailure(details: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> clearAll() async {
    try {
      await dataSource.clearAll();
      return Right(Unit.instance);
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message, details: e.details));
    } catch (e) {
      return Left(UnknownFailure(details: e.toString()));
    }
  }
}
