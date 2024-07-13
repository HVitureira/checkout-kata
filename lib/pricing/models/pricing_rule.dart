import 'package:checkout_kata/pricing/models/form_promo.dart';
import 'package:json_annotation/json_annotation.dart';

part 'pricing_rule.g.dart';

@JsonSerializable(explicitToJson: true)
class PricingRule {
  const PricingRule({
    required this.price,
    this.formPromo,
    this.multiPricedQt,
    this.buyNGet1Quantity,
    this.multiPricedPrice,
    this.mealDealPrice,
    this.dealSkus,
  });

  factory PricingRule.fromJson(Map<String, dynamic> json) =>
      _$PricingRuleFromJson(json);

  @JsonKey(fromJson: _toDouble)
  final double price;

  final FormPromo? formPromo;

  @JsonKey(fromJson: _toNullableInt)
  final int? multiPricedQt;

  @JsonKey(fromJson: _toNullableInt)
  final int? buyNGet1Quantity;

  @JsonKey(fromJson: _toNullableDouble)
  final double? multiPricedPrice;

  @JsonKey(fromJson: _toNullableDouble)
  final double? mealDealPrice;

  final List<String>? dealSkus;

  static double _toDouble(String number) {
    return double.parse(number);
  }

  Map<String, dynamic> toJson() => _$PricingRuleToJson(this);

  static double? _toNullableDouble(String? number) {
    if (number == null) return null;
    return double.tryParse(number);
  }

  static int? _toNullableInt(String? number) {
    if (number == null) return null;
    return int.tryParse(number);
  }
}
