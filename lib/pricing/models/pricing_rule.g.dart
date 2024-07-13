// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pricing_rule.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PricingRule _$PricingRuleFromJson(Map<String, dynamic> json) => PricingRule(
      price: (json['price'] as num).toDouble(),
      formPromo: $enumDecodeNullable(_$FormPromoEnumMap, json['formPromo']),
      multiPricedQt: (json['multiPricedQt'] as num?)?.toInt(),
      buyNGet1Quantity: (json['buyNGet1Quantity'] as num?)?.toInt(),
      multiPricedPrice: (json['multiPricedPrice'] as num?)?.toDouble(),
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
      'dealSkus': instance.dealSkus,
    };

const _$FormPromoEnumMap = {
  FormPromo.mealDeal: 'mealDeal',
  FormPromo.buyNGet1: 'buyNGet1',
  FormPromo.multiPriced: 'multiPriced',
};
