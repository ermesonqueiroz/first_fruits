import 'package:first_fruits/domain/income.dart';
import 'package:first_fruits/services/database_service.dart';
import 'package:first_fruits/util/currency_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RegisterIncomePage extends StatefulWidget {
  const RegisterIncomePage({super.key});

  @override
  State<RegisterIncomePage> createState() => _RegisterIncomePageState();
}

class _RegisterIncomePageState extends State<RegisterIncomePage> {
  final DatabaseService _databaseService = DatabaseService();

  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _valueController = TextEditingController();

  double parseCurrency(String text) {
    String cleanedText = text.replaceAll('R\$', '');
    cleanedText = cleanedText.replaceAll('.', '');
    cleanedText = cleanedText.replaceAll(',', '.');
    return double.parse(cleanedText);
  }

  Future<void> _addIncome() async {
    _databaseService.addIncome(
      Income(
        value: parseCurrency(_valueController.text),
        description: _descriptionController.text,
        createdAt: DateTime.now(),
      ),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(title: Text('Adicionar entrada')),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsetsGeometry.symmetric(horizontal: 20, vertical: 25),
            child: Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    controller: _descriptionController,
                    decoration: InputDecoration(
                      label: Text('Descrição'),
                      prefixIcon: Icon(Icons.short_text),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: _valueController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      label: Text('Valor'),
                      prefixIcon: Icon(Icons.monetization_on_outlined),
                      border: OutlineInputBorder(),
                    ),
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      CurrencyInputFormatter(),
                    ],
                  ),
                  SizedBox(height: 14),
                  TextButton(
                    onPressed: _addIncome,
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.black87,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    child: const Text('Adicionar'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
