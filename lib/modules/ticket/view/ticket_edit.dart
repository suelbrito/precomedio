import 'package:precomedio/components/main_drawer.dart';
import 'package:precomedio/modules/ticket/view/ticket_form.dart';
import 'package:precomedio/modules/ticket/model/ticket_model.dart';
import 'package:flutter/material.dart';

class TicketEditScreen extends StatelessWidget {
  const TicketEditScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ticket = ModalRoute.of(context)!.settings.arguments as Ticket;

    return Scaffold(
      appBar: AppBar(
        title: Text('Editando ${ticket.empresa}'),
      ),
      body: TicketForm(ticketModel: ticket),
      drawer: const MainDrawer(),
    );
  }
}
