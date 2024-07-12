part of 'checkout_cubit.dart';

@immutable
sealed class CheckoutState {}

final class CheckoutInitial extends CheckoutState {
  CheckoutInitial({required this.items});

  final List<StockItem> items;
}
