import 'package:checkout_kata/pricing/models/form_promo.dart';
import 'package:json_annotation/json_annotation.dart';

part 'pricing_rule.g.dart';

@JsonSerializable()
class PricingRule {
  const PricingRule({
    required this.price,
    this.formPromo,
    this.multiPricedQt,
    this.buyNGet1Quantity,
    this.multiPricedPrice,
    this.dealSkus,
  });

  factory PricingRule.fromJson(Map<String, dynamic> json) =>
      _$PricingRuleFromJson(json);

  Map<String, dynamic> toJson() => _$PricingRuleToJson(this);

  final double price;
  final FormPromo? formPromo;
  final int? multiPricedQt;
  final int? buyNGet1Quantity;
  final double? multiPricedPrice;
  final List<String>? dealSkus;
}
