import 'package:intl/intl.dart';
import 'package:precomedio/modules/compra/model/compra_model.dart';
import 'package:precomedio/utils/app_routes.dart';
import 'package:flutter/material.dart';

class CompraItem extends StatelessWidget {
  final Compra compra;
  const CompraItem({Key? key, required this.compra}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final DateFormat formatter = DateFormat('dd/MM/yyyy');

    return Card(
      elevation: 6,
      margin: const EdgeInsets.all(10),
      child: ListTile(
        title: Text("Data da operação: " + formatter.format(compra.data)),
        subtitle: Text("Valor da nota: R\$ " + compra.valor.toString()),
        trailing: IconButton(
          icon: const Icon(Icons.edit),
          onPressed: () {
            Navigator.of(context).pushNamed(
              AppRoutes.COMPRA_EDIT,
              arguments: compra,
            );
          },
        ),
      ),
    );
  }
}
