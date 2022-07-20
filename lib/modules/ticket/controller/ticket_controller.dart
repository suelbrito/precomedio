import 'dart:convert';
import 'dart:math';

import 'package:precomedio/modules/ticket/model/ticket_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class TicketController with ChangeNotifier {
  final _baseUrl = 'https://acoes-275f1-default-rtdb.firebaseio.com';

  final List<Ticket> _items = [];

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
      final future = http.patch(
          Uri.parse('$_baseUrl/tickets/${ticket.id}.json'),
          body: jsonEncode({
            "codigo": ticket.codigo,
            "empresa": ticket.empresa,
            "cnpj": ticket.cnpj
          }));
      return future.then((response) {
        _items[index] = ticket;
        notifyListeners();
      });
    }
    return Future.value();
  }

  void removeTicket(Ticket ticket) {
    removeTicketById(ticket.id);
  }

  Future<void> removeTicketById(String id) {
    int index = _items.indexWhere((p) => p.id == id);
    final future = http.delete(Uri.parse('$_baseUrl/tickets/$id.json'));

    if (index >= 0) {
      return future.then((response) {
        _items.removeWhere((p) => p.id == id);
        notifyListeners();
      });
    }
    return Future.value();
  }

  List<Ticket> loadItems() {
    if (items.isEmpty) {
      final future = http.get(Uri.parse('$_baseUrl/tickets.json'));
      future.then((response) {
        if (response.body != "null") {
          final Map<String, dynamic> list = jsonDecode(response.body);
          list.forEach((key, value) {
            int index = _items.indexWhere((p) => p.id == key);

            if (index < 0) {
              _items.add(Ticket(
                  id: key,
                  codigo: value['codigo'],
                  empresa: value['empresa'],
                  cnpj: value['cnpj']));
            }
          });
          notifyListeners();
        }
      });
    }

    return items;
  }

  double getPrecoMedioTicket(String ticket) {
    double precoMedio = 0.0;
    int quantidade = 0;
    double valor = 0.0;
    final future = http.get(Uri.parse('$_baseUrl/purchasesItems.json'));

    future.then((response) {
      if (response.body != "null") {
        final Map<String, dynamic> list = jsonDecode(response.body);
        list.forEach((key, value) {
          if (value['ticket'] == ticket) {
            quantidade += (value['quantidade'] as int);
            valor += (value['valor'] as double);
          }
        });

        if (quantidade > 0) {
          precoMedio = valor / quantidade.toDouble();
        }
      }
    });

    return precoMedio;
  }

  int getQuantidadeTicket(String ticket) {
    int quantidade = 0;
    final future = http.get(Uri.parse('$_baseUrl/purchasesItems.json'));

    future.then((response) {
      if (response.body != "null") {
        final Map<String, dynamic> list = jsonDecode(response.body);
        list.forEach((key, value) {
          if (value['ticket'] == ticket) {
            quantidade += (value['quantidade'] as int);
          }
        });
      }
    });

    return quantidade;
  }
}
