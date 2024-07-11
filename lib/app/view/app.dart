import 'package:checkout_kata/counter/view/counter_page.dart';
import 'package:flutter/material.dart';

class CheckoutKata extends StatelessWidget {
  const CheckoutKata({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const CounterPage(title: 'Flutter Demo Home Page'),
    );
  }
}
