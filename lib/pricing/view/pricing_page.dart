import 'package:checkout_kata/app/routes/routes.dart';
import 'package:checkout_kata/models/promotion/buy_n_get_free_promo.dart';
import 'package:checkout_kata/models/promotion/meal_deal_promo.dart';
import 'package:checkout_kata/models/promotion/multi_priced_promo.dart';
import 'package:checkout_kata/models/promotion/promotion.dart';
import 'package:checkout_kata/models/stock_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

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

  void _showEditDialog({
    required BuildContext context,
    required StockItem item,
  }) {
    final formKey = GlobalKey<FormBuilderState>();

    showModalBottomSheet<void>(
      useSafeArea: true,
      context: context,
      isScrollControlled: true,
      constraints: BoxConstraints.tightFor(
        // Set minimum and maximum heights
        width: MediaQuery.of(context).size.width, // Full width
      ),
      builder: (context) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            leading: IconButton(
              icon: const Icon(
                Icons.close_rounded,
              ),
              onPressed: () => Navigator.pop(context),
            ),
            title: Text('Edit item ${item.sku}'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(10),
            child: FormBuilder(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  FormBuilderTextField(
                    name: 'price',
                    initialValue: item.unitPrice.toString(),
                    decoration: const InputDecoration(
                      labelText: 'Unit Price (in pence)',
                    ),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                      FormBuilderValidators.numeric(),
                    ]),
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                  ),
                  const SizedBox(height: 10),
                  FormBuilderDropdown(
                    name: 'promo',
                    initialValue: _mapPromotionToFormPromo(item.promo),
                    decoration: const InputDecoration(labelText: 'Promotion'),
                    items: FormPromo.values
                        .map(
                          (promo) => DropdownMenuItem(
                            alignment: AlignmentDirectional.center,
                            value: promo,
                            child: Text(promo.name),
                          ),
                        )
                        .toList(),
                  ),
                  MaterialButton(
                    color: Theme.of(context).colorScheme.secondary,
                    onPressed: () {
                      // Validate and save the form values
                      formKey.currentState?.saveAndValidate();
                      debugPrint(formKey.currentState?.value.toString());

                      // On another side, can access all field values without saving form with instantValues
                      formKey.currentState?.validate();
                      debugPrint(formKey.currentState?.instantValue.toString());
                    },
                    child: const Text('Edit'),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  FormPromo? _mapPromotionToFormPromo(Promotion? promo) {
    switch (promo.runtimeType) {
      case BuyNGetFreePromo:
        return FormPromo.buyNGet1;
      case MealDealPromo:
        return FormPromo.mealDeal;
      case MultiPricedPromo:
        return FormPromo.multiPriced;
      default:
        return null;
    }
  }
}

enum FormPromo {
  mealDeal,
  buyNGet1,
  multiPriced,
}
