import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class QRScannerScreen extends StatefulWidget {
  @override
  _QRScannerScreenState createState() => _QRScannerScreenState();
}

class _QRScannerScreenState extends State<QRScannerScreen> {
  bool scanned = false;

  void handleBarcode(String code) async {
    if (!scanned) {
      setState(() {
        scanned = true;
      });

      final response = await http.get(Uri.parse('https://67f7d1812466325443eadd17.mockapi.io/carros/$code'));

      if (response.statusCode == 200) {
        final car = jsonDecode(response.body);
        Navigator.pushNamed(context, '/detail', arguments: car);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Carro no encontrado')),
        );
        setState(() {
          scanned = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Escanear QR')),
      body: MobileScanner(
        onDetect: (capture) {
          final barcodes = capture.barcodes;
          if (barcodes.isNotEmpty && barcodes.first.rawValue != null) {
            handleBarcode(barcodes.first.rawValue!);
          }
        },
      ),
    );
  }
}
