import 'package:perfect_numbers/app/features/perfect_number/data/models/perfect_number_result_model.dart';
import 'package:perfect_numbers/app/features/perfect_number/domain/entities/history_entry.dart';

class HistoryEntryModel extends HistoryEntry {
  const HistoryEntryModel({
    required super.id,
    required super.type,
    required super.timestamp,
    super.isFavorite,
    super.singleResult,
    super.rangeStart,
    super.rangeEnd,
    super.rangeResults,
  });

  factory HistoryEntryModel.fromEntity(HistoryEntry e) => HistoryEntryModel(
    id: e.id,
    type: e.type,
    timestamp: e.timestamp,
    isFavorite: e.isFavorite,
    singleResult: e.singleResult,
    rangeStart: e.rangeStart,
    rangeEnd: e.rangeEnd,
    rangeResults: e.rangeResults,
  );

  factory HistoryEntryModel.fromJson(Map<String, dynamic> json) {
    final typeStr = json['type'] as String;
    final type = typeStr == 'rangeSearch'
        ? HistoryEntryType.rangeSearch
        : HistoryEntryType.singleCheck;

    PerfectNumberResultModel? single;
    if (json['singleResult'] != null) {
      single = PerfectNumberResultModel.fromJson(json['singleResult'] as Map<String, dynamic>);
    }

    List<PerfectNumberResultModel>? rangeResults;
    if (json['rangeResults'] != null) {
      rangeResults = (json['rangeResults'] as List)
          .map((e) => PerfectNumberResultModel.fromJson(e as Map<String, dynamic>))
          .toList();
    }

    return HistoryEntryModel(
      id: json['id'] as String,
      type: type,
      timestamp: DateTime.parse(json['timestamp'] as String),
      isFavorite: json['isFavorite'] as bool? ?? false,
      singleResult: single,
      rangeStart: json['rangeStart'] as int?,
      rangeEnd: json['rangeEnd'] as int?,
      rangeResults: rangeResults,
    );
  }

  Map<String, dynamic> toJson() {
    final sr = singleResult;
    final rr = rangeResults;
    return {
      'id': id,
      'type': type == HistoryEntryType.rangeSearch ? 'rangeSearch' : 'singleCheck',
      'timestamp': timestamp.toIso8601String(),
      'isFavorite': isFavorite,
      if (sr != null) 'singleResult': PerfectNumberResultModel.fromEntity(sr).toJson(),
      if (rangeStart != null) 'rangeStart': rangeStart,
      if (rangeEnd != null) 'rangeEnd': rangeEnd,
      if (rr != null) 'rangeResults': rr.map((e) => PerfectNumberResultModel.fromEntity(e).toJson()).toList(),
    };
  }

  @override
  HistoryEntryModel copyWith({bool? isFavorite}) => HistoryEntryModel(
    id: id,
    type: type,
    timestamp: timestamp,
    isFavorite: isFavorite ?? this.isFavorite,
    singleResult: singleResult,
    rangeStart: rangeStart,
    rangeEnd: rangeEnd,
    rangeResults: rangeResults,
  );
}
