import 'package:checkout_kata/models/cart_item.dart';

abstract class Promotion {
  const Promotion();

  /// given the current [cart] of items, returns the modified cart
  /// and the discount to be applied for a given promo
  /// ```dart
  /// final currentCart = <CartItem>[];
  /// final (cart, discount) = applyPromo(currentCart)
  /// ```
  (List<CartItem>, double) applyPromo(List<CartItem> cart);
}
