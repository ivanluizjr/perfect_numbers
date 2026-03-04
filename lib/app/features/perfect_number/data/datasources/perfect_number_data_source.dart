import 'dart:math';
import 'package:perfect_numbers/app/features/perfect_number/domain/entities/perfect_number_result.dart';

class PerfectNumberDataSource {
  const PerfectNumberDataSource();

  PerfectNumberResult checkNumber(int number) {
    if (number < 1) {
      return PerfectNumberResult(number: number, isPerfect: false, divisors: [], divisorSum: 0);
    }
    final divisors = _getProperDivisors(number);
    final sum = divisors.fold(0, (a, b) => a + b);
    return PerfectNumberResult(
      number: number,
      isPerfect: sum == number,
      divisors: divisors,
      divisorSum: sum,
    );
  }

  List<PerfectNumberResult> findInRange(int start, int end) {
    final results = <PerfectNumberResult>[];
    for (var n = start; n <= end; n++) {
      final r = checkNumber(n);
      if (r.isPerfect) results.add(r);
    }
    return results;
  }

  List<int> _getProperDivisors(int n) {
    if (n <= 1) return n == 1 ? [] : [];
    final divisors = <int>[1];
    final sqrtN = sqrt(n).toInt();
    for (var i = 2; i <= sqrtN; i++) {
      if (n % i == 0) {
        divisors.add(i);
        if (i != n ~/ i) divisors.add(n ~/ i);
      }
    }
    divisors.sort();
    return divisors;
  }
}
