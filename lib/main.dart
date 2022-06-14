import 'dart:io';

import 'package:flutter/material.dart';
import 'package:precomedio/modules/app/view/lista_screen.dart';
import 'package:precomedio/modules/compra/view/compra_screen.dart';
import 'package:precomedio/modules/ticket/controller/ticket_controller.dart';
import 'package:precomedio/modules/ticket/view/ticket_add.dart';
import 'package:precomedio/modules/ticket/view/ticket_edit.dart';
import 'package:precomedio/modules/ticket/view/ticket_screen.dart';
import 'package:precomedio/modules/app/view/tabs_screen.dart';
import 'package:precomedio/utils/app_routes.dart';
import 'package:provider/provider.dart';

void main() async {
  HttpOverrides.global = MyHttpOverrides();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => TicketController(),
          ),
        ],
        child: MaterialApp(
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
                  headline1:
                      const TextStyle(color: Colors.grey, fontSize: 25))),
          initialRoute: '/',
          routes: {
            AppRoutes.HOME: (ctx) => const TabsScreen(),
            AppRoutes.LISTA: (ctx) => const ListaScreen(),
            AppRoutes.COMPRA: (ctx) => const CompraScreen(),
            AppRoutes.TICKET_LIST: (ctx) => const TicketScreen(),
            AppRoutes.TICKET_ADD: (ctx) => const TicketAddScreen(),
            AppRoutes.TICKET_EDIT: (ctx) => const TicketEditScreen(),
          },
        ));
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
