import 'package:intl/intl.dart';
import 'package:flutter/services.dart';

import 'package:precomedio/modules/compra/controller/compra_controller.dart';
import 'package:precomedio/modules/compra/model/compra_model.dart';
import 'package:precomedio/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class CompraForm extends StatelessWidget {
  final Compra? compraModel;
  const CompraForm({Key? key, this.compraModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final compraProvider = context.watch<CompraController>();

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
          compraProvider.removeCompraById(id);
          Navigator.of(context).pushNamed(
            AppRoutes.COMPRA_LIST,
          );
        },
      );
      // set up the AlertDialog
      AlertDialog alert = AlertDialog(
        title: const Text("Confirmação"),
        content: const Text("Tem certeza que deseja excluir esta compra?"),
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

    var maskDateFormatter = MaskTextInputFormatter(
        mask: '##/##/####',
        filter: {"#": RegExp(r'[0-9]')},
        type: MaskAutoCompletionType.lazy);

    String _id = "";
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    final _dataController = TextEditingController();
    final _taxasController = TextEditingController();
    final _observacaoController = TextEditingController();
    final isEdit = (compraModel != null);
    double _valor = 0.0;
    var now = DateTime.now();
    var formatter = DateFormat('dd/MM/yyyy');

    if (isEdit) {
      String formattedDate = formatter.format(compraModel!.data);

      _id = compraModel!.id;
      _dataController.text = formattedDate;
      _taxasController.text = compraModel!.taxas.toString();
      _observacaoController.text = compraModel!.observacao;
      _valor = compraModel!.valor;
    } else {
      String formattedDate = formatter.format(now);

      _dataController.text = formattedDate;
    }

    _submitForm(id, data, valor, taxas, observacao) {
      bool isEdit = _id.isNotEmpty;

      Compra compra = Compra(
          id: id,
          data: DateFormat('dd/MM/yyyy').parse(data),
          valor: valor,
          taxas: double.parse(taxas),
          observacao: observacao);

      if (isEdit) {
        compraProvider.updateCompra(compra);
      } else {
        compraProvider.addCompra(compra);
      }

      Navigator.pop(context);
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
                            controller: _dataController,
                            decoration: const InputDecoration(
                              hintText: 'Data',
                            ),
                            inputFormatters: [maskDateFormatter])),
                  ]),
                  Row(children: [
                    Expanded(
                        child: TextFormField(
                      controller: _taxasController,
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp('[0-9.,]')),
                      ],
                      decoration: const InputDecoration(
                        hintText: 'Taxas',
                      ),
                    )),
                  ]),
                  Row(children: [
                    Expanded(
                        child: TextFormField(
                      controller: _observacaoController,
                      decoration: const InputDecoration(
                        hintText: 'Observação',
                      ),
                    )),
                  ]),
                  const SizedBox(height: 20),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    ElevatedButton(
                        onPressed: () => _submitForm(
                              _id,
                              _dataController.text,
                              _valor,
                              _taxasController.text,
                              _observacaoController.text,
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
