import 'package:actividad_conocimiento/Screen/CarListScreen.dart';
import 'package:actividad_conocimiento/Screen/LoginScreen.dart';
import 'package:actividad_conocimiento/Screen/MenuScreen.dart';
import 'package:actividad_conocimiento/Screen/QRScannerScreen.dart';
import 'package:flutter/material.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Carros Eléctricos',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => LoginScreen(),
        '/carList': (context) => CarListScreen(),
        '/menu': (context) => MenuScreen(),
        '/scanner': (context) => QRScannerScreen(),
      },
    );
  }
}
