import 'package:first_fruits/domain/income.dart';
import 'package:first_fruits/services/database_service.dart';
import 'package:first_fruits/util/transaction_card.dart';
import 'package:flutter/material.dart';

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

    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Padding(
        padding: EdgeInsets.only(left: 40, right: 40, top: topPadding + 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Honrando a Deus em todas as coisas',
              style: TextStyle(fontSize: 16, height: 0.6),
            ),
            Text(
              'PRIMEIROS FRUTOS',
              style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 32),
            Text(
              'Últimas transações',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Divider(color: Colors.grey[400], height: 0),
            FutureBuilder(
              future: _getIncomes(),
              builder: (BuildContext context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                return Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      spacing: 10,
                      children: [
                        SizedBox(height: 2),
                        ...snapshot.data!
                            .map((Income income) => TransactionCard(income))
                            .toList(),
                        SizedBox(height: 30),
                      ],
                    ),
                  ),
                );
              },
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
        backgroundColor: Colors.black87,
        child: const Icon(Icons.add, color: Colors.white, size: 28),
      ),
    );
  }
}
