import 'package:checkout_kata/models/stock_item.dart';

abstract interface class ShopItemsApi {
  List<StockItem> getShopItems();
}
