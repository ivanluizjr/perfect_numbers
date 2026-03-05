import 'package:perfect_numbers/app/core/errors/errors.dart';
import 'package:perfect_numbers/app/features/perfect_number/domain/entities/perfect_number_result.dart';

abstract class PerfectNumberRepository {
  Either<Failure, PerfectNumberResult> checkNumber(int number);

  Future<Either<Failure, List<PerfectNumberResult>>> findInRange(
    int start,
    int end,
  );
}
