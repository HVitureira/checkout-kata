import 'package:checkout_kata/models/stock_item.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'pricing_rules_state.g.dart';

@JsonSerializable(explicitToJson: true)
class PricingRulesState extends Equatable {
  const PricingRulesState({required this.items});

  factory PricingRulesState.fromJson(Map<String, dynamic> json) =>
      _$PricingRulesStateFromJson(json);

  final List<StockItem> items;

  Map<String, dynamic> toJson() => _$PricingRulesStateToJson(this);

  @override
  List<Object> get props => [items];
}
