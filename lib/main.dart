import 'package:flutter/material.dart';
import 'package:validacion_formulario/pages/form_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: FormScreen(),
      ),
    );
  }
}
