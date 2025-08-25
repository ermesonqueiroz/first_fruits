import 'package:first_fruits/domain/income.dart';
import 'package:first_fruits/domain/pix.dart';
import 'package:first_fruits/pages/pix_page.dart';
import 'package:first_fruits/util/card_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IncomeDetailsPage extends StatefulWidget {
  final Income income;

  const IncomeDetailsPage(this.income, {super.key});

  @override
  State<IncomeDetailsPage> createState() => _IncomeDetailsPageState();
}

class _IncomeDetailsPageState extends State<IncomeDetailsPage> {
  Future<Map<String, String?>> _getPreferences() async {
    final preferences = await SharedPreferences.getInstance();
    return {
      'first_fruits_pix': preferences.getString('first_fruits_pix'),
      'tithe_pix': preferences.getString('tithe_pix'),
    };
  }

  @override
  Widget build(BuildContext context) {
    final formatter = NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$');

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Icon(Icons.arrow_back_ios),
              ),
              SizedBox(height: 10),
              Text(
                widget.income.description,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Text(
                formatter.format(widget.income.value),
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: 20),
              FutureBuilder<Map<String, String?>>(
                future: _getPreferences(),
                builder: (BuildContext context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }

                  final firstFruitsPix = snapshot.data!['first_fruits_pix'];
                  final tithePix = snapshot.data!['tithe_pix'];

                  return Column(
                    children: [
                      if (firstFruitsPix != null)
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute<void>(
                                builder: (context) => PixPage(
                                  title: 'Primícia',
                                  value: widget.income.value * 0.03,
                                  pix: Pix(
                                    key: firstFruitsPix,
                                    amount: widget.income.value * 0.03,
                                    merchantCity: 'FORTALEZA',
                                    merchantName: 'Ermeson S Queiroz',
                                    referenceLabel: '***',
                                  ),
                                ),
                              ),
                            );
                          },
                          child: CardWidget(
                            title: 'Primícia',
                            description: formatter.format(
                              widget.income.value * 0.03,
                            ),
                            bottom: '3%',
                          ),
                        ),
                      SizedBox(height: 10),
                      if (tithePix != null)
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute<void>(
                                builder: (context) => PixPage(
                                  title: 'Dízimo',
                                  value: (widget.income.value * 0.97) * 0.1,
                                  pix: Pix(
                                    key: tithePix,
                                    amount: (widget.income.value * 0.97) * 0.1,
                                    merchantCity: 'FORTALEZA',
                                    merchantName: 'Ermeson S Queiroz',
                                    referenceLabel: '***',
                                  ),
                                ),
                              ),
                            );
                          },
                          child: CardWidget(
                            title: 'Dízimo',
                            description: formatter.format(
                              (widget.income.value * 0.97) * 0.1,
                            ),
                            bottom: '10%',
                          ),
                        ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
