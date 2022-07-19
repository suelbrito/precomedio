import 'package:precomedio/components/main_drawer.dart';
import 'package:precomedio/modules/compra/view/compra_form.dart';
import 'package:flutter/material.dart';

class CompraAddScreen extends StatelessWidget {
  const CompraAddScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adicionar compra'),
      ),
      body: const CompraForm(),
      drawer: const MainDrawer(),
    );
  }
}
