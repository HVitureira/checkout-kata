part of 'pricing_rules_cubit.dart';

class PricingRulesState extends Equatable {
  const PricingRulesState({required this.items});

  final List<StockItem> items;

  @override
  List<Object> get props => [items];
}
