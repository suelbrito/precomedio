import 'package:precomedio/modules/ticket/model/ticket_model.dart';
import 'package:flutter/material.dart';

class AppItem extends StatelessWidget {
  final Ticket ticket;
  const AppItem({Key? key, required this.ticket}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: const EdgeInsets.all(10),
      child: ListTile(
        title: Text(ticket.empresa),
        subtitle: const Text("Preço médio: 0.00   |   Qtde: 0"),
      ),
    );
  }
}
