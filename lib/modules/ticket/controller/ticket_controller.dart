import 'dart:convert';
import 'dart:math';

import 'package:precomedio/data/dummy_data.dart';
import 'package:precomedio/modules/ticket/model/ticket_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class TicketController with ChangeNotifier {
  final _baseUrl = 'https://acoes-275f1-default-rtdb.firebaseio.com';

  final List<Ticket> _items = dummyTickets;

  List<Ticket> get items {
    return [..._items];
  }

  void showAll() {
    notifyListeners();
  }

  Future<void> addTicket(Ticket ticket) {
    final future = http.post(Uri.parse('$_baseUrl/tickets.json'),
        body: jsonEncode({
          "codigo": ticket.codigo,
          "empresa": ticket.empresa,
          "cnpj": ticket.cnpj
        }));
    return future.then((response) {
      final id = jsonDecode(response.body)['name'];
      _items.add(Ticket(
          id: id,
          codigo: ticket.codigo,
          empresa: ticket.empresa,
          cnpj: ticket.cnpj));
      notifyListeners();
    });
  }

  Future<void> saveTicket(Map<String, Object> data) {
    bool hasId = data['id'] != null;

    final ticket = Ticket(
        id: hasId ? data['id'] as String : Random().nextDouble().toString(),
        codigo: data['codigo'] as String,
        empresa: data['empresa'] as String,
        cnpj: data['cnpj'] as String);

    if (hasId) {
      return updateTicket(ticket);
    } else {
      return addTicket(ticket);
    }
  }

  Future<void> updateTicket(Ticket ticket) {
    int index = _items.indexWhere((p) => p.id == ticket.id);

    if (index >= 0) {
      _items[index] = ticket;
      notifyListeners();
    }
    return Future.value();
  }

  void removeTicket(Ticket ticket) {
    removeTicketById(ticket.id);
  }

  void removeTicketById(String id) {
    int index = _items.indexWhere((p) => p.id == id);

    if (index >= 0) {
      _items.removeWhere((p) => p.id == id);
      notifyListeners();
    }
  }
}
