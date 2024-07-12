import 'package:checkout_kata/models/stock_item.dart';

abstract class Promotion {
  const Promotion();

  /// given the current cart of items, returns the  discount to be applied
  /// for a given promo
  double applyPromo(List<StockItem> cart);
}
