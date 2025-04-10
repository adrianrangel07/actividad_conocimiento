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
  Map? carData;

  void handleBarcode(String code) async {
    if (!scanned) {
      setState(() {
        scanned = true;
      });

      final response = await http.get(Uri.parse(
          'https://67f7d1812466325443eadd17.mockapi.io/carros/$code'));

      if (response.statusCode == 200) {
        setState(() {
          carData = jsonDecode(response.body);
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Carro no encontrado')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Escanear QR')),
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: MobileScanner(
              onDetect: (capture) {
                final barcodes = capture.barcodes;
                if (barcodes.isNotEmpty && barcodes.first.rawValue != null) {
                  handleBarcode(barcodes.first.rawValue!);
                }
              },
            ),
          ),
          Expanded(
            flex: 1,
            child: carData != null
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Placa: ${carData!['placa']}'),
                      Text('Conductor: ${carData!['conductor']}'),
                      Text('ID: ${carData!['id']}'),
                    ],
                  )
                : Center(child: Text('Escanea un código QR')),
          ),
        ],
      ),
      floatingActionButton: scanned
          ? FloatingActionButton(
              onPressed: () {
                setState(() {
                  scanned = false;
                  carData = null;
                });
              },
              child: Icon(Icons.refresh),
            )
          : null,
    );
  }
}

