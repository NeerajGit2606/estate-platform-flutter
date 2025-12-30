import 'package:flutter/material.dart';
import '../features/auth/role_selection_screen.dart';
import '../app/auth_gate.dart';

class RealEstateApp extends StatelessWidget {
  const RealEstateApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EstateBridge',
      debugShowCheckedModeBanner: false,
      home: const AuthGate(),
    );
  }
}
