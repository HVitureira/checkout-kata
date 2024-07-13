import 'package:checkout_kata/app/routes/routes.dart';
import 'package:checkout_kata/data/shop_items_api.dart';
import 'package:checkout_kata/models/stock_item.dart';
import 'package:checkout_kata/pricing/cubit/cubit.dart';
import 'package:checkout_kata/pricing/view/item_pricing_rules_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PricingPage extends StatelessWidget {
  const PricingPage({
    required this.title,
    super.key,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PricingRulesCubit>(
      create: (context) => PricingRulesCubit(
        shopItemsApi: context.read<ShopItemsApi>(),
      ),
      child: Builder(
        builder: (context) {
          return BlocBuilder<PricingRulesCubit, PricingRulesState>(
            builder: (context, state) {
              return Scaffold(
                appBar: AppBar(
                  backgroundColor: Theme.of(context).colorScheme.inversePrimary,
                  title: Text(title),
                ),
                body: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: ListView.builder(
                          itemCount: state.items.length,
                          itemBuilder: (context, index) {
                            final currentItem = state.items.elementAt(index);
                            final itemTitle = currentItem.sku;
                            final itemPrice = currentItem.formattedPrice;
                            final itemPromo = currentItem.promo;

                            return Column(
                              children: [
                                ListTile(
                                  leading: const Icon(Icons.shopping_bag_sharp),
                                  title: Text(itemTitle),
                                  subtitle: Text(
                                    'Price: $itemPrice, '
                                    'Promo: ${itemPromo ?? 'No promo'}',
                                  ),
                                  trailing: IconButton(
                                    icon: const Icon(Icons.edit),
                                    onPressed: () => _showEditDialog(
                                      context: context,
                                      item: currentItem,
                                      availableItems: state.items,
                                    ),
                                  ),
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
            },
          );
        },
      ),
    );
  }

  void _pushCheckoutPage({
    required BuildContext context,
  }) {
    Navigator.pushNamed(
      context,
      AppRoutes.checkoutPage,
      arguments: context.read<PricingRulesCubit>().state.items,
    );
  }

  void _showEditDialog({
    required BuildContext context,
    required StockItem item,
    required List<StockItem> availableItems,
  }) {
    ItemPricingSheet.show(
      context: context,
      item: item,
      availableItems: availableItems,
      pricingRulesCubit: context.read<PricingRulesCubit>(),
    );
  }
}
