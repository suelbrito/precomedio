import 'package:flutter/material.dart';
import 'package:precomedio/utils/app_routes.dart';

class CompraScreen extends StatelessWidget {
  const CompraScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Center(
            child: SingleChildScrollView(
              child: Text('Oi'),
            ),
          )),
    );
  }
}
