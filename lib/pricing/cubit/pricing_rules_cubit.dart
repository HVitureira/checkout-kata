import 'package:checkout_kata/data/shop_items_api.dart';
import 'package:checkout_kata/models/promotion/buy_n_get_free_promo.dart';
import 'package:checkout_kata/models/promotion/meal_deal_promo.dart';
import 'package:checkout_kata/models/promotion/multi_priced_promo.dart';
import 'package:checkout_kata/models/promotion/promotion.dart';
import 'package:checkout_kata/pricing/cubit/pricing_rules_state.dart';
import 'package:checkout_kata/pricing/models/form_promo.dart';
import 'package:checkout_kata/pricing/models/pricing_rule.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class PricingRulesCubit extends HydratedCubit<PricingRulesState> {
  PricingRulesCubit({required this.shopItemsApi})
      : super(
          PricingRulesState(
            items: shopItemsApi.getShopItems(),
          ),
        );

  final ShopItemsApi shopItemsApi;

  void changeRule({required String sku, required PricingRule rule}) {
    final newItems = [...state.items];

    final item = newItems.firstWhere(
      (item) => item.sku.toLowerCase() == sku.toLowerCase(),
    );

    final newPromo = _mapRuleToPromo(sku: sku, rule: rule);
    final updatedItem = item.copyWith(
      unitPrice: rule.price,
      promo: newPromo,
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
          promoPrice: rule.mealDealPrice!,
        );
      case FormPromo.buyNGet1:
        return BuyNGetFreePromo(
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
  }

  @override
  PricingRulesState? fromJson(Map<String, dynamic> json) =>
      PricingRulesState.fromJson(json);

  @override
  Map<String, dynamic>? toJson(PricingRulesState state) => state.toJson();
}
