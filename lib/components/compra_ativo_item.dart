import 'package:precomedio/modules/compra/model/compra_ativo_model.dart';
import 'package:precomedio/utils/app_routes.dart';
import 'package:flutter/material.dart';

class CompraAtivoItem extends StatelessWidget {
  final CompraAtivo compraAtivo;
  const CompraAtivoItem({Key? key, required this.compraAtivo})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: const EdgeInsets.all(10),
      child: ListTile(
        title: Text(compraAtivo.ticket),
        subtitle: Column(children: [
          Align(
              alignment: Alignment.topLeft,
              child: Text("Quantidade: ${compraAtivo.quantidade}")),
          Align(
              alignment: Alignment.topLeft,
              child: Text(
                  "Total da operação: R\$ ${compraAtivo.valor.toString()}",
                  textAlign: TextAlign.left))
        ]),
        trailing: IconButton(
          icon: const Icon(Icons.delete),
          onPressed: () {
            Navigator.of(context).pushNamed(
              AppRoutes.COMPRA_ATIVO_ADD,
              arguments: compraAtivo,
            );
          },
        ),
      ),
    );
  }
}
