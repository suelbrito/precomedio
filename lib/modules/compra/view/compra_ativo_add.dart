import 'package:intl/intl.dart';
import 'package:precomedio/components/main_drawer.dart';
import 'package:precomedio/modules/compra/model/compra_model.dart';
import 'package:precomedio/modules/compra/view/compra_ativo_form.dart';
import 'package:flutter/material.dart';

class CompraAtivoAddScreen extends StatelessWidget {
  const CompraAtivoAddScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final compra = ModalRoute.of(context)!.settings.arguments as Compra;

    var formatter = DateFormat('dd/MM/yyyy');
    String formattedDate = formatter.format(compra.data);

    return Scaffold(
      appBar: AppBar(
        title: Text('Adicionar ativo em $formattedDate'),
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back,
          ),
        ),
      ),
      body: CompraAtivoForm(compraId: compra.id),
      drawer: const MainDrawer(),
    );
  }
}
