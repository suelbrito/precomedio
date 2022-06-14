import 'package:flutter/material.dart';
import 'package:precomedio/components/ticket_listview.dart';

class TicketList extends StatefulWidget {
  const TicketList({Key? key}) : super(key: key);

  @override
  State<TicketList> createState() => _TicketListState();
}

class _TicketListState extends State<TicketList> {
  @override
  Widget build(BuildContext context) {
    return const TicketListView();
  }
}
