// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pricing_rule.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PricingRule _$PricingRuleFromJson(Map<String, dynamic> json) => PricingRule(
      price: PricingRule._toDouble(json['price'] as String),
      formPromo: $enumDecodeNullable(_$FormPromoEnumMap, json['formPromo']),
      multiPricedQt:
          PricingRule._toNullableInt(json['multiPricedQt'] as String?),
      buyNGet1Quantity:
          PricingRule._toNullableInt(json['buyNGet1Quantity'] as String?),
      multiPricedPrice:
          PricingRule._toNullableDouble(json['multiPricedPrice'] as String?),
      mealDealPrice:
          PricingRule._toNullableDouble(json['mealDealPrice'] as String?),
      dealSkus: (json['dealSkus'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$PricingRuleToJson(PricingRule instance) =>
    <String, dynamic>{
      'price': instance.price,
      'formPromo': _$FormPromoEnumMap[instance.formPromo],
      'multiPricedQt': instance.multiPricedQt,
      'buyNGet1Quantity': instance.buyNGet1Quantity,
      'multiPricedPrice': instance.multiPricedPrice,
      'mealDealPrice': instance.mealDealPrice,
      'dealSkus': instance.dealSkus,
    };

const _$FormPromoEnumMap = {
  FormPromo.mealDeal: 'mealDeal',
  FormPromo.buyNGet1: 'buyNGet1',
  FormPromo.multiPriced: 'multiPriced',
};
