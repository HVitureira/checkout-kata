import 'package:checkout_kata/models/promotion/promotion.dart';

sealed class StockItem {
  const StockItem({
    required this.sku,
    required this.unitPrice,
    this.promo,
  });

  final String sku;
  final double unitPrice;
  final Promotion? promo;
}
