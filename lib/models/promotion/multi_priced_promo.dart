import 'package:checkout_kata/models/cart_item.dart';
import 'package:checkout_kata/models/promotion/promotion.dart';

final class MultiPricedPromo extends Promotion {
  const MultiPricedPromo({
    required this.itemSku,
    required this.promoQuantity,
    required this.promoPrice,
  });
  final String itemSku;
  final int promoQuantity;
  final double promoPrice;

  @override
  (List<CartItem>, double) applyPromo(List<CartItem> cart) {
    final applicableItems = cart.where(
      (item) => item.stockItem.sku.toLowerCase() == itemSku.toLowerCase(),
    );
    final totalItems = applicableItems.length;
    if (totalItems < promoQuantity) return (cart, 0);

    final discountMultiplier = totalItems ~/ promoQuantity;

    cart.removeWhere(applicableItems.contains);
    final promoAppliedItems = applicableItems.map((item) => item.applyPromo());
    final appliedItems = [...cart, ...promoAppliedItems];

    return (
      cart..addAll(appliedItems),
      (applicableItems.first.stockItem.unitPrice * applicableItems.length) -
          (discountMultiplier * promoPrice)
    );
  }

  @override
  String toString() {
    return 'Buy $promoQuantity for $promoPrice£';
  }
}
