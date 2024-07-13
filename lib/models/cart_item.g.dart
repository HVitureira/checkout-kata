// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CartItem _$CartItemFromJson(Map<String, dynamic> json) => CartItem(
      stockItem: StockItem.fromJson(json['stockItem'] as Map<String, dynamic>),
      isPromoApplied: json['isPromoApplied'] as bool,
    );

Map<String, dynamic> _$CartItemToJson(CartItem instance) => <String, dynamic>{
      'stockItem': instance.stockItem.toJson(),
      'isPromoApplied': instance.isPromoApplied,
    };
