import 'package:equatable/equatable.dart';
import 'package:perfect_numbers/app/features/perfect_number/domain/entities/history_entry.dart';

abstract class HistoryState extends Equatable {
  const HistoryState();
  @override List<Object?> get props => [];
}

class HistoryInitial extends HistoryState { const HistoryInitial(); }
class HistoryLoading extends HistoryState { const HistoryLoading(); }

class HistoryLoaded extends HistoryState {
  final List<HistoryEntry> entries;
  final List<HistoryEntry> favorites;
  const HistoryLoaded({required this.entries, required this.favorites});
  @override List<Object?> get props => [entries, favorites];
}

class HistoryEmpty extends HistoryState { const HistoryEmpty(); }

class HistoryError extends HistoryState {
  final String message;
  const HistoryError(this.message);
  @override List<Object?> get props => [message];
}
