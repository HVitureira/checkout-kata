// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'multi_priced_promo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MultiPricedPromo _$MultiPricedPromoFromJson(Map<String, dynamic> json) =>
    MultiPricedPromo(
      itemSku: json['itemSku'] as String,
      promoQuantity: (json['promoQuantity'] as num).toInt(),
      promoPrice: (json['promoPrice'] as num).toDouble(),
    );

Map<String, dynamic> _$MultiPricedPromoToJson(MultiPricedPromo instance) =>
    <String, dynamic>{
      'itemSku': instance.itemSku,
      'promoQuantity': instance.promoQuantity,
      'promoPrice': instance.promoPrice,
    };
