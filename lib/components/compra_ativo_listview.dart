import 'package:intl/intl.dart';
import 'package:precomedio/components/compra_ativo_item.dart';
import 'package:precomedio/modules/compra/model/compra_ativo_model.dart';
import 'package:precomedio/modules/compra/model/compra_model.dart';
import 'package:precomedio/modules/compra/controller/compra_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CompraAtivoListView extends StatelessWidget {
  final Compra compraModel;
  const CompraAtivoListView({Key? key, required this.compraModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CompraController>(context);

    final List<CompraAtivo> loadedAtivosCompra =
        provider.loadAtivosCompraItems(compraModel.id);

    var formatter = DateFormat('dd/MM/yyyy');
    String formattedDate = formatter.format(compraModel.data);

    return Scaffold(
        appBar: AppBar(
          title: Text('Ativos em $formattedDate'),
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back,
            ),
          ),
        ),
        body: SafeArea(
            child: loadedAtivosCompra.isEmpty
                ? Center(
                    child: Text('Nada a exibir',
                        style: Theme.of(context).textTheme.headline1))
                : ListView.builder(
                    itemCount: loadedAtivosCompra.length,
                    itemBuilder: (context, index) =>
                        CompraAtivoItem(compraAtivo: loadedAtivosCompra[index]),
                  )));
  }
}
