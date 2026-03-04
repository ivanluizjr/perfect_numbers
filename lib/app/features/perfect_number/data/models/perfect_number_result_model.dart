import 'package:perfect_numbers/app/features/perfect_number/domain/entities/perfect_number_result.dart';

class PerfectNumberResultModel extends PerfectNumberResult {
  const PerfectNumberResultModel({
    required super.number,
    required super.isPerfect,
    required super.divisors,
    required super.divisorSum,
  });

  factory PerfectNumberResultModel.fromEntity(PerfectNumberResult e) =>
      PerfectNumberResultModel(
        number: e.number,
        isPerfect: e.isPerfect,
        divisors: e.divisors,
        divisorSum: e.divisorSum,
      );

  factory PerfectNumberResultModel.fromJson(Map<String, dynamic> json) =>
      PerfectNumberResultModel(
        number: json['number'] as int,
        isPerfect: json['isPerfect'] as bool,
        divisors: (json['divisors'] as List).map((e) => e as int).toList(),
        divisorSum: json['divisorSum'] as int,
      );

  Map<String, dynamic> toJson() => {
    'number': number,
    'isPerfect': isPerfect,
    'divisors': divisors,
    'divisorSum': divisorSum,
  };
}
