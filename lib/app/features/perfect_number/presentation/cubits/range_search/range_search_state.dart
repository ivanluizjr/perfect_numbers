import 'package:equatable/equatable.dart';
import 'package:perfect_numbers/app/features/perfect_number/domain/entities/perfect_number_result.dart';

abstract class RangeSearchState extends Equatable {
  const RangeSearchState();
  @override List<Object?> get props => [];
}

class RangeSearchInitial extends RangeSearchState { const RangeSearchInitial(); }
class RangeSearchLoading extends RangeSearchState { const RangeSearchLoading(); }

class RangeSearchSuccess extends RangeSearchState {
  final List<PerfectNumberResult> results;
  final int start;
  final int end;
  const RangeSearchSuccess(this.results, this.start, this.end);
  @override List<Object?> get props => [results, start, end];
}

class RangeSearchEmpty extends RangeSearchState {
  final int start;
  final int end;
  const RangeSearchEmpty(this.start, this.end);
  @override List<Object?> get props => [start, end];
}

class RangeSearchError extends RangeSearchState {
  final String message;
  const RangeSearchError(this.message);
  @override List<Object?> get props => [message];
}
