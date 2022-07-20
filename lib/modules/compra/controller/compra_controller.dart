import 'dart:convert';
import 'dart:math';
import 'package:intl/intl.dart';

import 'package:precomedio/modules/compra/model/compra_model.dart';
import 'package:precomedio/modules/compra/model/compra_ativo_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class CompraController with ChangeNotifier {
  final _baseUrl = 'https://acoes-275f1-default-rtdb.firebaseio.com';

  final List<Compra> _items = [];
  final List<CompraAtivo> _ativoItems = [];

  List<Compra> get items {
    return [..._items];
  }

  List<CompraAtivo> getAtivoItems(String compraId) {
    List<CompraAtivo> _ativoItemsCompra = [];

    for (var element in _ativoItems) {
      if (element.compraId == compraId) {
        _ativoItemsCompra.add(element);
      }
    }

    return _ativoItemsCompra;
  }

  void showAll() {
    notifyListeners();
  }

  Future<void> addCompra(Compra compra) {
    final DateFormat formatter = DateFormat('dd/MM/yyyy');

    final future = http.post(Uri.parse('$_baseUrl/purchases.json'),
        body: jsonEncode({
          "data": formatter.format(compra.data),
          "valor": compra.valor.toDouble(),
          "taxas": compra.taxas.toDouble(),
          "observacao": compra.observacao
        }));
    return future.then((response) {
      final id = jsonDecode(response.body)['name'];
      _items.add(Compra(
          id: id,
          data: compra.data,
          valor: compra.valor,
          taxas: compra.taxas,
          observacao: compra.observacao));
      notifyListeners();
    });
  }

  Future<void> addCompraAtivo(CompraAtivo compraAtivo) {
    final future = http.post(Uri.parse('$_baseUrl/purchasesItems.json'),
        body: jsonEncode({
          "compraId": compraAtivo.compraId,
          "ticket": compraAtivo.ticket,
          "quantidade": compraAtivo.quantidade,
          "valor": compraAtivo.valor.toDouble()
        }));
    return future.then((response) {
      final id = jsonDecode(response.body)['name'];
      _ativoItems.add(CompraAtivo(
          id: id,
          compraId: compraAtivo.compraId,
          ticket: compraAtivo.ticket,
          quantidade: compraAtivo.quantidade,
          valor: compraAtivo.valor));

      updateValorCompra(compraAtivo.compraId, compraAtivo.valor);
      notifyListeners();
    });
  }

  Future<void> saveCompra(Map<String, Object> data) {
    bool hasId = data['id'] != null;

    final compra = Compra(
        id: hasId ? data['id'] as String : Random().nextDouble().toString(),
        data: data['codigo'] as DateTime,
        valor: data['valor'] as double,
        taxas: data['taxas'] as double,
        observacao: data['observacao'] as String);

    if (hasId) {
      return updateCompra(compra);
    } else {
      return addCompra(compra);
    }
  }

  Future<void> updateCompra(Compra compra) {
    int index = _items.indexWhere((p) => p.id == compra.id);

    if (index >= 0) {
      final future =
          http.patch(Uri.parse('$_baseUrl/purchases/${compra.id}.json'),
              body: jsonEncode({
                "data": compra.data,
                "valor": compra.valor,
                "taxas": compra.taxas,
                "observacao": compra.observacao
              }));
      return future.then((response) {
        _items[index] = compra;
        notifyListeners();
      });
    }
    return Future.value();
  }

  Future<void> updateValorCompra(String compraId, double valor) {
    int index = _items.indexWhere((p) => p.id == compraId);

    if (index >= 0) {
      final future = http.put(Uri.parse('$_baseUrl/purchases/$compraId.json'),
          body: jsonEncode({
            "valor": _items[index].valor + valor,
          }));
      return future.then((response) {
        Compra compra = Compra(
            id: _items[index].id,
            data: _items[index].data,
            valor: _items[index].valor + valor,
            taxas: _items[index].taxas,
            observacao: _items[index].observacao);

        _items[index] = compra;
        notifyListeners();
      });
    }
    return Future.value();
  }

  void removeCompra(Compra compra) {
    removeCompraById(compra.id);
  }

  Future<void> removeCompraById(String id) {
    int index = _items.indexWhere((p) => p.id == id);
    final future = http.delete(Uri.parse('$_baseUrl/purchases/$id.json'));

    if (index >= 0) {
      return future.then((response) {
        _items.removeWhere((p) => p.id == id);
        notifyListeners();
      });
    }
    return Future.value();
  }

  void removeCompraAtivo(CompraAtivo compraAtivo) {
    removeCompraAtivoById(compraAtivo.id);
  }

  Future<void> removeCompraAtivoById(String id) {
    int index = _ativoItems.indexWhere((p) => p.id == id);
    final future = http.delete(Uri.parse('$_baseUrl/purchasesItems/$id.json'));

    if (index >= 0) {
      return future.then((response) {
        _ativoItems.removeWhere((p) => p.id == id);
        updateValorCompra(
            _ativoItems[index].compraId, _ativoItems[index].valor * (-1.0));
        notifyListeners();
      });
    }
    return Future.value();
  }

  List<Compra> loadItems() {
    if (items.isEmpty) {
      final future = http.get(Uri.parse('$_baseUrl/purchases.json'));
      future.then((response) {
        if (response.body != "null") {
          final Map<String, dynamic> list = jsonDecode(response.body);
          list.forEach((key, value) {
            int index = _items.indexWhere((p) => p.id == key);

            if (index < 0) {
              _items.add(Compra(
                  id: key,
                  data: DateFormat('dd/MM/yyyy').parse(value['data']),
                  valor: value['valor'].toDouble(),
                  taxas: value['taxas'].toDouble(),
                  observacao: value['observacao']));
            }
          });
          notifyListeners();
        }
      });
    }

    return items;
  }

  List<CompraAtivo> loadAtivosCompraItems(String compraId) {
    final future = http.get(Uri.parse('$_baseUrl/purchasesItems.json'));
    future.then((response) {
      if (response.body != "null") {
        final Map<String, dynamic> list = jsonDecode(response.body);
        list.forEach((key, value) {
          int index = _ativoItems.indexWhere((p) => p.id == key);

          if (index < 0) {
            _ativoItems.add(CompraAtivo(
                id: key,
                compraId: value['compraId'],
                ticket: value['ticket'],
                quantidade: value['quantidade'],
                valor: value['valor'].toDouble()));
          }
        });
        notifyListeners();
      }
    });

    return getAtivoItems(compraId);
  }
}
