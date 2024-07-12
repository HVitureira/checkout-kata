import 'package:checkout_kata/models/promotion/promotion.dart';
import 'package:checkout_kata/models/stock_item.dart';

final class MealDealPromo extends Promotion {
  const MealDealPromo({
    required this.dealSkus,
    required this.promoPrice,
  });

  final List<String> dealSkus;
  final double promoPrice;

  @override
  double applyPromo(List<StockItem> cart) {
    final applicableItems = cart.where(
      (item) => dealSkus.contains(item.sku),
    );
    if (applicableItems.isEmpty) return 0;

    final skus = applicableItems.map((item) => item.sku);

    if (!skus.every(dealSkus.contains)) {
      return 0;
    }

    final prices = applicableItems.map((item) => item.unitPrice);
    final totalPrice = prices.reduce((value, element) => value + element);
    //assuming only pairs of products

    // TODO: consider sets of 3 or more products
    return totalPrice - promoPrice * 2;
  }

  @override
  String toString() {
    final skus = dealSkus.join(',');
    return 'Meal: $skus together, for $promoPrice£ each';
  }
}
