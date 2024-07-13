// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meal_deal_promo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MealDealPromo _$MealDealPromoFromJson(Map<String, dynamic> json) =>
    MealDealPromo(
      sku: json['sku'] as String,
      dealSkus:
          (json['dealSkus'] as List<dynamic>).map((e) => e as String).toList(),
      promoPrice: (json['promoPrice'] as num).toDouble(),
    );

Map<String, dynamic> _$MealDealPromoToJson(MealDealPromo instance) =>
    <String, dynamic>{
      'sku': instance.sku,
      'dealSkus': instance.dealSkus,
      'promoPrice': instance.promoPrice,
    };
