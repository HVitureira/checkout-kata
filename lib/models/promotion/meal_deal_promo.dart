import 'package:checkout_kata/models/cart_item.dart';
import 'package:checkout_kata/models/promotion/promotion.dart';
import 'package:checkout_kata/utils/utils.dart';

final class MealDealPromo extends Promotion with PoundPriceMixin {
  const MealDealPromo({
    required this.sku,
    required this.dealSkus,
    required this.promoPrice,
  });

  final String sku;
  final List<String> dealSkus;
  final double promoPrice;

  @override
  (List<CartItem>, double) applyPromo(List<CartItem> cart) {
    final applicableItems = [
      ...cart.where(
        (item) =>
            (dealSkus.contains(item.stockItem.sku) ||
                item.stockItem.sku.toLowerCase() == sku.toLowerCase()) &&
            item.isPromoApplied == false,
      ),
    ];
    if (applicableItems.isEmpty) return (cart, 0);

    final itemsToApply = <CartItem>[];

    for (final item in applicableItems) {
      final curItem = applicableItems.elementAt(applicableItems.indexOf(item));
      if (!itemsToApply.contains(curItem)) {
        itemsToApply.add(curItem);
      }
    }

    if (itemsToApply.isEmpty) return (cart, 0);

    final skus = itemsToApply.map((item) => item.stockItem.sku).toList();

    if (!dealSkus.every(skus.contains)) {
      return (cart, 0);
    }

    for (final item in itemsToApply) {
      cart.remove(item);
    }

    final promoAppliedItems = itemsToApply.map(
      (item) => item.applyPromo(),
    );

    final prices = promoAppliedItems.fold<double>(
      0,
      (sum, item) => sum + item.stockItem.unitPrice,
    );

    return ([...cart, ...promoAppliedItems], prices - promoPrice);
  }

  @override
  String toString() {
    final skus = dealSkus.join(',');
    return 'Meal: $skus together, for ${getFormattedPrice(promoPrice)} each';
  }
}
