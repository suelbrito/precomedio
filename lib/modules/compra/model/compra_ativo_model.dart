import 'package:precomedio/modules/ticket/model/ticket_model.dart';

class CompraAtivo {
  final String id;
  final String compraId;
  final String ticket;
  final int quantidade;
  final double valor;

  CompraAtivo(
      {required this.id,
      required this.compraId,
      required this.ticket,
      required this.quantidade,
      required this.valor});
}
