import 'package:checkout_kata/app/routes/routes.dart';
import 'package:checkout_kata/models/promotion/buy_n_get_free_promo.dart';
import 'package:checkout_kata/models/promotion/meal_deal_promo.dart';
import 'package:checkout_kata/models/promotion/multi_priced_promo.dart';
import 'package:checkout_kata/models/stock_item.dart';
import 'package:flutter/material.dart';

class PricingPage extends StatelessWidget {
  const PricingPage({
    required this.title,
    super.key,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    final defaultRules = [
      const StockItem(sku: 'A', unitPrice: 50),
      const StockItem(
        sku: 'B',
        unitPrice: 75,
        promo: MultiPricedPromo(
          itemSku: 'B',
          promoQuantity: 2,
          promoPrice: 1.25,
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
          dealSkus: ['E'],
          promoPrice: 3,
        ),
      ),
      const StockItem(
        sku: 'E',
        unitPrice: 200,
        promo: MealDealPromo(
          dealSkus: ['D'],
          promoPrice: 3,
        ),
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              "Define this week's prices",
            ),
            const SizedBox(
              height: 20,
            ),
            const Divider(height: 0),
            Expanded(
              child: ListView.builder(
                itemCount: defaultRules.length,
                itemBuilder: (context, index) {
                  final currentItem = defaultRules.elementAt(index);
                  final itemTitle = currentItem.sku;
                  final itemPrice = currentItem.unitPrice;
                  final itemPromo = currentItem.promo;

                  return Column(
                    children: [
                      ListTile(
                        leading: const Icon(Icons.shopping_bag_sharp),
                        title: Text(itemTitle),
                        subtitle: Text('Price: $itemPrice, Promo: $itemPromo'),
                      ),
                      const Divider(height: 0),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsetsDirectional.all(10),
          child: ElevatedButton(
            onPressed: () => _pushCheckoutPage(
              context: context,
              items: defaultRules,
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.shopping_cart_checkout),
                SizedBox(
                  width: 10,
                ),
                Text('Start Checkout'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _pushCheckoutPage({
    required BuildContext context,
    required List<StockItem> items,
  }) {
    Navigator.pushNamed(
      context,
      AppRoutes.checkoutPage,
      arguments: items,
    );
  }
}
