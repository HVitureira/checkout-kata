import 'package:checkout_kata/models/cart_item.dart';
import 'package:checkout_kata/models/promotion/promotion.dart';
import 'package:checkout_kata/utils/utils.dart';
import 'package:json_annotation/json_annotation.dart';

part 'multi_priced_promo.g.dart';

@JsonSerializable(explicitToJson: true)
final class MultiPricedPromo extends Promotion with PoundPriceMixin {
  const MultiPricedPromo({
    required this.itemSku,
    required this.promoQuantity,
    required this.promoPrice,
  });

  factory MultiPricedPromo.fromJson(Map<String, dynamic> json) =>
      _$MultiPricedPromoFromJson(json);
  final String itemSku;
  final int promoQuantity;
  final double promoPrice;

  @override
  (List<CartItem>, double) applyPromo(List<CartItem> cart) {
    final cartCopy = [...cart];

    final applicableItems = [
      ...cartCopy.where(
        (item) =>
            (item.stockItem.sku.toLowerCase() == itemSku.toLowerCase()) &&
            item.isPromoApplied == false,
      ),
    ];
    final totalItems = applicableItems.length;
    if (totalItems < promoQuantity) return (cart, 0);

    final discountMultiplier = totalItems ~/ promoQuantity;

    cartCopy.removeWhere(applicableItems.contains);
    final promoAppliedItems = applicableItems.map((item) => item.applyPromo());
    final prices = promoAppliedItems
        .map((e) => e.stockItem.unitPrice)
        .reduce((value, element) => value + element);

    return (
      cartCopy..addAll(promoAppliedItems),
      (discountMultiplier * prices) - promoPrice
    );
  }

  @override
  Map<String, dynamic> toJson() => _$MultiPricedPromoToJson(this);

  MultiPricedPromo fromJson(Map<String, dynamic> json) =>
      MultiPricedPromo.fromJson(json);

  @override
  String get info => 'Buy $promoQuantity for ${getFormattedPrice(promoPrice)}';
}
