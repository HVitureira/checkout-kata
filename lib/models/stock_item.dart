import 'package:checkout_kata/models/cart_item.dart';
import 'package:checkout_kata/models/promotion/promotion.dart';
import 'package:equatable/equatable.dart';

final class StockItem extends Equatable {
  const StockItem({
    required this.sku,
    required this.unitPrice,
    this.promo,
  });

  final String sku;
  final double unitPrice;
  final Promotion? promo;

  CartItem toCartItem() {
    return CartItem(
      stockItem: this,
      isPromoApplied: false,
    );
  }

  @override
  List<Object?> get props => [sku, unitPrice, promo];
}
