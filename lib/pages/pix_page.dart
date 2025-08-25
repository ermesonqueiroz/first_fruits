import 'package:first_fruits/domain/pix.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:flutter/services.dart';

class PixPage extends StatefulWidget {
  final String title;
  final double value;
  final Pix pix;

  const PixPage({
    super.key,
    required this.title,
    required this.value,
    required this.pix,
  });

  @override
  State<PixPage> createState() => _PixPageState();
}

class _PixPageState extends State<PixPage> {
  @override
  Widget build(BuildContext context) {
    final formatter = NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$');

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Align(
                alignment: AlignmentGeometry.centerLeft,
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Icon(Icons.arrow_back_ios),
                ),
              ),
              SizedBox(height: 10),
              Text(
                widget.title,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Text(
                formatter.format(widget.value),
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: 32),
              QrImageView(
                data: widget.pix.getPayload(),
                foregroundColor: Color.fromARGB(255, 34, 34, 34),
              ),
              SizedBox(height: 10),
              TextButton(
                onPressed: () async {
                  await Clipboard.setData(
                    ClipboardData(text: widget.pix.getPayload()),
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
                  backgroundColor: Color.fromARGB(255, 34, 34, 34),
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
