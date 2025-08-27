import 'package:first_fruits/domain/income.dart';
import 'package:first_fruits/pages/income_details_page.dart';
import 'package:first_fruits/services/database_service.dart';
import 'package:first_fruits/util/card_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final DatabaseService _databaseService = DatabaseService();

  Future<List<Income>> _getIncomes() {
    return _databaseService.incomes();
  }

  @override
  Widget build(BuildContext context) {
    final double topPadding = MediaQuery.of(context).padding.top;
    final DateFormat dateFormat = DateFormat('dd.MM.yyyy');
    final NumberFormat currencyFormat = NumberFormat.currency(
      locale: 'pt_BR',
      symbol: 'R\$',
    );

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(left: 24, right: 24, top: topPadding + 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Primícias',
                  style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  onPressed: () => Navigator.pushNamed(context, '/settings'),
                  icon: Icon(
                    Icons.settings,
                    color: Color.fromARGB(255, 34, 34, 34),
                  ),
                ),
              ],
            ),
            Text(
              'Honrando a Deus em todas as coisas',
              style: TextStyle(fontSize: 16, height: 0.6),
            ),
            SizedBox(height: 12),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 24),
                    Text('Últimas transações', style: TextStyle(fontSize: 16)),
                    FutureBuilder(
                      future: _getIncomes(),
                      builder: (BuildContext context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        }
                        print(snapshot.data);
                        return Column(
                          spacing: 10,
                          children: [
                            SizedBox(height: 2),
                            ...snapshot.data?.map(
                                  (Income income) => GestureDetector(
                                    onTap: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            IncomeDetailsPage(income),
                                      ),
                                    ),
                                    child: CardWidget(
                                      title: income.description,
                                      description: currencyFormat.format(
                                        income.value,
                                      ),
                                      bottom: income.createdAt != null
                                          ? dateFormat.format(income.createdAt!)
                                          : null,
                                    ),
                                  ),
                                ) ??
                                [],
                            SizedBox(height: 30),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(
            context,
            '/register-income',
          ).then((_) => setState(() {}));
        },
        tooltip: 'Adicionar entrada',
        backgroundColor: Colors.white,
        child: const Icon(
          Icons.add,
          color: Color.fromARGB(255, 34, 34, 34),
          size: 28,
        ),
      ),
    );
  }
}
