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
                if (state is CheckoutInitial) {
                  return Center(
                    child: Text('${state.items.length}'),
                  );
                }
                return const SizedBox.shrink();
              },
            );
          },
        ),
      ),
    );
  }
}
