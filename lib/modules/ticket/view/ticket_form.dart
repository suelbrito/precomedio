import 'package:flutter/material.dart';
import 'package:precomedio/utils/app_routes.dart';

class TicketScreen extends StatefulWidget {
  const TicketScreen({Key? key}) : super(key: key);

  @override
  State<TicketScreen> createState() => _TicketScreenState();
}

class _TicketScreenState extends State<TicketScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
        body: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 30),
              child: Form(key: _formKey, child: Text('Oi'))),
        ));
  }
}
