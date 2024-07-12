part of 'checkout_cubit.dart';

@immutable
sealed class CheckoutState extends Equatable {
  const CheckoutState({
    required this.items,
    required this.checkedItems,
    required this.totalCost,
    required this.totalDiscount,
  });
  final List<StockItem> items;
  final List<StockItem> checkedItems;
  final double totalCost;
  final double totalDiscount;

  @override
  List<Object?> get props => [items, checkedItems, totalCost];
}

final class CheckoutInitial extends CheckoutState {
  const CheckoutInitial({required super.items})
      : super(
          checkedItems: const [],
          totalCost: 0,
          totalDiscount: 0,
        );
}

final class CheckoutProcessed extends CheckoutState {
  const CheckoutProcessed({
    required super.items,
    required super.checkedItems,
    required super.totalCost,
    required super.totalDiscount,
  });
}
