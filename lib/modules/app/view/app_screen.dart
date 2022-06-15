import 'package:flutter/material.dart';
import 'package:precomedio/modules/app/view/app_list.dart';

class ListaScreen extends StatefulWidget {
  const ListaScreen({Key? key}) : super(key: key);

  @override
  State<ListaScreen> createState() => _ListaScreenState();
}

class _ListaScreenState extends State<ListaScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: AppList(),
    );
  }
}
