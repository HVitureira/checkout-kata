import 'package:checkout_kata/models/cart_item.dart';
import 'package:checkout_kata/models/promotion/promotion.dart';

final class MealDealPromo extends Promotion {
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
    final applicableSet = Set<CartItem>.from(applicableItems);
    if (applicableSet.isEmpty) return (cart, 0);

    final skus = applicableSet.map((item) => item.stockItem.sku).toList();

    if (!dealSkus.every(skus.contains)) {
      return (cart, 0);
    }

    cart.removeWhere(applicableSet.contains);
    final promoAppliedItems =
        applicableSet.map((item) => item.applyPromo()).toList();
    final prices = promoAppliedItems
        .map((e) => e.stockItem.unitPrice)
        .reduce((value, element) => value + element);

    return (cart..addAll(promoAppliedItems), prices - promoPrice);
  }

  @override
  String toString() {
    final skus = dealSkus.join(',');
    return 'Meal: $skus together, for $promoPrice£ each';
  }
}
