import 'package:equatable/equatable.dart';
import 'package:perfect_numbers/app/features/perfect_number/domain/entities/perfect_number_result.dart';

abstract class CheckNumberState extends Equatable {
  const CheckNumberState();
  @override
  List<Object?> get props => [];
}

class CheckNumberInitial extends CheckNumberState {
  const CheckNumberInitial();
}

class CheckNumberLoading extends CheckNumberState {
  const CheckNumberLoading();
}

class CheckNumberSuccess extends CheckNumberState {
  final PerfectNumberResult result;
  const CheckNumberSuccess(this.result);
  @override
  List<Object?> get props => [result];
}

class CheckNumberError extends CheckNumberState {
  final String message;
  const CheckNumberError(this.message);
  @override
  List<Object?> get props => [message];
}
