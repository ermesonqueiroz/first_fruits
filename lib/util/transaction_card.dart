import 'package:first_fruits/domain/income.dart';
import 'package:first_fruits/pages/income_details_page.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionCard extends StatelessWidget {
  final Income income;

  const TransactionCard(this.income, {super.key});

  @override
  Widget build(BuildContext context) {
    final currencyFormatter = NumberFormat.currency(
      locale: 'pt_BR',
      symbol: 'R\$',
    );

    final DateFormat dateFormatter = DateFormat('dd/MM/yyyy', 'pt_BR');

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute<void>(
            builder: (context) => IncomeDetailsPage(income),
          ),
        );
      },
      child: Container(
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
              Text(income.description, style: TextStyle(color: Colors.black87)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    currencyFormatter.format(income.value),
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      height: 1,
                    ),
                  ),
                  Text(dateFormatter.format(DateTime.now())),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
