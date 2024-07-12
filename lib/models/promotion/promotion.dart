import 'package:checkout_kata/models/cart_item.dart';

abstract class Promotion {
  const Promotion();

  /// given the current cart of items, returns the  discount to be applied
  /// for a given promo
  (List<CartItem>, double) applyPromo(List<CartItem> cart);
}
