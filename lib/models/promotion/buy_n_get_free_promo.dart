import 'package:checkout_kata/models/promotion/promotion.dart';
import 'package:checkout_kata/models/stock_item.dart';

final class BuyNGetFreePromo extends Promotion {
  const BuyNGetFreePromo({
    required this.itemSku,
    required this.nQuantity,
  });

  final String itemSku;
  final int nQuantity;

  @override
  double applyPromo(List<StockItem> cart) {
    final applicableItems = cart.where(
      (item) => item.sku.toLowerCase() == itemSku.toLowerCase(),
    );
    final totalItems = applicableItems.length;
    if (totalItems < nQuantity) return 0;

    final discountMultiplier = totalItems ~/ nQuantity;

    return discountMultiplier * applicableItems.first.unitPrice;
  }

  @override
  String toString() {
    return 'Buy $nQuantity itemSku, get 1 free';
  }
}
