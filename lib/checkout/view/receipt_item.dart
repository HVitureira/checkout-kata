import 'package:flutter/material.dart';

class ReceiptItem extends StatelessWidget {
  const ReceiptItem({
    required this.leftText,
    required this.totalCost,
    super.key,
  });

  final String leftText;
  final String totalCost;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          '$leftText:',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          width: 20,
        ),
        Text(
          totalCost,
        ),
      ],
    );
  }
}
