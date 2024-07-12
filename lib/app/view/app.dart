import 'package:checkout_kata/pricing/pricing_page.dart';
import 'package:flutter/material.dart';

class CheckoutKata extends StatelessWidget {
  const CheckoutKata({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Checkout Kata',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const PricingPage(title: 'Pricing'),
    );
  }
}
