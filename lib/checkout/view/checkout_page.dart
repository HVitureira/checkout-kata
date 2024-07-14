import 'package:checkout_kata/app/widgets/shop_list.dart';
import 'package:checkout_kata/checkout/cubit/checkout_cubit.dart';
import 'package:checkout_kata/models/stock_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CheckOutPage extends StatelessWidget {
  const CheckOutPage({required this.items, super.key});

  final List<StockItem> items;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Checkout'),
      ),
      body: BlocProvider(
        create: (context) => CheckoutCubit(
          startingItems: items,
        ),
        child: Builder(
          builder: (context) {
            return BlocBuilder<CheckoutCubit, CheckoutState>(
              builder: (context, state) {
                return Column(
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
                );
              },
            );
          },
        ),
      ),
      bottomSheet: BottomAppBar(
        child: Padding(
          padding: const EdgeInsetsDirectional.all(10),
          child: ElevatedButton(
            onPressed: () {},
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
  }
}
