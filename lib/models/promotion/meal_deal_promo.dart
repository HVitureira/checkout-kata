import 'package:checkout_kata/models/cart_item.dart';
import 'package:checkout_kata/models/promotion/promotion.dart';
import 'package:checkout_kata/utils/utils.dart';
import 'package:json_annotation/json_annotation.dart';

part 'meal_deal_promo.g.dart';

@JsonSerializable(explicitToJson: true)
final class MealDealPromo extends Promotion with PoundPriceMixin {
  const MealDealPromo({
    required this.sku,
    required this.dealSkus,
    required this.promoPrice,
  });

  @override
  factory MealDealPromo.fromJson(Map<String, dynamic> json) =>
      _$MealDealPromoFromJson(json);

  final String sku;
  final List<String> dealSkus;
  final double promoPrice;

  @override
  (List<CartItem>, double) applyPromo(List<CartItem> cart) {
    final cartCopy = [...cart];

    final applicableItems = [
      ...cartCopy.where(
        (item) =>
            (dealSkus.contains(item.stockItem.sku) ||
                item.stockItem.sku.toLowerCase() == sku.toLowerCase()) &&
            item.isPromoApplied == false,
      ),
    ];
    if (applicableItems.isEmpty) return (cart, 0);

    final itemsToApply = <CartItem>[];

    // Remove duplicate items (with the same props)
    // Problem introduced by the usage of Equatable
    for (var i = 0; i < applicableItems.length; i++) {
      final curItem = applicableItems[i];

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
      cartCopy.remove(item);
    }

    final promoAppliedItems = itemsToApply.map(
      (item) => item.applyPromo(),
    );

    final prices = promoAppliedItems.fold<double>(
      0,
      (sum, item) => sum + item.stockItem.unitPrice,
    );

    return ([...cartCopy, ...promoAppliedItems], prices - promoPrice);
  }

  @override
  Map<String, dynamic> toJson() => _$MealDealPromoToJson(this);

  @override
  String get info {
    final skus = dealSkus.join(',');
    return 'Meal: $skus together, for ${getFormattedPrice(promoPrice)} each';
  }
}
