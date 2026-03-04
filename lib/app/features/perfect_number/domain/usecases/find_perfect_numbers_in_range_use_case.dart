import 'package:perfect_numbers/app/core/errors/errors.dart';
import 'package:perfect_numbers/app/features/perfect_number/domain/entities/perfect_number_result.dart';
import 'package:perfect_numbers/app/features/perfect_number/domain/repositories/perfect_number_repository.dart';

abstract class IFindPerfectNumbersInRangeUseCase {
  Either<Failure, List<PerfectNumberResult>> call(int start, int end);
}

class FindPerfectNumbersInRangeUseCaseImpl
    implements IFindPerfectNumbersInRangeUseCase {
  final PerfectNumberRepository repository;

  const FindPerfectNumbersInRangeUseCaseImpl(this.repository);

  @override
  Either<Failure, List<PerfectNumberResult>> call(int start, int end) {
    if (start < 1) {
      return Left(
        const ValidationFailure(
          message: 'O início do intervalo deve ser maior que zero.',
        ),
      );
    }
    if (start > end) {
      return Left(
        const ValidationFailure(
          message: 'O início deve ser menor ou igual ao fim do intervalo.',
        ),
      );
    }
    return repository.findInRange(start, end);
  }
}
