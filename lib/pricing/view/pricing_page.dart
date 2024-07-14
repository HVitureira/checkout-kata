import 'package:checkout_kata/app/routes/routes.dart';
import 'package:checkout_kata/app/widgets/shop_list.dart';
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
                    children: [
                      Expanded(
                        child: ShopList(
                          items: state.items,
                          trailingIcon: Icons.edit,
                          leadingIcon: Icons.shopping_bag_sharp,
                          onTrailingPressed: (item) => _showEditDialog(
                            context: context,
                            item: item,
                            availableItems: state.items,
                          ),
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
