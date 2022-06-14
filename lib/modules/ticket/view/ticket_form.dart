import 'package:precomedio/modules/ticket/controller/ticket_controller.dart';
import 'package:precomedio/modules/ticket/model/ticket_model.dart';
import 'package:precomedio/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class TicketForm extends StatelessWidget {
  final Ticket? ticketModel;
  const TicketForm({Key? key, this.ticketModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ticketProvider = context.watch<TicketController>();

    showAlertDialog(BuildContext context, String id) {
      // set up the buttons
      Widget cancelButton = TextButton(
        child: const Text("Cancelar"),
        onPressed: () {
          Navigator.of(context).pop();
        },
      );
      Widget continueButton = TextButton(
        child: const Text("OK"),
        onPressed: () {
          ticketProvider.removeTicketById(id);
          Navigator.of(context).pushNamed(
            AppRoutes.TICKET_LIST,
          );
        },
      );
      // set up the AlertDialog
      AlertDialog alert = AlertDialog(
        title: const Text("Confirmação"),
        content: const Text("Tem certeza que deseja excluir este ticket?"),
        actions: [
          cancelButton,
          continueButton,
        ],
      );
      // show the dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
    }

    var maskCNPJFormatter = MaskTextInputFormatter(
        mask: '##.###.###/####-##',
        filter: {"#": RegExp(r'[0-9]')},
        type: MaskAutoCompletionType.lazy);

    String _id = "";
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    final _codigoController = TextEditingController();
    final _empresaController = TextEditingController();
    final _cnpjController = TextEditingController();
    final isEdit = (ticketModel != null);

    if (isEdit) {
      _id = ticketModel!.id;
      _codigoController.text = ticketModel!.codigo;
      _empresaController.text = ticketModel!.empresa;
      _cnpjController.text = ticketModel!.cnpj;
    }

    _submitForm(id, codigo, empresa, cnpj) {
      bool isEdit = _id.isNotEmpty;

      Ticket ticket =
          Ticket(id: id, codigo: codigo, empresa: empresa, cnpj: cnpj);

      if (isEdit) {
        ticketProvider.updateTicket(ticket);
      } else {
        ticketProvider.addTicket(ticket);
      }

      Navigator.of(context).pushNamed(
        AppRoutes.TICKET_LIST,
        arguments: ticket,
      );
    }

    return SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Row(children: [
                    Expanded(
                        child: TextFormField(
                      controller: _codigoController,
                      decoration: const InputDecoration(
                        hintText: 'Código',
                      ),
                    )),
                  ]),
                  Row(children: [
                    Expanded(
                        child: TextFormField(
                      controller: _empresaController,
                      decoration: const InputDecoration(
                        hintText: 'Empresa',
                      ),
                    )),
                  ]),
                  Row(children: [
                    Expanded(
                        child: TextFormField(
                            controller: _cnpjController,
                            decoration: const InputDecoration(
                              hintText: 'CNPJ',
                            ),
                            inputFormatters: [maskCNPJFormatter])),
                  ]),
                  const SizedBox(height: 20),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    ElevatedButton(
                        onPressed: () => _submitForm(
                              _id,
                              _codigoController.text,
                              _empresaController.text,
                              _cnpjController.text,
                            ),
                        child: const Text('Salvar')),
                    Visibility(
                        visible: isEdit, child: const SizedBox(width: 10)),
                    Visibility(
                        visible: isEdit,
                        child: ElevatedButton(
                            style:
                                ElevatedButton.styleFrom(primary: Colors.red),
                            onPressed: () => showAlertDialog(context, _id),
                            child: const Text('Excluir')))
                  ]),
                ],
              ),
            )));
  }
}
