import 'package:flutter/material.dart';

class BareActsPage extends StatefulWidget {
  static const routeName='/bare-acts';
  const BareActsPage({super.key});

  @override
  State<BareActsPage> createState() => _BareActsPageState();
}

class _BareActsPageState extends State<BareActsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(height: double.infinity,),
    );
  }
}