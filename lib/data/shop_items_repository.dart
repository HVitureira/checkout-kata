import 'package:checkout_kata/data/shop_items_api.dart';
import 'package:checkout_kata/models/promotion/promotions.dart';
import 'package:checkout_kata/models/stock_item.dart';

final class ShopItemsRepository implements ShopItemsApi {
  @override
  List<StockItem> getShopItems() {
    return [
      const StockItem(sku: 'A', unitPrice: 50),
      const StockItem(
        sku: 'B',
        unitPrice: 75,
        promo: MultiPricedPromo(
          itemSku: 'B',
          promoQuantity: 2,
          promoPrice: 125,
        ),
      ),
      const StockItem(
        sku: 'C',
        unitPrice: 25,
        promo: BuyNGetFreePromo(
          itemSku: 'C',
          nQuantity: 3,
        ),
      ),
      const StockItem(
        sku: 'D',
        unitPrice: 150,
        promo: MealDealPromo(
          sku: 'D',
          dealSkus: ['E'],
          promoPrice: 300,
        ),
      ),
      const StockItem(
        sku: 'E',
        unitPrice: 200,
        promo: MealDealPromo(
          sku: 'E',
          dealSkus: ['D'],
          promoPrice: 300,
        ),
      ),
    ];
  }
}
