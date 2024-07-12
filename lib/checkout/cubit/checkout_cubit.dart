import 'package:checkout_kata/models/stock_item.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'checkout_state.dart';

class CheckoutCubit extends Cubit<CheckoutState> {
  CheckoutCubit({required List<StockItem> startingItems})
      : super(CheckoutInitial(items: startingItems));

  void checkOutItem({required String sku}) {
    final item = state.items.firstWhere(
      (item) => item.sku.toLowerCase() == sku.toLowerCase(),
    );

    var itemCost = item.unitPrice;
    var discount = 0.0;
    final checkedItems = [...state.checkedItems, item];
    if (item.promo != null) {
      discount = item.promo!.applyPromo(
        checkedItems,
      );
      itemCost -= discount;
    }

    //final processedItems = [...state.items..remove(item)];

    emit(
      CheckoutProcessed(
        items: state.items,
        checkedItems: checkedItems,
        totalCost: state.totalCost + itemCost,
        totalDiscount: state.totalDiscount + discount,
      ),
    );
  }
}
