import 'package:checkout_kata/app/routes/routes.dart';
import 'package:checkout_kata/checkout/view/checkout_page.dart';
import 'package:checkout_kata/data/shop_items_api.dart';
import 'package:checkout_kata/data/shop_items_repository.dart';
import 'package:checkout_kata/models/stock_item.dart';
import 'package:checkout_kata/pricing/view/pricing_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CheckoutKata extends StatelessWidget {
  const CheckoutKata({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Checkout Kata',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Provider<ShopItemsApi>(
        create: (context) => ShopItemsRepository(),
        child: const PricingPage(title: 'Pricing'),
      ),
      routes: _routes,
    );
  }

  Map<String, Widget Function(BuildContext)> get _routes => {
        AppRoutes.checkoutPage: (context) => CheckOutPage(
              items: ModalRoute.of(context)!.settings.arguments!
                  as List<StockItem>,
            ),
      };
}
