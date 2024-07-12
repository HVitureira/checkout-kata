import 'package:checkout_kata/models/promotion/promotion.dart';
import 'package:checkout_kata/models/stock_item.dart';

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
  double applyPromo(List<StockItem> cart) {
    final applicableItems = cart.where(
      (item) => item.sku.toLowerCase() == itemSku.toLowerCase(),
    );
    final totalItems = applicableItems.length;
    if (totalItems < promoQuantity) return 0;

    final discountMultiplier = totalItems ~/ promoQuantity;

    return discountMultiplier * promoPrice;
  }

  @override
  String toString() {
    return 'Buy $promoQuantity for $promoPrice£';
  }
}
