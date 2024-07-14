import 'package:checkout_kata/models/stock_item.dart';
import 'package:flutter/material.dart';

class ShopList extends StatelessWidget {
  const ShopList({
    required this.items,
    required this.trailingIcon,
    required this.leadingIcon,
    required this.onTrailingPressed,
    super.key,
  });

  final List<StockItem> items;
  final void Function(StockItem) onTrailingPressed;
  final IconData trailingIcon;
  final IconData leadingIcon;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        final currentItem = items.elementAt(index);
        final itemTitle = currentItem.sku;
        final itemPrice = currentItem.formattedPrice;
        final itemPromo = currentItem.promo;

        return Column(
          children: [
            ListTile(
              leading: Icon(leadingIcon),
              title: Text(itemTitle),
              subtitle: Text(
                'Price: $itemPrice '
                'Promo: ${itemPromo ?? 'No promo'}',
              ),
              trailing: IconButton(
                icon: Icon(
                  trailingIcon,
                ),
                onPressed: () => onTrailingPressed(currentItem),
              ),
            ),
            const Divider(height: 0),
          ],
        );
      },
    );
  }
}
