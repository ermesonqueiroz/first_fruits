import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class IncomeDetailsCard extends StatelessWidget {
  final String title;
  final double value;
  final String? details;

  const IncomeDetailsCard({
    super.key,
    required this.title,
    required this.value,
    this.details,
  });

  @override
  Widget build(BuildContext context) {
    final currencyFormatter = NumberFormat.currency(
      locale: 'pt_BR',
      symbol: 'R\$',
    );

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          width: 1,
          style: BorderStyle.solid,
          color: Colors.black26,
        ),
        borderRadius: BorderRadius.circular(4),
      ),
      width: double.infinity,
      height: 80,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: TextStyle(color: Colors.black87)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  currencyFormatter.format(value),
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    height: 1,
                  ),
                ),
                if (details != null) Text(details!),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
