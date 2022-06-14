import 'package:flutter/material.dart';
import 'package:precomedio/modules/ticket/view/ticket_list.dart';
import 'package:precomedio/utils/app_routes.dart';

class TicketScreen extends StatefulWidget {
  const TicketScreen({Key? key}) : super(key: key);

  @override
  State<TicketScreen> createState() => _TicketScreenState();
}

class _TicketScreenState extends State<TicketScreen> {
  _onClick() {
    print('clicou!');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tickets'),
        leading: InkWell(
          onTap: () {
            Navigator.of(context).pushReplacementNamed(AppRoutes.HOME);
          },
          child: const Icon(
            Icons.arrow_back,
          ),
        ),
      ),
      body: const TicketList(),
      floatingActionButton: FloatingActionButton(
        onPressed: _onClick,
        child: const Icon(Icons.add),
      ),
    );
  }
}
