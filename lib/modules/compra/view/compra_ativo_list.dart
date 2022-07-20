import 'package:precomedio/modules/compra/model/compra_model.dart';
import 'package:flutter/material.dart';
import 'package:precomedio/components/compra_ativo_listview.dart';

class CompraAtivoList extends StatefulWidget {
  final Compra compraModel;
  const CompraAtivoList({Key? key, required this.compraModel})
      : super(key: key);

  @override
  State<CompraAtivoList> createState() => _CompraAtivoListState();
}

class _CompraAtivoListState extends State<CompraAtivoList> {
  @override
  Widget build(BuildContext context) {
    return CompraAtivoListView(compraModel: widget.compraModel);
  }
}
