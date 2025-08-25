import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final TextEditingController _firstFruitsPIX = TextEditingController();
  final TextEditingController _tithePIX = TextEditingController();

  Future<Map<String, String?>> _getPreferences() async {
    final preferences = await SharedPreferences.getInstance();
    return {
      'first_fruits_pix': preferences.getString('first_fruits_pix'),
      'tithe_pix': preferences.getString('tithe_pix'),
    };
  }

  Future<void> _savePreferences() async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setString('first_fruits_pix', _firstFruitsPIX.text);
    await preferences.setString('tithe_pix', _tithePIX.text);
  }

  @override
  void dispose() {
    _firstFruitsPIX.dispose();
    _tithePIX.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Icon(Icons.arrow_back_ios),
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Configurações',
                  style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 24),
                FutureBuilder<Map<String, String?>>(
                  future: _getPreferences(),
                  builder:
                      (
                        BuildContext context,
                        AsyncSnapshot<Map<String, String?>> snapshot,
                      ) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        }

                        if (snapshot.hasData) {
                          _firstFruitsPIX.text =
                              snapshot.data!['first_fruits_pix'] ?? '';
                          _tithePIX.text = snapshot.data!['tithe_pix'] ?? '';
                        }

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Primícia',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(height: 8),
                            TextFormField(
                              controller: _firstFruitsPIX,
                              decoration: InputDecoration(
                                label: Text('Chave PIX'),
                                prefixIcon: Icon(Icons.pix),
                                border: OutlineInputBorder(),
                              ),
                            ),
                            SizedBox(height: 20),
                            Text(
                              'Dízimo',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(height: 8),
                            TextFormField(
                              controller: _tithePIX,
                              decoration: InputDecoration(
                                label: Text('Chave PIX'),
                                prefixIcon: Icon(Icons.pix),
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ],
                        );
                      },
                ),
                SizedBox(height: 16),
                TextButton(
                  onPressed: () {
                    _savePreferences();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Configurações salvas!'),
                        backgroundColor: Colors.green,
                        duration: Duration(seconds: 2),
                      ),
                    );
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.black87,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  child: const Text('Salvar'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
