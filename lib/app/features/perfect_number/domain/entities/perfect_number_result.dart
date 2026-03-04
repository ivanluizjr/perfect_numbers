import 'package:equatable/equatable.dart';

class PerfectNumberResult extends Equatable {
  final int number;
  final bool isPerfect;
  final List<int> divisors;
  final int divisorSum;

  const PerfectNumberResult({
    required this.number,
    required this.isPerfect,
    required this.divisors,
    required this.divisorSum,
  });

  @override
  List<Object?> get props => [number, isPerfect, divisors, divisorSum];

  String get divisorsExpression {
    if (divisors.isEmpty) return '0';
    return '${divisors.join(' + ')} = $divisorSum';
  }
}
