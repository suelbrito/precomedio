import 'package:flutter/material.dart';
import 'package:precomedio/modules/compra/view/compra_list.dart';
import 'package:precomedio/utils/app_routes.dart';

class CompraScreen extends StatelessWidget {
  const CompraScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const CompraList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(AppRoutes.COMPRA_ADD);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
