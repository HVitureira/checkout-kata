import 'package:checkout_kata/models/promotion/buy_n_get_free_promo.dart';
import 'package:checkout_kata/models/promotion/meal_deal_promo.dart';
import 'package:checkout_kata/models/promotion/multi_priced_promo.dart';
import 'package:checkout_kata/models/promotion/promotion.dart';
import 'package:checkout_kata/models/stock_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

abstract class ItemPricingSheet {
  static Future<void> show({
    required BuildContext context,
    required StockItem item,
    required List<StockItem> availableItems,
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
        return _ItemPricingForm(
          key: key,
          item: item,
          availableItems: availableItems,
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
    formPromo = _mapPromotionToFormPromo(item.promo);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormBuilderState>();
    final startingPromo = item.promo;

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
              FormBuilderDropdown<FormPromo?>(
                name: 'promo',
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
                  name: 'buyNGet1',
                  initialValue: startingPromo is BuyNGetFreePromo
                      ? startingPromo.nQuantity.toString()
                      : null,
                  validator: FormBuilderValidators.integer(),
                  decoration: const InputDecoration(
                    label: Text('Quantity'),
                  ),
                  keyboardType: TextInputType.number,
                ),
              if (formPromo == FormPromo.mealDeal)
                FormBuilderCheckboxGroup<String>(
                  name: 'mealDeal',
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
                    FormBuilderValidators.minLength(1),
                  ]),
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
