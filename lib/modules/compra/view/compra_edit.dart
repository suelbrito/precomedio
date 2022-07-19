import 'package:precomedio/modules/compra/view/compra_form.dart';
import 'package:precomedio/modules/compra/model/compra_model.dart';
import 'package:flutter/material.dart';

class CompraEditScreen extends StatelessWidget {
  const CompraEditScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final compra = ModalRoute.of(context)!.settings.arguments as Compra;

    return Scaffold(
      appBar: AppBar(
        title: Text('Editando compra de ${compra.data}'),
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back,
          ),
        ),
      ),
      body: CompraForm(compraModel: compra),
    );
  }
}
