import 'package:checkout_kata/models/cart_item.dart';
import 'package:checkout_kata/models/promotion/promotion.dart';
import 'package:checkout_kata/utils/pound_price_mixin.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'stock_item.g.dart';

@JsonSerializable(explicitToJson: true)
final class StockItem extends Equatable with PoundPriceMixin {
  const StockItem({
    required this.sku,
    required this.unitPrice,
    this.promo,
  });

  factory StockItem.fromJson(Map<String, dynamic> json) =>
      _$StockItemFromJson(json);

  final String sku;
  final double unitPrice;
  final Promotion? promo;

  Map<String, dynamic> toJson() => _$StockItemToJson(this);

  StockItem copyWith({required Promotion? promo, double? unitPrice}) {
    return StockItem(
      sku: sku,
      unitPrice: unitPrice ?? this.unitPrice,
      promo: promo, // Careful to not override promos
    );
  }

  CartItem toCartItem() {
    return CartItem(
      stockItem: this,
      isPromoApplied: false,
    );
  }

  String get formattedPrice => getFormattedPrice(unitPrice);

  @override
  List<Object?> get props => [sku, unitPrice, promo];
}
