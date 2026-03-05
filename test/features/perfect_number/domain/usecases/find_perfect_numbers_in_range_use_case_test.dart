import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:perfect_numbers/app/core/errors/errors.dart';
import 'package:perfect_numbers/app/features/perfect_number/domain/entities/perfect_number_result.dart';
import 'package:perfect_numbers/app/features/perfect_number/domain/repositories/perfect_number_repository.dart';
import 'package:perfect_numbers/app/features/perfect_number/domain/usecases/find_perfect_numbers_in_range_use_case.dart';

class MockPerfectNumberRepository extends Mock
    implements PerfectNumberRepository {}

void main() {
  late IFindPerfectNumbersInRangeUseCase useCase;
  late MockPerfectNumberRepository repository;

  setUp(() {
    repository = MockPerfectNumberRepository();
    useCase = FindPerfectNumbersInRangeUseCaseImpl(repository);
  });

  const six = PerfectNumberResult(
    number: 6,
    isPerfect: true,
    divisors: [1, 2, 3],
    divisorSum: 6,
  );
  const twentyEight = PerfectNumberResult(
    number: 28,
    isPerfect: true,
    divisors: [1, 2, 4, 7, 14],
    divisorSum: 28,
  );
  const fourNinetySix = PerfectNumberResult(
    number: 496,
    isPerfect: true,
    divisors: [1, 2, 4, 8, 16, 31, 62, 124, 248],
    divisorSum: 496,
  );

  test('should return Right([6]) for range 1..10', () async {
    when(
      () => repository.findInRange(1, 10),
    ).thenAnswer((_) async => Right([six]));
    final result = await useCase(1, 10);
    expect(result.isRight, isTrue);
    expect(result.rightOrNull?.length, 1);
    expect(result.rightOrNull?.first.number, 6);
    verify(() => repository.findInRange(1, 10)).called(1);
  });

  test('should return Right([6, 28, 496]) for range 1..1000', () async {
    when(
      () => repository.findInRange(1, 1000),
    ).thenAnswer((_) async => Right([six, twentyEight, fourNinetySix]));
    final result = await useCase(1, 1000);
    expect(result.isRight, isTrue);
    expect(result.rightOrNull?.length, 3);
    expect(result.rightOrNull?.map((r) => r.number).toList(), [6, 28, 496]);
    verify(() => repository.findInRange(1, 1000)).called(1);
  });

  test('should return Right([]) for range with no perfect numbers', () async {
    when(
      () => repository.findInRange(29, 100),
    ).thenAnswer((_) async => const Right([]));
    final result = await useCase(29, 100);
    expect(result.isRight, isTrue);
    expect(result.rightOrNull, isEmpty);
    verify(() => repository.findInRange(29, 100)).called(1);
  });

  test('should return Left(ValidationFailure) when start > end', () async {
    final result = await useCase(100, 10);
    expect(result.isLeft, isTrue);
    expect(result.leftOrNull, isA<ValidationFailure>());
    verifyNever(() => repository.findInRange(any(), any()));
  });

  test('should return Left(ValidationFailure) when start < 1', () async {
    final result = await useCase(0, 100);
    expect(result.isLeft, isTrue);
    expect(result.leftOrNull, isA<ValidationFailure>());
    verifyNever(() => repository.findInRange(any(), any()));
  });

  test(
    'should return Left(ValidationFailure) when start is negative',
    () async {
      final result = await useCase(-10, 100);
      expect(result.isLeft, isTrue);
      expect(result.leftOrNull, isA<ValidationFailure>());
      verifyNever(() => repository.findInRange(any(), any()));
    },
  );

  test('should return Right for equal start and end (single number)', () async {
    when(
      () => repository.findInRange(6, 6),
    ).thenAnswer((_) async => Right([six]));
    final result = await useCase(6, 6);
    expect(result.isRight, isTrue);
    expect(result.rightOrNull?.length, 1);
    expect(result.rightOrNull?.first.isPerfect, isTrue);
  });

  test('should propagate Left from repository', () async {
    const failure = CacheFailure(message: 'Erro de cache');
    when(
      () => repository.findInRange(1, 10),
    ).thenAnswer((_) async => const Left(failure));
    final result = await useCase(1, 10);
    expect(result.isLeft, isTrue);
    expect(result.leftOrNull, isA<CacheFailure>());
  });
}
