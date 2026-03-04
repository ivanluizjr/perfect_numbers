import 'package:perfect_numbers/app/core/errors/errors.dart';
import 'package:perfect_numbers/app/features/perfect_number/domain/entities/perfect_number_result.dart';
import 'package:perfect_numbers/app/features/perfect_number/domain/repositories/perfect_number_repository.dart';

abstract class ICheckPerfectNumberUseCase {
  Either<Failure, PerfectNumberResult> call(int number);
}

class CheckPerfectNumberUseCaseImpl implements ICheckPerfectNumberUseCase {
  final PerfectNumberRepository repository;

  const CheckPerfectNumberUseCaseImpl(this.repository);

  @override
  Either<Failure, PerfectNumberResult> call(int number) {
    if (number < 1) {
      return Left(
        const ValidationFailure(message: 'O número deve ser maior que zero.'),
      );
    }
    return repository.checkNumber(number);
  }
}
