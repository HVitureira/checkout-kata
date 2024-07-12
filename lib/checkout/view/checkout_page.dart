import 'package:checkout_kata/models/stock_item.dart';
import 'package:flutter/material.dart';

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
      body: Center(
        child: Text('${items.length}'),
      ),
    );
  }
}
