import 'package:first_fruits/domain/pix.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:flutter/services.dart';

class PixPage extends StatefulWidget {
  final String title;
  final double value;

  const PixPage({super.key, required this.title, required this.value});

  @override
  State<PixPage> createState() => _PixPageState();
}

class _PixPageState extends State<PixPage> {
  late Pix pix;

  @override
  void initState() {
    super.initState();
    pix = Pix(
      key: '09606704327',
      amount: widget.value,
      merchantCity: 'FORTALEZA',
      merchantName: 'Ermeson S Queiroz',
      referenceLabel: '***',
    );
  }

  @override
  Widget build(BuildContext context) {
    final formatter = NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$');

    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(title: Text('QR Code')),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(left: 40, right: 40, top: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                widget.title,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Text(
                formatter.format(widget.value),
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: 32),
              QrImageView(data: pix.getPayload()),
              SizedBox(height: 10),
              TextButton(
                onPressed: () async {
                  await Clipboard.setData(
                    ClipboardData(text: pix.getPayload()),
                  );

                  if (!mounted) return;
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('QR Code copiado com sucesso!'),
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
                  padding: EdgeInsets.symmetric(vertical: 12),
                ),
                child: const Text(
                  'Copiar Chave PIX',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
