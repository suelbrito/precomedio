import 'package:flutter/material.dart';
import 'package:precomedio/components/compra_listview.dart';

class CompraList extends StatefulWidget {
  const CompraList({Key? key}) : super(key: key);

  @override
  State<CompraList> createState() => _CompraListState();
}

class _CompraListState extends State<CompraList> {
  @override
  Widget build(BuildContext context) {
    return const CompraListView();
  }
}
