import 'package:checkout_kata/models/promotion/buy_n_get_free_promo.dart';
import 'package:checkout_kata/models/promotion/meal_deal_promo.dart';
import 'package:checkout_kata/models/promotion/multi_priced_promo.dart';
import 'package:checkout_kata/models/stock_item.dart';
import 'package:checkout_kata/pricing/cubit/cubit.dart';
import 'package:checkout_kata/pricing/models/form_promo.dart';
import 'package:checkout_kata/pricing/models/pricing_rule.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

abstract class ItemPricingSheet {
  static Future<void> show({
    required BuildContext context,
    required StockItem item,
    required List<StockItem> availableItems,
    required PricingRulesCubit pricingRulesCubit,
    Key? key,
  }) {
    return showModalBottomSheet<void>(
      useSafeArea: true,
      context: context,
      isScrollControlled: true,
      constraints: BoxConstraints.tightFor(
        // Set minimum and maximum heights
        width: MediaQuery.of(context).size.width, // Full width
      ),
      builder: (context) {
        return BlocProvider<PricingRulesCubit>.value(
          value: pricingRulesCubit,
          child: _ItemPricingForm(
            key: key,
            item: item,
            availableItems: availableItems,
          ),
        );
      },
    );
  }
}

class _ItemPricingForm extends StatefulWidget {
  const _ItemPricingForm({
    required this.item,
    required this.availableItems,
    super.key,
  });

  final StockItem item;
  final List<StockItem> availableItems;

  @override
  State<_ItemPricingForm> createState() => _ItemPricingFormState();
}

class _ItemPricingFormState extends State<_ItemPricingForm> {
  StockItem get item => widget.item;
  List<StockItem> get availableItems => widget.availableItems;

  late FormPromo? formPromo;
  @override
  void initState() {
    formPromo = item.promo?.asFormPromo;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormBuilderState>();
    final startingPromo = item.promo;
    const priceFieldKey = 'price';
    const promoFieldKey = 'promo';
    const buyNGet1FieldQtKey = 'buyNGet1Quantity';
    const mealDealSkusFieldKey = 'dealSkus';
    const mealDealPriceFieldKey = 'mealDealPrice';
    const mPricedQtFieldKey = 'multiPricedQt';
    const mPricedPriceFieldKey = 'multiPricedPrice';

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
      body: BlocListener<PricingRulesCubit, PricingRulesState>(
        listener: _rulesCubitListener,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: FormBuilder(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                FormBuilderTextField(
                  name: priceFieldKey,
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
                FormBuilderDropdown<FormPromo?>(
                  name: promoFieldKey,
                  initialValue: formPromo,
                  decoration: const InputDecoration(labelText: 'Promotion'),
                  items: [
                    const DropdownMenuItem(
                      alignment: AlignmentDirectional.center,
                      child: Text('None'),
                    ),
                    ...FormPromo.values.map(
                      (promo) => DropdownMenuItem(
                        alignment: AlignmentDirectional.center,
                        value: promo,
                        child: Text(promo.name),
                      ),
                    ),
                  ],
                  onChanged: (value) => setState(() {
                    formPromo = value;
                  }),
                ),
                if (formPromo == FormPromo.buyNGet1)
                  FormBuilderTextField(
                    name: buyNGet1FieldQtKey,
                    initialValue: startingPromo is BuyNGetFreePromo
                        ? startingPromo.nQuantity.toString()
                        : null,
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.integer(),
                      FormBuilderValidators.min(2),
                    ]),
                    decoration: const InputDecoration(
                      label: Text('Quantity'),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                if (formPromo == FormPromo.mealDeal) ...[
                  FormBuilderCheckboxGroup<String>(
                    name: mealDealSkusFieldKey,
                    decoration: const InputDecoration(
                      label: Text('Choose the deal group'),
                    ),
                    options: availableItems
                        .where((i) => i.sku != item.sku)
                        .map(
                          (optionItem) => FormBuilderFieldOption(
                            value: optionItem.sku,
                          ),
                        )
                        .toList(),
                    initialValue: startingPromo is MealDealPromo
                        ? startingPromo.dealSkus
                        : null,
                    separator: const VerticalDivider(
                      width: 10,
                      thickness: 5,
                    ),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                      FormBuilderValidators.minLength(1),
                    ]),
                  ),
                  FormBuilderTextField(
                    name: mealDealPriceFieldKey,
                    initialValue: startingPromo is MealDealPromo
                        ? startingPromo.promoPrice.toString()
                        : null,
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                      FormBuilderValidators.numeric(),
                    ]),
                    decoration: const InputDecoration(
                      label: Text('Multi-price promo price'),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ],
                if (formPromo == FormPromo.multiPriced) ...[
                  FormBuilderTextField(
                    name: mPricedQtFieldKey,
                    initialValue: startingPromo is MultiPricedPromo
                        ? startingPromo.promoQuantity.toString()
                        : null,
                    validator: FormBuilderValidators.integer(),
                    decoration: const InputDecoration(
                      label: Text('Multi-price promo quantity'),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  FormBuilderTextField(
                    name: mPricedPriceFieldKey,
                    initialValue: startingPromo is MultiPricedPromo
                        ? startingPromo.promoPrice.toString()
                        : null,
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                      FormBuilderValidators.numeric(),
                    ]),
                    decoration: const InputDecoration(
                      label: Text('Multi-price promo price'),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ],
                const SizedBox(
                  height: 10,
                ),
                MaterialButton(
                  color: Theme.of(context).colorScheme.secondary,
                  minWidth: double.infinity,
                  onPressed: () {
                    // Validate and save the form values
                    final isValid = formKey.currentState?.saveAndValidate();
                    if (isValid ?? false) {
                      final rule = PricingRule.fromJson(
                        {
                          'formPromo': formPromo?.name,
                          ...formKey.currentState!.value,
                        },
                      );
                      context.read<PricingRulesCubit>().changeRule(
                            sku: item.sku,
                            rule: rule,
                          );
                    }
                  },
                  child: const Text('Edit'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _rulesCubitListener(BuildContext context, PricingRulesState rulesState) {
    Navigator.pop(context);
  }
}
