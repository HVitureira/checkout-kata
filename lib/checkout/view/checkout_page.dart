import 'package:checkout_kata/app/widgets/shop_list.dart';
import 'package:checkout_kata/checkout/cubit/checkout_cubit.dart';
import 'package:checkout_kata/checkout/view/receipt_item.dart';
import 'package:checkout_kata/models/cart_item.dart';
import 'package:checkout_kata/models/stock_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CheckOutPage extends StatelessWidget {
  const CheckOutPage({required this.items, super.key});

  final List<StockItem> items;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CheckoutCubit(
        startingItems: items,
      ),
      child: Builder(
        builder: (context) {
          return BlocBuilder<CheckoutCubit, CheckoutState>(
            builder: (context, state) {
              return Scaffold(
                appBar: AppBar(
                  backgroundColor: Theme.of(context).colorScheme.inversePrimary,
                  title: const Text('Checkout'),
                ),
                body: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Total Cost: ${state.formattedCost}'),
                          Text('Total discount: ${state.formattedDiscount}'),
                          Text(
                            'Total checked items: ${state.checkedItems.length}',
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: ShopList(
                        items: state.items,
                        leadingIcon: Icons.shopping_basket_rounded,
                        trailingIcon: Icons.shopping_cart_checkout_rounded,
                        onTrailingPressed: (item) => context
                            .read<CheckoutCubit>()
                            .checkOutItem(sku: item.sku),
                      ),
                    ),
                  ],
                ),
                bottomSheet: BottomAppBar(
                  child: Padding(
                    padding: const EdgeInsetsDirectional.all(10),
                    child: ElevatedButton(
                      onPressed: () => _showReceipt(
                        context: context,
                        items: state.checkedItems,
                        totalCost: state.formattedCost,
                        totalDiscount: state.formattedDiscount,
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Finish Checkout'),
                          SizedBox(
                            width: 10,
                          ),
                          Icon(Icons.shopping_cart_checkout),
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

  void _showReceipt({
    required BuildContext context,
    required List<CartItem> items,
    required String totalCost,
    required String totalDiscount,
  }) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Checkout Finished!'),
        content: Scrollbar(
          thumbVisibility: true,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ReceiptItem(
                  leftText: 'Total Items',
                  totalCost: totalCost,
                ),
                ReceiptItem(
                  leftText: 'Total Discount',
                  totalCost: totalDiscount,
                ),
                ReceiptItem(
                  leftText: 'Total Items',
                  totalCost: items.length.toString(),
                ),
                if (items.isNotEmpty)
                  const Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: Text(
                      'Items Purchased:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ...items.map(
                  (item) => Row(
                    children: [
                      Text(
                        '${item.stockItem.sku}:',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Text(
                        '${item.stockItem.formattedPrice} ${item.isPromoApplied ? ' - promo applied' : ''}',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'OK'),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
