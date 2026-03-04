import 'package:equatable/equatable.dart';
import 'package:perfect_numbers/app/features/perfect_number/domain/entities/perfect_number_result.dart';

enum HistoryEntryType { singleCheck, rangeSearch }

class HistoryEntry extends Equatable {
  final String id;
  final HistoryEntryType type;
  final DateTime timestamp;
  final bool isFavorite;
  final PerfectNumberResult? singleResult;
  final int? rangeStart;
  final int? rangeEnd;
  final List<PerfectNumberResult>? rangeResults;

  const HistoryEntry({
    required this.id,
    required this.type,
    required this.timestamp,
    this.isFavorite = false,
    this.singleResult,
    this.rangeStart,
    this.rangeEnd,
    this.rangeResults,
  });

  HistoryEntry copyWith({bool? isFavorite}) => HistoryEntry(
    id: id,
    type: type,
    timestamp: timestamp,
    isFavorite: isFavorite ?? this.isFavorite,
    singleResult: singleResult,
    rangeStart: rangeStart,
    rangeEnd: rangeEnd,
    rangeResults: rangeResults,
  );

  @override
  List<Object?> get props => [
    id,
    type,
    timestamp,
    isFavorite,
    singleResult,
    rangeStart,
    rangeEnd,
    rangeResults,
  ];
}
