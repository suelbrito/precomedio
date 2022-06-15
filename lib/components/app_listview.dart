import 'package:precomedio/components/app_item.dart';
import 'package:precomedio/modules/ticket/model/ticket_model.dart';
import 'package:precomedio/modules/ticket/controller/ticket_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppListView extends StatelessWidget {
  const AppListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TicketController>(context);

    final List<Ticket> loadedTickets = provider.loadItems();

    return Scaffold(
        body: SafeArea(
            child: ListView.builder(
      itemCount: loadedTickets.length,
      itemBuilder: (context, index) => AppItem(ticket: loadedTickets[index]),
    )));
  }
}
