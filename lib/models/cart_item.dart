import 'package:checkout_kata/models/stock_item.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'cart_item.g.dart';

@JsonSerializable(explicitToJson: true)
final class CartItem extends Equatable {
  const CartItem({
    required this.stockItem,
    required this.isPromoApplied,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) =>
      _$CartItemFromJson(json);

  final StockItem stockItem;
  final bool isPromoApplied;

  Map<String, dynamic> toJson() => _$CartItemToJson(this);

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
