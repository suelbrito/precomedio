import 'package:precomedio/modules/ticket/model/ticket_model.dart';
import 'package:precomedio/modules/ticket/controller/ticket_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppItem extends StatefulWidget {
  final Ticket ticket;
  const AppItem({Key? key, required this.ticket}) : super(key: key);

  @override
  State<AppItem> createState() => _AppItemState();
}

class _AppItemState extends State<AppItem> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TicketController>(context);

    final double precoMedio =
        provider.getPrecoMedioTicket(widget.ticket.codigo);
    final int quantidade = provider.getQuantidadeTicket(widget.ticket.codigo);

    return Card(
      elevation: 6,
      margin: const EdgeInsets.all(10),
      child: ListTile(
        title: Text(widget.ticket.empresa),
        subtitle: Text("Preço médio: R\$ $precoMedio   |   Qtde: $quantidade"),
      ),
    );
  }
}
