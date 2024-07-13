import 'package:checkout_kata/models/cart_item.dart';
import 'package:checkout_kata/models/promotion/buy_n_get_free_promo.dart';
import 'package:checkout_kata/models/promotion/meal_deal_promo.dart';
import 'package:checkout_kata/models/promotion/multi_priced_promo.dart';
import 'package:checkout_kata/pricing/models/form_promo.dart';

abstract class Promotion {
  const Promotion();

  /// given the current [cart] of items, returns the modified cart
  /// and the discount to be applied for a given promo
  /// ```dart
  /// final currentCart = <CartItem>[];
  /// final (cart, discount) = applyPromo(currentCart)
  /// ```
  (List<CartItem>, double) applyPromo(List<CartItem> cart);

  FormPromo? get asFormPromo {
    switch (runtimeType) {
      case BuyNGetFreePromo:
        return FormPromo.buyNGet1;
      case MealDealPromo:
        return FormPromo.mealDeal;
      case MultiPricedPromo:
        return FormPromo.multiPriced;
      default:
        return null;
    }
  }
}
