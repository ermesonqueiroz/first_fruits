import 'package:first_fruits/pages/home_page.dart';
import 'package:first_fruits/pages/register_income_page.dart';
import 'package:first_fruits/pages/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('pt_BR', null);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Primícias',
      theme: ThemeData(
        fontFamily: 'Poppins',
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
      ),
      initialRoute: '/',
      routes: {
        '/': (BuildContext context) => HomePage(),
        '/settings': (BuildContext context) => SettingsPage(),
        '/register-income': (BuildContext context) => RegisterIncomePage(),
      },
    );
  }
}
