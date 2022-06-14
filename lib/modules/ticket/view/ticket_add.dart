import 'package:precomedio/components/main_drawer.dart';
import 'package:precomedio/modules/ticket/view/ticket_form.dart';
import 'package:flutter/material.dart';

class TicketAddScreen extends StatelessWidget {
  const TicketAddScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adicionar ticket'),
      ),
      body: const TicketForm(),
      drawer: const MainDrawer(),
    );
  }
}
