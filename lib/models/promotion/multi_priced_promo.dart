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
    final applicableItems = [
      ...cart.where(
        (item) =>
            (item.stockItem.sku.toLowerCase() == itemSku.toLowerCase()) &&
            item.isPromoApplied == false,
      ),
    ];
    final totalItems = applicableItems.length;
    if (totalItems < promoQuantity) return (cart, 0);

    final discountMultiplier = totalItems ~/ promoQuantity;

    cart.removeWhere(applicableItems.contains);
    final promoAppliedItems = applicableItems.map((item) => item.applyPromo());
    final prices = promoAppliedItems
        .map((e) => e.stockItem.unitPrice)
        .reduce((value, element) => value + element);

    return (
      cart..addAll(promoAppliedItems),
      (discountMultiplier * prices) - promoPrice
    );
  }

  @override
  String toString() {
    return 'Buy $promoQuantity for $promoPrice£';
  }
}
