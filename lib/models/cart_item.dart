import 'package:checkout_kata/models/stock_item.dart';
import 'package:equatable/equatable.dart';

final class CartItem extends Equatable {
  const CartItem({
    required this.stockItem,
    required this.isPromoApplied,
  });

  final StockItem stockItem;
  final bool isPromoApplied;

  CartItem applyPromo() {
    return CartItem(
      stockItem: stockItem,
      isPromoApplied: true,
    );
  }

  @override
  List<Object?> get props => [
        stockItem,
        isPromoApplied,
      ];
}
