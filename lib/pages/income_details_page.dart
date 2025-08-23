import 'package:first_fruits/domain/income.dart';
import 'package:first_fruits/pages/pix_page.dart';
import 'package:first_fruits/util/income_details_card.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class IncomeDetailsPage extends StatelessWidget {
  final Income income;

  const IncomeDetailsPage(this.income, {super.key});

  @override
  Widget build(BuildContext context) {
    final formatter = NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$');

    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(title: Text('Detalhes')),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(left: 40, right: 40, top: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                income.description,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Text(
                formatter.format(income.value),
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                      builder: (context) => PixPage(
                        title: 'Primícia',
                        value: income.value * 0.03,
                      ),
                    ),
                  );
                },
                child: IncomeDetailsCard(
                  title: 'Primícia',
                  value: income.value * 0.03,
                  details: '3%',
                ),
              ),
              SizedBox(height: 10),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                      builder: (context) => PixPage(
                        title: 'Dízimo',
                        value: (income.value * 0.97) * 0.1,
                      ),
                    ),
                  );
                },
                child: IncomeDetailsCard(
                  title: 'Dízimo',
                  value: (income.value * 0.97) * 0.1,
                  details: '10%',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
