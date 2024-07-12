import 'package:checkout_kata/models/stock_item.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'checkout_state.dart';

class CheckoutCubit extends Cubit<CheckoutState> {
  CheckoutCubit({required List<StockItem> startingItems})
      : super(CheckoutInitial(items: startingItems));
}
