import 'package:flutter/material.dart';
import 'package:precomedio/modules/compra/model/compra_model.dart';
import 'package:precomedio/modules/compra/view/compra_ativo_list.dart';
import 'package:precomedio/utils/app_routes.dart';

class CompraAtivoScreen extends StatelessWidget {
  const CompraAtivoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final compra = ModalRoute.of(context)!.settings.arguments as Compra;

    return Scaffold(
      body: CompraAtivoList(compraModel: compra),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .pushNamed(AppRoutes.COMPRA_ATIVO_ADD, arguments: compra);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
