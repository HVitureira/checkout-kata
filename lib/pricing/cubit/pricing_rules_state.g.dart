// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pricing_rules_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PricingRulesState _$PricingRulesStateFromJson(Map<String, dynamic> json) =>
    PricingRulesState(
      items: (json['items'] as List<dynamic>)
          .map((e) => StockItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PricingRulesStateToJson(PricingRulesState instance) =>
    <String, dynamic>{
      'items': instance.items.map((e) => e.toJson()).toList(),
    };
