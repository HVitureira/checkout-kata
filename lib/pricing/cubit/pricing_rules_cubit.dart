import 'package:checkout_kata/models/promotion/buy_n_get_free_promo.dart';
import 'package:checkout_kata/models/promotion/meal_deal_promo.dart';
import 'package:checkout_kata/models/promotion/multi_priced_promo.dart';
import 'package:checkout_kata/models/promotion/promotion.dart';
import 'package:checkout_kata/models/stock_item.dart';
import 'package:checkout_kata/pricing/models/form_promo.dart';
import 'package:checkout_kata/pricing/models/pricing_rule.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'pricing_rules_state.dart';

class PricingRulesCubit extends Cubit<PricingRulesState> {
  PricingRulesCubit({required List<StockItem> startingItems})
      : super(
          PricingRulesState(
            items: startingItems,
          ),
        );

  void changeRule({required String sku, required PricingRule rule}) {
    final newItems = [...state.items];

    final item = newItems.firstWhere(
      (item) => item.sku.toLowerCase() == sku.toLowerCase(),
    );

    final updatedItem = item.copyWith(
      unitPrice: rule.price,
      promo: _mapRuleToPromo(sku: sku, rule: rule),
    );

    emit(
      PricingRulesState(
        items: newItems
            .map(
              (existingItem) =>
                  existingItem.sku == item.sku ? updatedItem : existingItem,
            )
            .toList(),
      ),
    );
  }

  Promotion? _mapRuleToPromo({required String sku, required PricingRule rule}) {
    switch (rule.formPromo) {
      case FormPromo.mealDeal:
        return MealDealPromo(
          sku: sku,
          dealSkus: rule.dealSkus!,
          promoPrice: rule.multiPricedPrice!,
        );
      case FormPromo.buyNGet1:
        BuyNGetFreePromo(
          itemSku: sku,
          nQuantity: rule.buyNGet1Quantity!,
        );
      case FormPromo.multiPriced:
        return MultiPricedPromo(
          itemSku: sku,
          promoQuantity: rule.multiPricedQt!,
          promoPrice: rule.multiPricedPrice!,
        );
      case null:
        return null;
    }
    return null;
  }
}
