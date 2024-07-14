import 'package:checkout_kata/models/cart_item.dart';
import 'package:checkout_kata/models/promotion/promotion.dart';
import 'package:json_annotation/json_annotation.dart';

part 'buy_n_get_free_promo.g.dart';

@JsonSerializable(explicitToJson: true)
final class BuyNGetFreePromo extends Promotion {
  const BuyNGetFreePromo({
    required this.itemSku,
    required this.nQuantity,
  });

  factory BuyNGetFreePromo.fromJson(Map<String, dynamic> json) =>
      _$BuyNGetFreePromoFromJson(json);

  final String itemSku;
  final int nQuantity;

  @override
  (List<CartItem>, double) applyPromo(List<CartItem> cart) {
    final cartCopy = [...cart];

    final applicableItems = [
      ...cartCopy.where(
        (item) =>
            item.stockItem.sku.toLowerCase() == itemSku.toLowerCase() &&
            item.isPromoApplied == false,
      ),
    ];

    final totalItems = applicableItems.length;
    if (totalItems < nQuantity) return (cart, 0);

    final discountMultiplier = totalItems ~/ nQuantity;

    // remove items to avoid duplicates with and without promo
    cartCopy.removeWhere(applicableItems.contains);
    final promoAppliedItems = applicableItems.map(
      (item) => item.applyPromo(),
    );

    return (
      cartCopy..addAll(promoAppliedItems),
      discountMultiplier * applicableItems.first.stockItem.unitPrice
    );
  }

  @override
  Map<String, dynamic> toJson() => _$BuyNGetFreePromoToJson(this);

  @override
  String get info => 'Buy $nQuantity, get 1 free';
}
