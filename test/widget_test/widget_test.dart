import 'package:bloc_test/bloc_test.dart';
import 'package:checkout_kata/models/stock_item.dart';
import 'package:checkout_kata/pricing/cubit/cubit.dart';
import 'package:checkout_kata/pricing/view/item_pricing_rules_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockPricingRulesCubit extends MockCubit<PricingRulesState>
    implements PricingRulesCubit {}

void main() {
  late StockItem item;
  late List<StockItem> availableItems;
  late PricingRulesCubit pricingRulesCubit;
  late Widget testingWidget;

  setUp(() {
    item = const StockItem(sku: 'A', unitPrice: 12);
    availableItems = [];
    pricingRulesCubit = MockPricingRulesCubit();

    when(() => pricingRulesCubit.state).thenReturn(
      PricingRulesState(
        items: availableItems,
      ),
    );

    testingWidget = MaterialApp(
      home: Scaffold(
        body: Builder(
          builder: (context) {
            return ElevatedButton(
              key: const Key('test-button'),
              onPressed: () => ItemPricingSheet.show(
                key: const Key('sheet-key'),
                context: context,
                item: item,
                availableItems: availableItems,
                pricingRulesCubit: pricingRulesCubit,
              ),
              child: const Text('test'),
            );
          },
        ),
      ),
    );
  });

  testWidgets(
      'Tapping a button using the ItemPricingSheet.show() '
      'method, shows the editing sheet', (WidgetTester tester) async {
    await tester.pumpWidget(testingWidget);

    await tester.tap(find.byKey(const Key('test-button')));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('sheet-key')), findsOneWidget);
  });
}
