// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'analytics_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AnalyticsEntityImpl _$$AnalyticsEntityImplFromJson(
  Map<String, dynamic> json,
) => _$AnalyticsEntityImpl(
  id: (json['id'] as num).toInt(),
  month: DateTime.parse(json['month'] as String),
  totalIncome: (json['totalIncome'] as num).toDouble(),
  totalExpenses: (json['totalExpenses'] as num).toDouble(),
  savings: (json['savings'] as num).toDouble(),
  updatedAt: DateTime.parse(json['updatedAt'] as String),
);

Map<String, dynamic> _$$AnalyticsEntityImplToJson(
  _$AnalyticsEntityImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'month': instance.month.toIso8601String(),
  'totalIncome': instance.totalIncome,
  'totalExpenses': instance.totalExpenses,
  'savings': instance.savings,
  'updatedAt': instance.updatedAt.toIso8601String(),
};
