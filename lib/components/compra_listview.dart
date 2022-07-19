import 'package:precomedio/components/compra_item.dart';
import 'package:precomedio/modules/compra/model/compra_model.dart';
import 'package:precomedio/modules/compra/controller/compra_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CompraListView extends StatelessWidget {
  const CompraListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CompraController>(context);

    final List<Compra> loadedCompras = provider.loadItems();

    return Scaffold(
        body: SafeArea(
            child: loadedCompras.isEmpty
                ? Center(
                    child: Text('Nada a exibir',
                        style: Theme.of(context).textTheme.headline1))
                : ListView.builder(
                    itemCount: loadedCompras.length,
                    itemBuilder: (context, index) =>
                        CompraItem(compra: loadedCompras[index]),
                  )));
  }
}
