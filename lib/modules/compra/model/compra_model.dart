class Compra {
  final String id;
  final DateTime data;
  final double valor;
  final double taxas;
  final String observacao;

  Compra(
      {required this.id,
      required this.data,
      required this.valor,
      required this.taxas,
      required this.observacao});
}
