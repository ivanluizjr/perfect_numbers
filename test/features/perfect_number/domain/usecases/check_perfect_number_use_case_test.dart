import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:perfect_numbers/app/core/errors/errors.dart';
import 'package:perfect_numbers/app/features/perfect_number/domain/entities/perfect_number_result.dart';
import 'package:perfect_numbers/app/features/perfect_number/domain/repositories/perfect_number_repository.dart';
import 'package:perfect_numbers/app/features/perfect_number/domain/usecases/check_perfect_number_use_case.dart';

class MockPerfectNumberRepository extends Mock
    implements PerfectNumberRepository {}

void main() {
  late ICheckPerfectNumberUseCase useCase;
  late MockPerfectNumberRepository repository;

  setUp(() {
    repository = MockPerfectNumberRepository();
    useCase = CheckPerfectNumberUseCaseImpl(repository);
  });

  const sixResult = PerfectNumberResult(
    number: 6,
    isPerfect: true,
    divisors: [1, 2, 3],
    divisorSum: 6,
  );
  const twentyEightResult = PerfectNumberResult(
    number: 28,
    isPerfect: true,
    divisors: [1, 2, 4, 7, 14],
    divisorSum: 28,
  );
  const twelveResult = PerfectNumberResult(
    number: 12,
    isPerfect: false,
    divisors: [1, 2, 3, 4, 6],
    divisorSum: 16,
  );
  const oneResult = PerfectNumberResult(
    number: 1,
    isPerfect: false,
    divisors: [],
    divisorSum: 0,
  );

  test('should return Right with perfect result for 6', () {
    when(() => repository.checkNumber(6)).thenReturn(Right(sixResult));
    final result = useCase(6);
    result.fold(
      (failure) => fail('Expected Right but got Left: \${failure.message}'),
      (r) {
        expect(r.isPerfect, isTrue);
        expect(r.number, 6);
        expect(r.divisors, [1, 2, 3]);
        expect(r.divisorSum, 6);
      },
    );
    verify(() => repository.checkNumber(6)).called(1);
  });

  test('should return Right with perfect result for 28', () {
    when(() => repository.checkNumber(28)).thenReturn(Right(twentyEightResult));
    final result = useCase(28);
    expect(result.isRight, isTrue);
    expect(result.rightOrNull?.isPerfect, isTrue);
    expect(result.rightOrNull?.number, 28);
    verify(() => repository.checkNumber(28)).called(1);
  });

  test('should return Right with non-perfect result for 12', () {
    when(() => repository.checkNumber(12)).thenReturn(Right(twelveResult));
    final result = useCase(12);
    expect(result.isRight, isTrue);
    expect(result.rightOrNull?.isPerfect, isFalse);
    expect(result.rightOrNull?.divisorSum, 16);
    verify(() => repository.checkNumber(12)).called(1);
  });

  test('should return Right with non-perfect result for 1', () {
    when(() => repository.checkNumber(1)).thenReturn(Right(oneResult));
    final result = useCase(1);
    expect(result.isRight, isTrue);
    expect(result.rightOrNull?.isPerfect, isFalse);
    expect(result.rightOrNull?.divisors, isEmpty);
    verify(() => repository.checkNumber(1)).called(1);
  });

  test('should return Left(ValidationFailure) for number < 1', () {
    final result = useCase(0);
    expect(result.isLeft, isTrue);
    expect(result.leftOrNull, isA<ValidationFailure>());
    verifyNever(() => repository.checkNumber(any()));
  });

  test('should return Left(ValidationFailure) for negative number', () {
    final result = useCase(-5);
    expect(result.isLeft, isTrue);
    expect(result.leftOrNull, isA<ValidationFailure>());
    verifyNever(() => repository.checkNumber(any()));
  });

  test('divisorsExpression should format correctly for 6', () {
    when(() => repository.checkNumber(6)).thenReturn(Right(sixResult));
    final result = useCase(6);
    expect(result.rightOrNull?.divisorsExpression, '1 + 2 + 3 = 6');
  });

  test('should return Left when repository returns Left', () {
    const failure = UnknownFailure(message: 'Erro inesperado');
    when(() => repository.checkNumber(6)).thenReturn(const Left(failure));
    final result = useCase(6);
    expect(result.isLeft, isTrue);
    expect(result.leftOrNull?.message, 'Erro inesperado');
  });
}
