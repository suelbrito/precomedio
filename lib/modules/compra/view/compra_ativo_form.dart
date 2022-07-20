import 'package:flutter/services.dart';

import 'package:precomedio/modules/compra/controller/compra_controller.dart';
import 'package:precomedio/modules/compra/model/compra_ativo_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CompraAtivoForm extends StatelessWidget {
  final String compraId;
  const CompraAtivoForm({Key? key, required this.compraId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final compraProvider = context.watch<CompraController>();

    String _id = "";
    final GlobalKey<FormState> _formItemKey = GlobalKey<FormState>();
    final _ticketController = TextEditingController();
    final _quantidadeController = TextEditingController();
    final _valorController = TextEditingController();

    _submitForm(id, ticket, quantidade, valor) {
      CompraAtivo compraAtivo = CompraAtivo(
          id: id,
          compraId: compraId,
          ticket: ticket,
          quantidade: int.parse(quantidade),
          valor: double.parse(valor));

      compraProvider.addCompraAtivo(compraAtivo);
      Navigator.pop(context);
    }

    return SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            child: Form(
              key: _formItemKey,
              child: Column(
                children: <Widget>[
                  Row(children: [
                    Expanded(
                        child: TextFormField(
                            controller: _ticketController,
                            decoration: const InputDecoration(
                              hintText: 'Ticket',
                            ))),
                  ]),
                  Row(children: [
                    Expanded(
                        child: TextFormField(
                      controller: _quantidadeController,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      decoration: const InputDecoration(
                        hintText: 'Quantidade',
                      ),
                    ))
                  ]),
                  Row(children: [
                    Expanded(
                        child: TextFormField(
                      controller: _valorController,
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp('[0-9.,]')),
                      ],
                      decoration: const InputDecoration(
                        hintText: 'Valor total',
                      ),
                    )),
                  ]),
                  const SizedBox(height: 20),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    ElevatedButton(
                        onPressed: () => _submitForm(
                              _id,
                              _ticketController.text,
                              _quantidadeController.text,
                              _valorController.text,
                            ),
                        child: const Text('Adicionar')),
                    const SizedBox(width: 10),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(primary: Colors.yellow),
                        onPressed: () => {Navigator.pop(context)},
                        child: const Text('Fechar')),
                  ]),
                ],
              ),
            )));
  }
}
