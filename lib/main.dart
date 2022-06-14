import 'package:flutter/material.dart';
import 'package:precomedio/screens/lista_screen.dart';
import 'package:precomedio/screens/compra_screen.dart';
import 'package:precomedio/screens/ticket_screen.dart';
import 'package:precomedio/screens/tabs_screen.dart';
import 'package:precomedio/utils/app_routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Preço médio',
      theme: ThemeData(
          colorScheme: ThemeData().colorScheme.copyWith(
                primary: Colors.cyan,
                secondary: Colors.amber,
                tertiary: Colors.cyan.shade900,
                inversePrimary: Colors.white,
              ),
          fontFamily: 'RobotoCondensed',
          textTheme: ThemeData().textTheme.copyWith(
              headline1: const TextStyle(color: Colors.grey, fontSize: 25))),
      initialRoute: '/',
      routes: {
        AppRoutes.HOME: (ctx) => const TabsScreen(),
        AppRoutes.LISTA: (ctx) => const ListaScreen(),
        AppRoutes.COMPRA: (ctx) => const CompraScreen(),
        AppRoutes.TICKET: (ctx) => const TicketScreen(),
      },
    );
  }
}
