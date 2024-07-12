import 'package:checkout_kata/models/cart_item.dart';
import 'package:checkout_kata/models/promotion/promotion.dart';

final class BuyNGetFreePromo extends Promotion {
  const BuyNGetFreePromo({
    required this.itemSku,
    required this.nQuantity,
  });

  final String itemSku;
  final int nQuantity;

  @override
  (List<CartItem>, double) applyPromo(List<CartItem> cart) {
    final applicableItems = [
      ...cart.where(
        (item) =>
            item.stockItem.sku.toLowerCase() == itemSku.toLowerCase() &&
            item.isPromoApplied == false,
      ),
    ];

    final totalItems = applicableItems.length;
    if (totalItems < nQuantity) return (cart, 0);

    final discountMultiplier = totalItems ~/ nQuantity;

    cart.removeWhere(applicableItems.contains);
    final promoAppliedItems = applicableItems.map(
      (item) => item.applyPromo(),
    );

    return (
      cart..addAll(promoAppliedItems),
      discountMultiplier * applicableItems.first.stockItem.unitPrice
    );
  }

  @override
  String toString() {
    return 'Buy $nQuantity, get 1 free';
  }
}
