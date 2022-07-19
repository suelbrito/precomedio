import 'package:precomedio/modules/compra/view/compra_ativo_form.dart';
import 'package:precomedio/modules/compra/model/compra_model.dart';
import 'package:flutter/material.dart';

class CompraAtivoAddScreen extends StatelessWidget {
  const CompraAtivoAddScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final compra = ModalRoute.of(context)!.settings.arguments as Compra;

    return Scaffold(
      appBar: AppBar(
        title: Text('Ativos da operação em ${compra.data}'),
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back,
          ),
        ),
      ),
      body: CompraAtivoForm(compraModel: compra),
    );
  }
}
