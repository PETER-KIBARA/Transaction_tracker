import 'package:freezed_annotation/freezed_annotation.dart';

part 'analytics_entity.freezed.dart';
part 'analytics_entity.g.dart';

/// Entity representing analytics data
@freezed
class AnalyticsEntity with _$AnalyticsEntity {
  const factory AnalyticsEntity({
    required int id,
    required DateTime month,
    required double totalIncome,
    required double totalExpenses,
    required double savings,
    required DateTime updatedAt,
  }) = _AnalyticsEntity;

  factory AnalyticsEntity.fromJson(Map<String, dynamic> json) =>
      _$AnalyticsEntityFromJson(json);
}
