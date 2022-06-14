import 'package:precomedio/modules/ticket/model/ticket_model.dart';
import 'package:precomedio/utils/app_routes.dart';
import 'package:flutter/material.dart';

class TicketItem extends StatelessWidget {
  final Ticket ticket;
  const TicketItem({Key? key, required this.ticket}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: const EdgeInsets.all(10),
      child: ListTile(
        title: Text(ticket.codigo + " - " + ticket.empresa),
        subtitle: Text("CNPJ: " + ticket.cnpj),
        trailing: IconButton(
          icon: const Icon(Icons.edit),
          onPressed: () {
            Navigator.of(context).pushNamed(
              AppRoutes.TICKET_EDIT,
              arguments: ticket,
            );
          },
        ),
      ),
    );
  }
}
