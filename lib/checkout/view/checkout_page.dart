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
                    Expanded(
                      child: ListView.builder(
                        itemCount: state.items.length,
                        itemBuilder: (context, index) {
                          final currentItem = state.items.elementAt(index);
                          final itemTitle = currentItem.sku;
                          final itemPrice = currentItem.unitPrice;
                          final itemPromo = currentItem.promo;

                          return Column(
                            children: [
                              ListTile(
                                leading: const Icon(Icons.shopping_bag_sharp),
                                title: Text(itemTitle),
                                subtitle: Text(
                                  'Price: $itemPrice, Promo: $itemPromo',
                                ),
                                trailing: IconButton(
                                  icon: const Icon(
                                    Icons.shopping_cart_checkout_rounded,
                                  ),
                                  onPressed: () {},
                                ),
                              ),
                              const Divider(height: 0),
                            ],
                          );
                        },
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
