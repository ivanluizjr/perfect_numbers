import 'package:perfect_numbers/app/core/errors/errors.dart';
import 'package:perfect_numbers/app/features/perfect_number/data/datasources/perfect_number_data_source.dart';
import 'package:perfect_numbers/app/features/perfect_number/domain/entities/perfect_number_result.dart';
import 'package:perfect_numbers/app/features/perfect_number/domain/repositories/perfect_number_repository.dart';

class PerfectNumberRepositoryImpl implements PerfectNumberRepository {
  final PerfectNumberDataSource dataSource;

  const PerfectNumberRepositoryImpl(this.dataSource);

  @override
  Either<Failure, PerfectNumberResult> checkNumber(int number) {
    try {
      return Right(dataSource.checkNumber(number));
    } on AppException catch (e) {
      return Left(UnknownFailure(message: e.message, details: e.details));
    } catch (e) {
      return Left(UnknownFailure(details: e.toString()));
    }
  }

  @override
  Either<Failure, List<PerfectNumberResult>> findInRange(int start, int end) {
    try {
      return Right(dataSource.findInRange(start, end));
    } on AppException catch (e) {
      return Left(UnknownFailure(message: e.message, details: e.details));
    } catch (e) {
      return Left(UnknownFailure(details: e.toString()));
    }
  }
}
