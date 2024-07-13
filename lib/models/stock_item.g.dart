// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stock_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StockItem _$StockItemFromJson(Map<String, dynamic> json) => StockItem(
      sku: json['sku'] as String,
      unitPrice: (json['unitPrice'] as num).toDouble(),
      promo: json['promo'] == null
          ? null
          : Promotion.fromJson(json['promo'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$StockItemToJson(StockItem instance) => <String, dynamic>{
      'sku': instance.sku,
      'unitPrice': instance.unitPrice,
      'promo': instance.promo?.toJson(),
    };
