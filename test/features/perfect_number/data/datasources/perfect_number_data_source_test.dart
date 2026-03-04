import 'package:flutter_test/flutter_test.dart';
import 'package:perfect_numbers/app/features/perfect_number/data/datasources/perfect_number_data_source.dart';

void main() {
  const dataSource = PerfectNumberDataSource();

  group('checkNumber', () {
    test('6 is perfect', () {
      final r = dataSource.checkNumber(6);
      expect(r.isPerfect, isTrue);
      expect(r.divisors, [1, 2, 3]);
      expect(r.divisorSum, 6);
    });

    test('28 is perfect', () {
      final r = dataSource.checkNumber(28);
      expect(r.isPerfect, isTrue);
      expect(r.divisorSum, 28);
    });

    test('496 is perfect', () {
      final r = dataSource.checkNumber(496);
      expect(r.isPerfect, isTrue);
    });

    test('8128 is perfect', () {
      final r = dataSource.checkNumber(8128);
      expect(r.isPerfect, isTrue);
    });

    test('12 is not perfect', () {
      final r = dataSource.checkNumber(12);
      expect(r.isPerfect, isFalse);
      expect(r.divisorSum, 16);
    });

    test('1 is not perfect', () {
      final r = dataSource.checkNumber(1);
      expect(r.isPerfect, isFalse);
      expect(r.divisors, isEmpty);
    });

    test('negative number is not perfect', () {
      final r = dataSource.checkNumber(-5);
      expect(r.isPerfect, isFalse);
    });
  });

  group('findInRange', () {
    test('1..1000 returns [6, 28, 496]', () {
      final results = dataSource.findInRange(1, 1000);
      expect(results.map((r) => r.number).toList(), [6, 28, 496]);
    });

    test('1..5 returns empty', () {
      final results = dataSource.findInRange(1, 5);
      expect(results, isEmpty);
    });

    test('7..27 returns empty', () {
      final results = dataSource.findInRange(7, 27);
      expect(results, isEmpty);
    });
  });
}
